
package com.kuispbo;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;

public class Main {

    private static final int JUMLAH_SOAL = 10;
    private static final int WAKTU_PER_SOAL = 10;

    record Soal(
            int id,
            int pertemuan,
            String pertanyaan,
            String a,
            String b,
            String c,
            String d,
            String kunci
    ) {}

    record InputJawaban(String teks, long waktuInput) {}

    record Jawaban(
            Soal soal,
            String pilihan,
            boolean waktuHabis,
            boolean benar
    ) {}

    private static String env(String nama, String defaultValue) {
        String value = System.getenv(nama);
        return value == null ? defaultValue : value;
    }

    private static Connection koneksiDatabase() throws SQLException {
        String url = env(
                "DB_URL",
                "jdbc:postgresql://localhost:5432/kuis_pbo"
        );

        String user = env("DB_USER", "postgres");
        String password = env("DB_PASSWORD", "");

        return DriverManager.getConnection(url, user, password);
    }

    public static void main(String[] args) {
        tampilkanHeader();

        try (BufferedReader console = new BufferedReader(
                new InputStreamReader(System.in))) {

            try (Connection conn = koneksiDatabase()) {
                jalankanKuis(conn, console);
            } catch (SQLException e) {
                System.out.println();
                System.out.println("GAGAL MENGAKSES DATABASE");
                System.out.println("Periksa hal berikut:");
                System.out.println("1. PostgreSQL sudah berjalan.");
                System.out.println("2. Database kuis_pbo sudah dibuat.");
                System.out.println("3. Tabel dan 100 soal sudah diimpor.");
                System.out.println("4. Username dan password PostgreSQL benar.");
                System.out.println();
                System.out.println("Detail error: " + e.getMessage());
            }

        } catch (IOException e) {
            System.out.println("Terjadi kesalahan saat membaca terminal.");
            System.out.println("Detail: " + e.getMessage());
        }
    }

    private static void tampilkanHeader() {
        System.out.println("==========================================");
        System.out.println("           KUIS PBO - JAVA");
        System.out.println("==========================================");
        System.out.println("Bank soal       : 100 soal");
        System.out.println("Soal per peserta: 10 soal acak");
        System.out.println("Waktu per soal  : 7 detik");
        System.out.println("Pilihan         : A, B, C, D");
        System.out.println("==========================================");
    }

    private static void jalankanKuis(
            Connection conn,
            BufferedReader console
    ) throws SQLException, IOException {

        if (jumlahSoal(conn) < JUMLAH_SOAL) {
            System.out.println();
            System.out.println("Bank soal belum memiliki minimal 10 soal aktif.");
            System.out.println("Jalankan database/schema.sql dan");
            System.out.println("database/seed_questions.sql terlebih dahulu.");
            return;
        }

        System.out.println();
        System.out.print("Nama mahasiswa: ");
        String nama = console.readLine();

        System.out.print("NIM mahasiswa : ");
        String nim = console.readLine();

        if (nama == null || nama.isBlank()
                || nim == null || nim.isBlank()) {
            System.out.println("Nama dan NIM wajib diisi.");
            return;
        }

        nama = nama.trim();
        nim = nim.trim();

        List<Soal> daftarSoal = ambilSoalAcak(conn);
        long idPercobaan = buatPercobaan(conn, nama, nim);

        System.out.println();
        System.out.println("Nama : " + nama);
        System.out.println("NIM  : " + nim);
        System.out.println();
        System.out.println("Aturan kuis:");
        System.out.println("- Jawab menggunakan A, B, C, atau D.");
        System.out.println("- Waktu setiap soal adalah 7 detik.");
        System.out.println("- Jika waktu habis, soal dilewati.");
        System.out.println("- Jawaban yang sudah dikirim tidak dapat diubah.");
        System.out.println();
        System.out.print("Tekan ENTER untuk memulai kuis...");
        console.readLine();

        BlockingQueue<InputJawaban> antrean =
                new LinkedBlockingQueue<>();

        AtomicBoolean membacaInput = new AtomicBoolean(true);

        BufferedReader pembacaJawaban = console;

        Thread threadInput = new Thread(() -> {
            try {
                while (membacaInput.get()) {
                    String baris = pembacaJawaban.readLine();

                    if (baris == null) {
                        break;
                    }

                    antrean.offer(new InputJawaban(
                            baris.trim().toUpperCase(Locale.ROOT),
                            System.nanoTime()
                    ));
                }
            } catch (IOException e) {
                // Thread input dihentikan jika terminal ditutup.
            }
        });

        threadInput.setDaemon(true);
        threadInput.start();

        List<Jawaban> hasilJawaban = new ArrayList<>();
        Instant waktuMulai = Instant.now();

        for (int i = 0; i < daftarSoal.size(); i++) {
            Soal soal = daftarSoal.get(i);

            System.out.println();
            System.out.println("------------------------------------------");
            System.out.printf(
                    "SOAL %d DARI %d | PERTEMUAN %d%n",
                    i + 1, daftarSoal.size(), soal.pertemuan()
            );
            System.out.println("------------------------------------------");
            System.out.println(soal.pertanyaan());
            System.out.println("A. " + soal.a());
            System.out.println("B. " + soal.b());
            System.out.println("C. " + soal.c());
            System.out.println("D. " + soal.d());
            System.out.println();

            System.out.print("Jawaban [A/B/C/D]: ");
            System.out.flush();

            long tenggat = System.nanoTime()
                    + TimeUnit.SECONDS.toNanos(WAKTU_PER_SOAL);

            String pilihan = null;
            boolean waktuHabis = false;

            while (pilihan == null) {
                long sisaWaktu = tenggat - System.nanoTime();

                if (sisaWaktu <= 0) {
                    waktuHabis = true;
                    break;
                }

                try {
                    InputJawaban input = antrean.poll(
                            sisaWaktu,
                            TimeUnit.NANOSECONDS
                    );

                    if (input == null) {
                        waktuHabis = true;
                        break;
                    }

                    if (input.waktuInput() > tenggat) {
                        continue;
                    }

                    if (Set.of("A", "B", "C", "D")
                            .contains(input.teks())) {
                        pilihan = input.teks();
                    } else {
                        System.out.println(
                                "Input tidak valid. Gunakan A, B, C, atau D."
                        );
                        System.out.print("Jawaban [A/B/C/D]: ");
                        System.out.flush();
                    }

                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    waktuHabis = true;
                    break;
                }
            }

            boolean benar = pilihan != null
                    && pilihan.equals(soal.kunci());

            Jawaban jawaban = new Jawaban(
                    soal, pilihan, waktuHabis, benar
            );

            hasilJawaban.add(jawaban);

            if (waktuHabis && pilihan == null) {
                System.out.println();
                System.out.println("WAKTU HABIS! Soal dilewati.");
            } else {
                System.out.println("Jawaban diterima.");
            }

            simpanJawaban(conn, idPercobaan, i + 1, jawaban);
        }

        membacaInput.set(false);

        int benar = (int) hasilJawaban.stream()
                .filter(Jawaban::benar)
                .count();

        int tidakDijawab = (int) hasilJawaban.stream()
                .filter(j -> j.pilihan() == null)
                .count();

        int salah = JUMLAH_SOAL - benar - tidakDijawab;
        double nilai = benar * 100.0 / JUMLAH_SOAL;

        selesaikanPercobaan(
                conn, idPercobaan, benar, salah, tidakDijawab, nilai
        );

        tampilkanHasil(
                nama, nim, benar, salah, tidakDijawab,
                nilai, waktuMulai
        );
    }

    private static int jumlahSoal(Connection conn)
            throws SQLException {

        String sql =
                "SELECT COUNT(*) FROM questions WHERE active = TRUE";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            rs.next();
            return rs.getInt(1);
        }
    }

    private static List<Soal> ambilSoalAcak(Connection conn)
            throws SQLException {

        List<Soal> daftar = new ArrayList<>();

        String sql = """
                SELECT id, meeting_no, question_text,
                       option_a, option_b, option_c, option_d,
                       correct_option
                FROM questions
                WHERE active = TRUE
                ORDER BY random()
                LIMIT ?
                """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, JUMLAH_SOAL);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    daftar.add(new Soal(
                            rs.getInt("id"),
                            rs.getInt("meeting_no"),
                            rs.getString("question_text"),
                            rs.getString("option_a"),
                            rs.getString("option_b"),
                            rs.getString("option_c"),
                            rs.getString("option_d"),
                            rs.getString("correct_option").trim()
                    ));
                }
            }
        }

        if (daftar.size() != JUMLAH_SOAL) {
            throw new SQLException(
                    "Jumlah soal aktif tidak mencukupi."
            );
        }

        return daftar;
    }

    private static long buatPercobaan(
            Connection conn,
            String nama,
            String nim
    ) throws SQLException {

        String sql = """
                INSERT INTO quiz_attempts
                    (student_name, student_nim, total_questions)
                VALUES (?, ?, ?)
                RETURNING id
                """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nama);
            ps.setString(2, nim);
            ps.setInt(3, JUMLAH_SOAL);

            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getLong("id");
            }
        }
    }

    private static void simpanJawaban(
            Connection conn,
            long idPercobaan,
            int urutan,
            Jawaban jawaban
    ) throws SQLException {

        String sql = """
                INSERT INTO attempt_answers
                    (attempt_id, question_id, question_order,
                     selected_option, is_correct, timed_out, answered_at)
                VALUES (?, ?, ?, ?, ?, ?, CASE WHEN ? THEN NULL ELSE NOW() END)
                """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, idPercobaan);
            ps.setInt(2, jawaban.soal().id());
            ps.setInt(3, urutan);

            if (jawaban.pilihan() == null) {
                ps.setNull(4, Types.CHAR);
            } else {
                ps.setString(4, jawaban.pilihan());
            }

            ps.setBoolean(5, jawaban.benar());
            ps.setBoolean(6, jawaban.waktuHabis());
            ps.setBoolean(7, jawaban.waktuHabis());

            ps.executeUpdate();
        }
    }

    private static void selesaikanPercobaan(
            Connection conn,
            long idPercobaan,
            int benar,
            int salah,
            int kosong,
            double nilai
    ) throws SQLException {

        String sql = """
                UPDATE quiz_attempts
                SET finished_at = NOW(),
                    correct_count = ?,
                    wrong_count = ?,
                    unanswered_count = ?,
                    score = ?
                WHERE id = ?
                """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, benar);
            ps.setInt(2, salah);
            ps.setInt(3, kosong);
            ps.setDouble(4, nilai);
            ps.setLong(5, idPercobaan);
            ps.executeUpdate();
        }
    }

    private static void tampilkanHasil(
            String nama,
            String nim,
            int benar,
            int salah,
            int kosong,
            double nilai,
            Instant waktuMulai
    ) {
        System.out.println();
        System.out.println("==========================================");
        System.out.println("                HASIL KUIS");
        System.out.println("==========================================");
        System.out.println("Nama          : " + nama);
        System.out.println("NIM           : " + nim);
        System.out.println("Jawaban benar : " + benar);
        System.out.println("Jawaban salah : " + salah);
        System.out.println("Tidak dijawab : " + kosong);
        System.out.printf(
                Locale.US, "Nilai         : %.2f / 100%n", nilai
        );
        System.out.println(
                "Durasi        : "
                + Duration.between(waktuMulai, Instant.now()).toSeconds()
                + " detik"
        );
        System.out.println("Hasil tersimpan di PostgreSQL.");
        System.out.println("==========================================");
    }
}
