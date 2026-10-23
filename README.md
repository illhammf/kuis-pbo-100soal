# Kuis PBO — 100 Soal

Aplikasi kuis berbasis **Java Console** untuk bahan ajar dan evaluasi dasar mata kuliah **Pemrograman Berorientasi Objek (PBO) 2026**. Aplikasi mengambil soal dari PostgreSQL, memilih 10 soal secara acak untuk setiap percobaan, memberi waktu 10 detik per soal, dan menyimpan hasil kuis ke database.

> Proyek ini adalah bahan ajar/alat bantu kuis lokal. Tinjau dan sesuaikan bank soal dengan RPS, slide, dan materi resmi dosen sebelum dipakai untuk penilaian formal.

## Fitur

- Input nama dan NIM sebelum kuis dimulai.
- Pilihan ganda A, B, C, dan D.
- Bank soal dasar sebanyak 100 soal, dengan 20 soal untuk setiap kelompok pertemuan 1–5.
- Memilih 10 soal aktif secara acak dari PostgreSQL.
- Waktu 10 detik per soal.
- Menyimpan percobaan, jawaban, jumlah benar/salah/tidak dijawab, dan nilai.
- Data hasil tersimpan secara persisten di PostgreSQL.
- Bisa dijalankan melalui terminal PowerShell di Visual Studio Code.

## Teknologi

| Teknologi | Kegunaan |
|---|---|
| Java 17 atau lebih baru | Bahasa aplikasi |
| Maven | Build dan pengelolaan dependency |
| PostgreSQL | Penyimpanan soal dan hasil |
| PostgreSQL JDBC Driver | Koneksi Java ke PostgreSQL |
| pgAdmin 4 | Mengelola database dan menjalankan SQL |
| Visual Studio Code | Editor dan terminal |

## Materi soal

| Pertemuan | Pokok bahasan |
|---|---|
| 1 | Pengantar PBO, class, object, attribute, method, constructor, konsep OOP |
| 2 | Variabel, tipe data, komentar, output, operator dasar |
| 3 | Percabangan `if`, `else`, `switch`, dan kondisi boolean |
| 4 | Method, parameter, argumen, `void`, `return`, rekursi dasar |
| 5 | Encapsulation, `private`, `public`, getter, setter |

Bank soal ini adalah materi pengantar. Cocokkan dengan slide resmi perkuliahan yang digunakan. Setiap kelompok berisi 20 soal; aplikasi mengambil 10 soal acak dari semua soal aktif, bukan menjamin dua soal dari setiap pertemuan.

## Struktur proyek

```text
kuis-pbo-100soal/
├── pom.xml
├── README.md
├── LICENSE
├── AUTHOR.md
├── database/
│   ├── schema.sql
│   └── seed_questions.sql
└── src/
    └── main/
        └── java/
            └── com/
                └── kuispbo/
                    └── Main.java
```

Sesuaikan nama/lokasi file SQL dengan struktur project yang ada di komputer.

## Persyaratan

1. Java JDK 17 atau lebih baru.
2. Maven terpasang dan perintah `mvn` tersedia di PowerShell.
3. PostgreSQL terpasang dan servicenya berjalan.
4. Database `kuis_pbo` sudah dibuat.
5. Tabel dan 100 soal sudah dimasukkan.
6. Username dan password PostgreSQL benar.

Periksa Java dan Maven:

```powershell
java -version
mvn -version
```

## Setup pertama kali

### 1. Buat database

Buka pgAdmin 4 dan hubungkan ke server PostgreSQL. Buat database bernama `kuis_pbo` jika belum ada. Jangan membuat database baru jika database itu sudah tersedia.

### 2. Buat tabel

Pilih database `kuis_pbo`, buka **Query Tool**, lalu jalankan isi `database/schema.sql` dengan menekan F5.

Skema harus memiliki tabel:

- `questions` — bank soal dan kunci jawaban.
- `quiz_attempts` — identitas peserta dan ringkasan nilai.
- `attempt_answers` — jawaban untuk tiap soal pada setiap percobaan.

Jika tabel sudah ada, tidak perlu membuatnya ulang.

### 3. Masukkan bank soal

Buka `database/seed_questions.sql`, salin isi SQL ke Query Tool pada database `kuis_pbo`, kemudian tekan F5. Pastikan hasil pemeriksaan menunjukkan 100 soal aktif, dengan 20 soal per pertemuan.

Seed yang memakai `ON CONFLICT (id) DO UPDATE` akan memperbarui soal dengan ID yang sama. Periksa file SQL sebelum menjalankan seed lain yang mungkin menggunakan ID atau skema berbeda.

## Menjalankan kuis setelah komputer dimatikan

Setelah setup pertama kali selesai, langkah berikut cukup dilakukan setiap kali akan menggunakan aplikasi.

### 1. Nyalakan PostgreSQL

- Buka pgAdmin 4 dari menu Start Windows.
- Hubungkan ke server PostgreSQL.
- Pastikan database `kuis_pbo` tersedia.

Biasanya PostgreSQL berjalan sebagai Windows service. Jika pgAdmin tidak dapat terhubung, periksa service PostgreSQL dari aplikasi **Services** di Windows.

### 2. Buka project di VS Code

Pilih **File → Open Folder**, kemudian buka folder project. Contoh lokasi:

```text
C:\Dokumen\kuis-pbo-100soal
```

### 3. Buka terminal PowerShell

Pilih **Terminal → New Terminal**. Pastikan terminal berada di folder project. Jika belum, jalankan:

```powershell
cd C:\Dokumen\kuis-pbo-100soal
```

Sesuaikan path jika folder project ada di lokasi lain.

### 4. Isi konfigurasi koneksi

Aplikasi membaca tiga environment variables:

| Variabel | Contoh |
|---|---|
| `DB_URL` | `jdbc:postgresql://localhost:5432/kuis_pbo` |
| `DB_USER` | `postgres` |
| `DB_PASSWORD` | Password server PostgreSQL milik pengguna |

Jalankan perintah berikut di terminal PowerShell yang baru:

```powershell
$env:DB_URL="jdbc:postgresql://localhost:5432/kuis_pbo"
$env:DB_USER="postgres"
$env:DB_PASSWORD="ISI_PASSWORD_POSTGRES_KAMU"
```

Ganti nilai terakhir dengan password PostgreSQL yang sebenarnya. Jangan commit password ke GitHub atau menaruhnya di README maupun `Main.java`. Variabel `$env:` hanya berlaku di terminal saat ini, jadi perlu diatur ulang ketika membuka terminal baru.

### 5. Jalankan aplikasi

```powershell
mvn compile exec:java
```

Jika ingin melakukan kompilasi bersih untuk membantu diagnosis error:

```powershell
mvn clean compile exec:java
```

Perintah `clean` hanya menghapus hasil build di folder `target`, bukan data PostgreSQL.

### 6. Mulai kuis

- Masukkan nama mahasiswa.
- Masukkan NIM.
- Tekan Enter untuk memulai.
- Jawab dengan `A`, `B`, `C`, atau `D`, lalu tekan Enter sebelum waktu habis.

Aturan saat ini adalah 10 soal per percobaan dan 10 detik per soal. Waktu ideal untuk menjawab seluruh soal adalah 100 detik, belum termasuk waktu memasukkan identitas dan jeda antarsoal. Uji timer pada terminal yang akan digunakan sebelum kuis resmi.

## Melihat hasil mahasiswa

Jalankan query berikut di Query Tool database `kuis_pbo`:

```sql
SELECT
    student_name,
    student_nim,
    correct_count,
    wrong_count,
    unanswered_count,
    score,
    started_at,
    finished_at
FROM quiz_attempts
ORDER BY started_at DESC;
```

Untuk melihat detail jawaban:

```sql
SELECT
    qa.student_name,
    qa.student_nim,
    aa.question_order,
    q.meeting_no,
    q.question_text,
    aa.selected_option,
    aa.is_correct,
    aa.timed_out
FROM attempt_answers AS aa
JOIN quiz_attempts AS qa ON qa.id = aa.attempt_id
JOIN questions AS q ON q.id = aa.question_id
ORDER BY qa.started_at DESC, aa.question_order;
```

## Menghapus hasil kuis

**Peringatan:** penghapusan data bersifat destruktif. Pastikan riwayat lama sudah tidak diperlukan atau sudah dicadangkan.

Hapus seluruh riwayat percobaan dan jawaban tetapi pertahankan bank soal:

```sql
TRUNCATE TABLE attempt_answers, quiz_attempts
RESTART IDENTITY CASCADE;
```

Hapus hasil satu mahasiswa berdasarkan NIM:

```sql
DELETE FROM quiz_attempts
WHERE student_nim = 'GANTI_DENGAN_NIM';
```

Jawaban terkait akan ikut terhapus karena foreign key menggunakan `ON DELETE CASCADE`.

Jangan jalankan perintah ini kecuali memang ingin menghapus bank soal juga:

```sql
TRUNCATE TABLE attempt_answers, quiz_attempts, questions
RESTART IDENTITY CASCADE;
```

## Pemecahan masalah

### Password PostgreSQL kosong

Error seperti `The server requested SCRAM-based authentication, but the password is an empty string` berarti variabel `DB_PASSWORD` belum terisi pada terminal yang digunakan. Atur kembali environment variable dan jalankan ulang.

### Tabel `questions` tidak ditemukan

Pastikan Query Tool terhubung ke database `kuis_pbo` dan `database/schema.sql` telah dijalankan.

### Soal aktif kurang dari 10

Jalankan `database/seed_questions.sql`, kemudian periksa:

```sql
SELECT COUNT(*)
FROM questions
WHERE active = TRUE;
```

Target bank soal adalah 100 soal aktif.

### PostgreSQL tidak bisa dihubungi

Pastikan service berjalan, port sesuai (umumnya `5432`), nama database benar, dan kredensial valid.

### Perintah `mvn` tidak dikenali

Pastikan Maven terpasang dan folder `bin` Maven sudah ada di PATH. Buka terminal baru setelah mengubah PATH.

## Tujuan pembelajaran

Proyek ini dapat dipakai untuk mempelajari:

- Java Console dan pengelompokan kode ke method.
- Record dan koleksi Java.
- Pengambilan soal acak.
- Input pengguna dan timer.
- JDBC dan `PreparedStatement`.
- Relasi tabel serta foreign key.
- Penyimpanan hasil kuis dan evaluasi nilai.

## Ide pengembangan

- Rekap nilai dan ekspor CSV.
- Filter soal berdasarkan pertemuan.
- Pengacakan urutan pilihan.
- Validasi NIM.
- Konfigurasi jumlah soal dan waktu tanpa mengubah kode.
- Transaksi database untuk menyimpan satu percobaan.
- Pengujian timer dan input pada beberapa lingkungan terminal.

## Lisensi

Proyek ini menggunakan MIT License. Lihat [LICENSE](LICENSE).

## Author

Lihat [AUTHOR.md](AUTHOR.md).
