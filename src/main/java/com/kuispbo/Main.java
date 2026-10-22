package com.kuispbo;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.sql.*;
import java.time.Duration;
import java.time.Instant;
import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicBoolean;

public class Main {
    private static final int QUESTION_COUNT = 10;
    private static final int SECONDS_PER_QUESTION = 7;
    private static final Random RANDOM = new Random();

    record Question(int id, int meeting, String text, String a, String b, String c, String d, String correct) {
        String option(String key) {
            return switch (key) {
                case "A" -> a; case "B" -> b; case "C" -> c; case "D" -> d; default -> "";
            };
        }
    }
    record TimedLine(String text, long nanoTime) {}
    record Answer(Question question, String selected, boolean timedOut, boolean correct) {}

    private static Connection connect() throws SQLException {
        String url = env("DB_URL", "jdbc:postgresql://localhost:5432/kuis_pbo");
        String user = env("DB_USER", "postgres");
        String password = env("DB_PASSWORD", "");
        return DriverManager.getConnection(url, user, password);
    }

    private static String env(String key, String fallback) {
        String value = System.getenv(key);
        return value == null ? fallback : value;
    }

    public static void main(String[] args) {
        System.out.println("========================================");
        System.out.println("       KUIS PBO - 100 BANK SOAL");
        System.out.println("========================================");
        System.out.println("10 soal acak | 7 detik per soal | Pilihan A-D");
        System.out.println("Pastikan PostgreSQL aktif dan schema + bank soal sudah diimpor.");

        try (Connection conn = connect()) {
            BufferedReader console =
                    new BufferedReader(new InputStreamReader(System.in));

            if (countQuestions(conn) < QUESTION_COUNT) {
                System.out.println(
                    "Bank soal belum berisi minimal 10 soal. Jalankan database/schema.sql dan database/seed_questions.sql."
                );
                return;
            }
            System.out.print("\nNama mahasiswa: ");
            String name = console.readLine().trim();
            System.out.print("NIM mahasiswa : ");
            String nim = console.readLine().trim();
            if (name.isBlank() || nim.isBlank()) {
                System.out.println("Nama dan NIM wajib diisi. Kuis dibatalkan.");
                return;
            }
            List<Question> selected = chooseQuestions(conn);
            long attemptId = createAttempt(conn, name, nim);
            System.out.println("\nMahasiswa : " + name);
            System.out.println("NIM       : " + nim);
            System.out.println("Kuis akan dimulai. Tekan ENTER untuk mulai...");
            console.readLine();

            // Pembaca input berjalan satu kali sepanjang kuis; timestamp membantu menolak input yang terlambat.
            BlockingQueue<TimedLine> inputQueue = new LinkedBlockingQueue<>();
            AtomicBoolean reading = new AtomicBoolean(true);
            Thread inputThread = new Thread(() -> {
                BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
                try {
                    while (reading.get()) {
                        String line = reader.readLine();
                        if (line == null) break;
                        inputQueue.offer(new TimedLine(line.trim().toUpperCase(Locale.ROOT), System.nanoTime()));
                    }
                } catch (Exception ignored) { }
            }, "quiz-input-reader");
            inputThread.setDaemon(true);
            inputThread.start();

            List<Answer> answers = new ArrayList<>();
            Instant started = Instant.now();
            for (int i = 0; i < selected.size(); i++) {
                Question q = selected.get(i);
                System.out.println("\n----------------------------------------");
                System.out.printf("SOAL %d/%d | Pertemuan %d | Waktu %d detik%n",
                        i + 1, selected.size(), q.meeting(), SECONDS_PER_QUESTION);
                System.out.println(q.text());
                System.out.println("A. " + q.a());
                System.out.println("B. " + q.b());
                System.out.println("C. " + q.c());
                System.out.println("D. " + q.d());
                System.out.print("Jawaban [A/B/C/D]: ");
                System.out.flush();

                long deadline = System.nanoTime() + TimeUnit.SECONDS.toNanos(SECONDS_PER_QUESTION);
                String chosen = null;
                boolean timedOut = false;
                while (System.nanoTime() < deadline && chosen == null) {
                    long remaining = deadline - System.nanoTime();
                    try {
                        TimedLine line = inputQueue.poll(Math.max(1, remaining), TimeUnit.NANOSECONDS);
                        if (line == null) break;
                        if (line.nanoTime() > deadline) continue;
                        if (Set.of("A","B","C","D").contains(line.text())) {
                            chosen = line.text();
                        } else {
                            System.out.println("\nInput tidak valid. Gunakan A, B, C, atau D.");
                            System.out.print("Jawaban [A/B/C/D]: ");
                            System.out.flush();
                        }
                    } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                        break;
                    }
                }
                if (chosen == null) {
                    timedOut = true;
                    System.out.println("\nWaktu habis! Jawaban dilewati.");
                }
                boolean correct = chosen != null && chosen.equals(q.correct());
                answers.add(new Answer(q, chosen, timedOut, correct));
                if (chosen != null) System.out.println("Jawaban diterima. Lanjut...");
                saveAnswer(conn, attemptId, i + 1, answers.get(i));
            }
            reading.set(false);
            int correct = (int) answers.stream().filter(Answer::correct).count();
            int unanswered = (int) answers.stream().filter(a -> a.selected() == null).count();
            int wrong = QUESTION_COUNT - correct - unanswered;
            double score = correct * 100.0 / QUESTION_COUNT;
            finishAttempt(conn, attemptId, correct, wrong, unanswered, score);
            System.out.println("\n========================================");
            System.out.println("              HASIL KUIS");
            System.out.println("========================================");
            System.out.println("Nama            : " + name);
            System.out.println("NIM             : " + nim);
            System.out.println("Benar           : " + correct);
            System.out.println("Salah           : " + wrong);
            System.out.println("Tidak dijawab   : " + unanswered);
            System.out.printf(Locale.US, "Nilai           : %.2f / 100%n", score);
            System.out.println("Durasi          : " + Duration.between(started, Instant.now()).toSeconds() + " detik");
            System.out.println("Hasil tersimpan di PostgreSQL.");
            System.out.println("========================================");
        } catch (SQLException e) {
            System.out.println("\nGagal terhubung/menulis ke PostgreSQL.");
            System.out.println("Periksa DB_URL, DB_USER, DB_PASSWORD dan pastikan schema serta bank soal sudah dibuat.");
            System.out.println("Detail: " + e.getMessage());
        }
    }

    private static int countQuestions(Connection c) throws SQLException {
        try (PreparedStatement ps = c.prepareStatement("SELECT COUNT(*) FROM questions WHERE active=TRUE");
             ResultSet rs = ps.executeQuery()) {
            rs.next(); return rs.getInt(1);
        }
    }

    private static List<Question> chooseQuestions(Connection c) throws SQLException {
        List<Question> all = new ArrayList<>();
        String sql = "SELECT id, meeting_no, question_text, option_a, option_b, option_c, option_d, correct_option " +
                     "FROM questions WHERE active=TRUE ORDER BY random() LIMIT ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, QUESTION_COUNT);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) all.add(new Question(rs.getInt(1), rs.getInt(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8).trim()));
            }
        }
        if (all.size() != QUESTION_COUNT) throw new SQLException("Bank soal tidak cukup.");
        return all;
    }

    private static long createAttempt(Connection c, String name, String nim) throws SQLException {
        String sql = "INSERT INTO quiz_attempts(student_name, student_nim, total_questions) VALUES (?,?,?) RETURNING id";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, name); ps.setString(2, nim); ps.setInt(3, QUESTION_COUNT);
            try (ResultSet rs = ps.executeQuery()) { rs.next(); return rs.getLong(1); }
        }
    }

    private static void saveAnswer(Connection c, long attemptId, int order, Answer a) throws SQLException {
        String sql = "INSERT INTO attempt_answers(attempt_id, question_id, question_order, selected_option, is_correct, timed_out, answered_at) " +
                     "VALUES (?,?,?,?,?,?,CASE WHEN ? THEN NULL ELSE NOW() END)";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, attemptId); ps.setInt(2, a.question().id()); ps.setInt(3, order);
            if (a.selected() == null) ps.setNull(4, Types.CHAR); else ps.setString(4, a.selected());
            ps.setBoolean(5, a.correct()); ps.setBoolean(6, a.timedOut()); ps.setBoolean(7, a.timedOut());
            ps.executeUpdate();
        }
    }

    private static void finishAttempt(Connection c, long id, int correct, int wrong, int unanswered, double score) throws SQLException {
        String sql = "UPDATE quiz_attempts SET finished_at=NOW(), correct_count=?, wrong_count=?, unanswered_count=?, score=? WHERE id=?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, correct); ps.setInt(2, wrong); ps.setInt(3, unanswered); ps.setDouble(4, score); ps.setLong(5, id);
            ps.executeUpdate();
        }
    }
}
