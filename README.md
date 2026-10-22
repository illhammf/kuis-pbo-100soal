# Kuis PBO - 100 Soal

Aplikasi kuis Java Console untuk materi PBO pertemuan 1–5, dengan PostgreSQL.

## Fitur
- Bank 100 soal: 20 soal per pertemuan.
- Setiap peserta mendapat 10 soal acak dari bank aktif.
- 7 detik per soal (maksimal 70 detik untuk waktu soal; input identitas dan konfirmasi tidak termasuk).
- Pilihan jawaban A/B/C/D.
- Jawaban kosong saat waktu habis; penilaian otomatis.
- Simpan percobaan dan jawaban ke PostgreSQL.
- Skor = jumlah benar / 10 × 100.

## Kebutuhan
- JDK 17 atau lebih baru.
- Maven.
- PostgreSQL aktif.

## 1. Buat database
Masuk ke `psql` atau pgAdmin, lalu jalankan:

```sql
CREATE DATABASE kuis_pbo;
```

Pilih database `kuis_pbo`, kemudian jalankan SQL berikut berurutan:
1. `database/schema.sql`
2. `database/seed_questions.sql`

Contoh lewat terminal (Linux/macOS; sesuaikan nama user PostgreSQL):

```bash
psql -U postgres -d kuis_pbo -f database/schema.sql
psql -U postgres -d kuis_pbo -f database/seed_questions.sql
```

Di Windows PowerShell, perintahnya juga bisa dijalankan jika `psql` ada di PATH. Alternatifnya, buka file SQL di pgAdmin Query Tool dan jalankan pada database `kuis_pbo`.

## 2. Atur koneksi PostgreSQL
Default koneksi:
- URL: `jdbc:postgresql://localhost:5432/kuis_pbo`
- User: `postgres`
- Password: kosong

Sebaiknya atur kredensial lewat environment variables, jangan menaruh password di source code.

PowerShell:
```powershell
$env:DB_URL="jdbc:postgresql://localhost:5432/kuis_pbo"
$env:DB_USER="postgres"
$env:DB_PASSWORD="PASSWORD_POSTGRES_KAMU"
```

Linux/macOS:
```bash
export DB_URL="jdbc:postgresql://localhost:5432/kuis_pbo"
export DB_USER="postgres"
export DB_PASSWORD="PASSWORD_POSTGRES_KAMU"
```

## 3. Jalankan aplikasi
Buka terminal pada folder `kuis-pbo-100soal`, lalu:

```bash
mvn compile exec:java
```

Saat diminta, masukkan nama dan NIM, lalu tekan ENTER untuk memulai. Jawab dengan A, B, C, atau D dan tekan ENTER sebelum 7 detik habis.

## 4. Melihat hasil
Rekap nilai:

```sql
SELECT student_name, student_nim, correct_count, wrong_count,
       unanswered_count, score, started_at, finished_at
FROM quiz_attempts
ORDER BY started_at DESC;
```

Melihat detail jawaban:

```sql
SELECT a.student_name, a.student_nim, aa.question_order,
       q.meeting_no, q.question_text, aa.selected_option,
       q.correct_option, aa.is_correct, aa.timed_out
FROM attempt_answers aa
JOIN quiz_attempts a ON a.id = aa.attempt_id
JOIN questions q ON q.id = aa.question_id
ORDER BY a.started_at DESC, aa.question_order;
```

## Catatan timer terminal
Aplikasi memakai pembaca input latar belakang dan timestamp input untuk mengabaikan jawaban yang tiba setelah tenggat soal. Terminal/IDE tertentu dapat memiliki perilaku input berbeda; uji dulu di terminal yang akan dipakai saat kuis.

## Catatan kualitas materi
Bank soal disusun dari PPT/PDF yang diberikan:
1. Introduction to Object Oriented Programming
2. Data Type, Variable, Method and Expression
3. Control Statement
4. Function and Parameter
5. Encapsulation with Class (Concept)

PPT sesi 4 menggunakan istilah value/reference parameter. Soal di sini dibatasi pada konsep dasar dan tidak menyatakan bahwa semua object Java secara teknis dipassing by-reference; Java selalu meneruskan argumen by-value, termasuk nilai referensi objek.
