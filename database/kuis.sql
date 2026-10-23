
-- BANK SOAL PBO PEMULA: 100 SOAL
-- Jalankan pada database kuis_pbo.
-- Mempertahankan ID agar riwayat jawaban yang sudah ada tidak terputus.

INSERT INTO questions
    (id, meeting_no, question_text, option_a, option_b, option_c, option_d, correct_option, active)
VALUES
(1, 1, 'Apa kepanjangan OOP?', 'Open Output Program', 'Object Order Process', 'Online Object Platform', 'Object Oriented Programming', 'D', TRUE),
(2, 1, 'Dalam PBO, class adalah ...', 'Perintah untuk mengulang kode', 'Cetak biru untuk membuat objek', 'Tipe komentar', 'Nama database', 'B', TRUE),
(3, 1, 'Object adalah ...', 'Operator matematika', 'Baris komentar', 'Contoh nyata yang dibuat dari class', 'Nama package', 'C', TRUE),
(4, 1, 'Dalam class Mahasiswa, nama dan NIM termasuk ...', 'Package', 'Loop', 'Operator', 'Attribute', 'D', TRUE),
(5, 1, 'Dalam class Mobil, method yang sesuai adalah ...', 'warna', 'merek', 'nyalakanMesin()', 'jumlahRoda', 'C', TRUE),
(6, 1, 'Constructor digunakan untuk ...', 'Menghapus file', 'Menginisialisasi objek saat dibuat', 'Membandingkan angka', 'Mengulang program', 'B', TRUE),
(7, 1, 'Manakah contoh nama class Java yang sesuai konvensi umum?', 'mahasiswa-data', '2Mahasiswa', 'mahasiswa baru', 'Mahasiswa', 'D', TRUE),
(8, 1, 'PBO mengelompokkan data dan perilaku ke dalam ...', 'Class dan object', 'Folder dan gambar', 'Komentar dan spasi', 'Database dan tabel saja', 'A', TRUE),
(9, 1, 'Attribute biasanya menyimpan ...', 'Instruksi untuk mencetak saja', 'Alamat website', 'Data atau keadaan objek', 'Nama compiler', 'C', TRUE),
(10, 1, 'Method biasanya mewakili ...', 'Warna layar editor', 'Perilaku atau tindakan objek', 'Nama file PDF', 'Tipe database', 'B', TRUE),
(11, 1, 'Blueprint rumah paling mirip dengan konsep ...', 'Object', 'Operator', 'Variabel lokal', 'Class', 'D', TRUE),
(12, 1, 'Rumah yang dibangun berdasarkan blueprint paling mirip dengan ...', 'Object', 'Class', 'Method', 'Komentar', 'A', TRUE),
(13, 1, 'Encapsulation berarti ...', 'Menghapus semua data', 'Membungkus data dan perilaku dalam class', 'Mengubah Java menjadi SQL', 'Mengulang kode terus-menerus', 'B', TRUE),
(14, 1, 'Abstraction membantu programmer untuk ...', 'Menampilkan semua detail sekaligus', 'Menghapus class', 'Fokus pada hal penting dan menyembunyikan detail yang tidak perlu', 'Mengubah semua data menjadi teks', 'C', TRUE),
(15, 1, 'Inheritance adalah konsep ...', 'Mencetak tulisan', 'Menyimpan variabel', 'Membuat komentar', 'Membuat class berdasarkan class lain', 'D', TRUE),
(16, 1, 'Polymorphism berkaitan dengan kemampuan ...', 'Satu antarmuka atau cara pemanggilan memiliki perilaku berbeda', 'Menghapus object', 'Membuat semua variabel sama', 'Menghentikan program', 'A', TRUE),
(17, 1, 'Java dapat berjalan di berbagai sistem yang memiliki ...', 'Microsoft Word', 'Java Virtual Machine (JVM)', 'PostgreSQL saja', 'Photoshop', 'B', TRUE),
(18, 1, 'Program prosedural umumnya menekankan ...', 'Class sebagai satu-satunya susunan', 'Database saja', 'Fungsi untuk tugas tertentu', 'Tampilan antarmuka saja', 'C', TRUE),
(19, 1, 'Salah satu manfaat membagi program menjadi beberapa class adalah ...', 'Semua kode menjadi satu baris', 'Program tidak perlu diuji', 'Variabel tidak diperlukan', 'Kode lebih terstruktur dan mudah dikelola', 'D', TRUE),
(20, 1, 'Objek umumnya memiliki keadaan dan ...', 'Perilaku', 'Password database', 'Alamat IP wajib', 'Nama file wajib', 'A', TRUE),

(21, 2, 'Tipe data untuk bilangan bulat seperti 10 adalah ...', 'boolean', 'char', 'String', 'int', 'D', TRUE),
(22, 2, 'Tipe data untuk nilai true atau false adalah ...', 'int', 'boolean', 'char', 'double', 'B', TRUE),
(23, 2, 'Tipe data yang umum dipakai untuk angka desimal adalah ...', 'boolean', 'char', 'double', 'String', 'C', TRUE),
(24, 2, 'Tipe data char digunakan untuk menyimpan ...', 'Satu karakter', 'Kalimat panjang', 'Bilangan pecahan saja', 'Nilai true/false', 'A', TRUE),
(25, 2, 'Variabel adalah tempat untuk ...', 'Menjalankan komputer secara fisik', 'Menyimpan nilai', 'Menghapus class', 'Menghubungkan internet', 'B', TRUE),
(26, 2, 'Manakah deklarasi variabel Java yang benar?', 'int 2umur = 20;', 'int umur mahasiswa = 20;', 'int umur = 20;', 'umur int = 20;', 'C', TRUE),
(27, 2, 'Java bersifat case-sensitive, sehingga ...', 'spasi boleh bebas dalam nama variabel', 'angka boleh selalu menjadi karakter pertama', 'huruf besar diabaikan', 'nilai dan Nilai berbeda nama', 'D', TRUE),
(28, 2, 'Komentar satu baris pada Java dimulai dengan ...', '##', '//', '<!--', '**', 'B', TRUE),
(29, 2, 'Perintah untuk mencetak teks dan pindah baris adalah ...', 'System.input()', 'print.line.java()', 'System.out.println()', 'Console.read()', 'C', TRUE),
(30, 2, 'Perintah System.out.print("Halo"); digunakan untuk ...', 'Menampilkan teks Halo', 'Membaca nama pengguna', 'Membuat class', 'Menghapus variabel', 'A', TRUE),
(31, 2, 'Tanda titik koma ; umumnya digunakan untuk ...', 'Membuka class', 'Mengakhiri statement', 'Membuat komentar', 'Menamai variabel', 'B', TRUE),
(32, 2, 'Operator + pada dua bilangan digunakan untuk ...', 'Pembagian', 'Perbandingan', 'Penjumlahan', 'Sisa bagi', 'C', TRUE),
(33, 2, 'Hasil dari 4 + 3 adalah ...', '1', '12', '43', '7', 'D', TRUE),
(34, 2, 'Hasil dari 8 - 5 adalah ...', '3', '13', '40', '2', 'A', TRUE),
(35, 2, 'Operator * digunakan untuk ...', 'Pembagian', 'Perkalian', 'Pengurangan', 'Perbandingan sama dengan', 'B', TRUE),
(36, 2, 'Operator / pada operasi bilangan digunakan untuk ...', 'Penjumlahan', 'Sisa bagi saja', 'Pembagian', 'Pemberian komentar', 'C', TRUE),
(37, 2, 'Operator % digunakan untuk memperoleh ...', 'Hasil penjumlahan', 'Nilai teks', 'Nilai true/false saja', 'Sisa hasil bagi', 'D', TRUE),
(38, 2, 'Operator == digunakan untuk memeriksa ...', 'Apakah dua nilai sama', 'Memberi nilai variabel', 'Menjumlahkan nilai', 'Membuat object', 'A', TRUE),
(39, 2, 'Apa fungsi variabel `String nama = "Ani";`?', 'Menyimpan angka Ani', 'Menyimpan teks Ani pada variabel nama', 'Membuat method nama', 'Mencetak teks otomatis', 'B', TRUE),
(40, 2, 'Math.abs(-5) menghasilkan ...', '-5', '0', '5', '25', 'C', TRUE),

(41, 3, 'Control statement berfungsi untuk ...', 'Menyimpan gambar', 'Membuat database', 'Mengganti nama file', 'Mengatur alur eksekusi program', 'D', TRUE),
(42, 3, 'Statement if menjalankan blok ketika kondisi bernilai ...', 'true', 'false', 'teks kosong saja', 'selalu null', 'A', TRUE),
(43, 3, 'Bagian else dijalankan ketika kondisi if ...', 'true', 'false', 'belum ada', 'berupa String', 'B', TRUE),
(44, 3, 'Jika `int x = 8;` maka kondisi `x > 5` bernilai ...', 'false', 'A', 'true', 'error', 'C', TRUE),
(45, 3, 'Struktur if-else digunakan untuk ...', 'Membuat class baru', 'Menyimpan data ke file', 'Mendeklarasikan package', 'Memilih antara dua cabang berdasarkan kondisi', 'D', TRUE),
(46, 3, 'Untuk memeriksa beberapa kondisi secara berurutan, kita dapat memakai ...', 'if - else if - else', 'import - package - class', 'public - private - protected saja', 'try - catch saja', 'A', TRUE),
(47, 3, 'switch cocok digunakan untuk ...', 'Mendeklarasikan variabel saja', 'Memilih cabang berdasarkan nilai ekspresi', 'Membuat komentar', 'Menghubungkan database', 'B', TRUE),
(48, 3, 'Kata kunci case di dalam switch digunakan untuk ...', 'Mengakhiri semua program', 'Membuat variabel baru', 'Menentukan nilai yang dicocokkan', 'Mengulang while', 'C', TRUE),
(49, 3, 'Kegunaan break di dalam switch adalah ...', 'Memulai class', 'Mencetak hasil', 'Membuat variabel', 'Menghentikan alur agar tidak lanjut ke case berikutnya', 'D', TRUE),
(50, 3, 'Bagian default pada switch berjalan ketika ...', 'Tidak ada case yang cocok', 'Case pertama selalu cocok', 'Program selalu dimulai', 'Ada komentar', 'A', TRUE),
(51, 3, 'Jika `int nilai = 90;` dan kondisi `nilai >= 80`, kondisi itu bernilai ...', 'false', 'true', 'null', 'tidak dapat diperiksa', 'B', TRUE),
(52, 3, 'Jika `int x = 3; if (x > 5) ... else ...`, cabang yang dipilih adalah ...', 'if', 'keduanya selalu', 'else', 'tidak ada', 'C', TRUE),
(53, 3, 'Untuk menentukan bilangan genap atau ganjil, kita dapat memeriksa ...', 'Panjang nama variabel', 'Jumlah class', 'Nama package', 'Sisa pembagian dengan 2', 'D', TRUE),
(54, 3, 'Operator yang berarti lebih besar dari adalah ...', '>', '<', '==', '=', 'A', TRUE),
(55, 3, 'Operator yang berarti lebih besar atau sama dengan adalah ...', '<=', '>=', '!=', '&&', 'B', TRUE),
(56, 3, 'Nilai boolean hanya memiliki nilai ...', 'besar atau kecil', 'huruf atau angka', 'true atau false', 'positif atau negatif saja', 'C', TRUE),
(57, 3, 'Pada `if (umur >= 17)`, bagian `umur >= 17` disebut ...', 'Constructor', 'Attribute', 'Package', 'Kondisi', 'D', TRUE),
(58, 3, 'Jika nilai tidak cocok dengan case mana pun, switch dapat menjalankan ...', 'default', 'break saja', 'constructor', 'import', 'A', TRUE),
(59, 3, 'Pernyataan return pada method dapat digunakan untuk ...', 'Membuat komentar', 'Mengembalikan nilai atau mengakhiri eksekusi method', 'Membuat package', 'Menamai class', 'B', TRUE),
(60, 3, 'Percabangan berguna saat program perlu ...', 'Menampilkan semua baris tanpa pilihan', 'Menghapus seluruh variabel', 'Memilih tindakan sesuai kondisi', 'Mengubah Java menjadi HTML', 'C', TRUE),

(61, 4, 'Method adalah sekumpulan perintah yang dijalankan ketika ...', 'File disimpan saja', 'Komentar dibuat', 'Database ditutup', 'Dipanggil', 'D', TRUE),
(62, 4, 'Nama method digunakan untuk ...', 'Memanggil method tersebut', 'Menyimpan angka otomatis', 'Menentukan nama database', 'Mengganti tipe data', 'A', TRUE),
(63, 4, 'Parameter adalah variabel yang ditulis pada ...', 'Komentar', 'Deklarasi method untuk menerima nilai', 'Nama file', 'SQL query saja', 'B', TRUE),
(64, 4, 'Nilai yang diberikan saat memanggil method disebut ...', 'Constructor', 'Package', 'Argumen', 'Operator', 'C', TRUE),
(65, 4, 'Keyword void menandakan method ...', 'Selalu mengembalikan int', 'Tidak boleh dipanggil', 'Harus menjadi class', 'Tidak mengembalikan nilai', 'D', TRUE),
(66, 4, 'Keyword return digunakan untuk ...', 'Mengembalikan nilai dari method bila diperlukan', 'Membuat variabel private', 'Membuka database', 'Menulis komentar', 'A', TRUE),
(67, 4, 'Pada `int tambah(int a, int b)`, tipe nilai baliknya adalah ...', 'void', 'int', 'String', 'boolean', 'B', TRUE),
(68, 4, 'Pada `int tambah(int a, int b)`, nama method-nya adalah ...', 'int', 'a', 'tambah', 'b', 'C', TRUE),
(69, 4, 'Pada `tambah(2, 3)`, angka 2 dan 3 merupakan ...', 'Tipe return', 'Nama class', 'Access modifier', 'Argumen', 'D', TRUE),
(70, 4, 'Jika method `jumlah(a,b)` mengembalikan `a+b`, maka `jumlah(2,3)` menghasilkan ...', '5', '6', '23', '1', 'A', TRUE),
(71, 4, 'Method yang mengembalikan nilai dapat digunakan ...', 'Hanya sebagai komentar', 'Dalam ekspresi atau untuk mengisi variabel', 'Hanya untuk membuat database', 'Tanpa pernah dipanggil', 'B', TRUE),
(72, 4, 'Method void yang mencetak pesan biasanya dipanggil sebagai ...', 'Nilai int wajib', 'Nama database', 'Statement tersendiri', 'Tipe data char', 'C', TRUE),
(73, 4, 'Badan method biasanya ditulis di antara ...', 'Tanda kutip saja', 'Kurung siku saja', 'Tanda pagar', 'Kurung kurawal { }', 'D', TRUE),
(74, 4, 'Dalam deklarasi method, parameter ditulis di dalam ...', 'Tanda kurung ( )', 'Kurung siku [ ]', 'Tanda kutip', 'Komentar', 'A', TRUE),
(75, 4, 'Rekursi terjadi ketika sebuah method ...', 'Selalu mengembalikan String', 'Memanggil dirinya sendiri', 'Tidak memiliki nama', 'Tidak memiliki badan', 'B', TRUE),
(76, 4, 'Dalam rekursi, base case berfungsi untuk ...', 'Menambah loop tanpa akhir', 'Menghapus parameter', 'Menghentikan pemanggilan berulang pada kondisi dasar', 'Membuat class baru', 'C', TRUE),
(77, 4, 'Jika `int kali(int a, int b)` mengembalikan `a*b`, maka `kali(3,4)` menghasilkan ...', '7', '34', '1', '12', 'D', TRUE),
(78, 4, 'Method membantu program karena ...', 'Kode untuk tugas tertentu dapat digunakan kembali', 'Semua kode harus disalin berulang', 'Variabel tidak dibutuhkan', 'Program tidak perlu class', 'A', TRUE),
(79, 4, 'Pada `System.out.println(area(4,5));`, area(4,5) merupakan ...', 'Deklarasi database', 'Pemanggilan method', 'Komentar', 'Nama tipe data', 'B', TRUE),
(80, 4, 'Tipe nilai balik sebuah method ditulis pada ...', 'Setelah komentar', 'Di nama file saja', 'Deklarasi method sebelum nama method', 'Di akhir program saja', 'C', TRUE),

(81, 5, 'Encapsulation adalah konsep ...', 'Mengulang kode', 'Mencetak teks', 'Membagi bilangan', 'Membungkus data dan method dalam class', 'D', TRUE),
(82, 5, 'Information hiding berarti ...', 'Menyembunyikan detail internal yang tidak perlu diakses dari luar', 'Menampilkan seluruh data tanpa batas', 'Menghapus semua method', 'Mengubah data menjadi gambar', 'A', TRUE),
(83, 5, 'Keyword private membatasi akses anggota class dari ...', 'Method dalam class itu sendiri', 'Luar class secara langsung', 'Constructor class itu sendiri', 'Semua bagian class tanpa pengecualian', 'B', TRUE),
(84, 5, 'Keyword public menunjukkan anggota yang ...', 'Tidak pernah dapat dipanggil', 'Hanya dapat digunakan di database', 'Dapat diakses dari bagian lain sesuai aturan akses Java', 'Selalu berupa angka', 'C', TRUE),
(85, 5, 'Getter biasanya digunakan untuk ...', 'Menghapus class', 'Mengulang program', 'Membuat package', 'Membaca nilai field', 'D', TRUE),
(86, 5, 'Setter biasanya digunakan untuk ...', 'Mengubah nilai field melalui method', 'Mencetak komentar', 'Membuat database', 'Menghentikan program', 'A', TRUE),
(87, 5, 'Manakah contoh field private yang benar?', 'int private umur;', 'private int umur;', 'umur private int;', 'private umur int;', 'B', TRUE),
(88, 5, 'Jika field nama bersifat private, cara yang lazim untuk membacanya dari luar adalah ...', 'Mengakses field langsung tanpa aturan', 'Menghapus field', 'Memakai getter publik', 'Mengubahnya menjadi komentar', 'C', TRUE),
(89, 5, 'Salah satu manfaat encapsulation adalah ...', 'Semua data otomatis benar', 'Program tidak membutuhkan method', 'Semua field menjadi public', 'Akses dan perubahan data dapat dikendalikan', 'D', TRUE),
(90, 5, 'Dalam class Mahasiswa, NIM dan nama biasanya termasuk ...', 'Data atau attribute', 'Operator', 'Percabangan', 'Loop', 'A', TRUE),
(91, 5, 'Dalam class Mahasiswa, method `tampilkanData()` mewakili ...', 'Tipe database', 'Perilaku atau tindakan', 'Nama field otomatis', 'Komentar', 'B', TRUE),
(92, 5, 'Getter `getUmur()` biasanya mengembalikan ...', 'Nilai database', 'Nama package', 'Nilai umur', 'Nama file', 'C', TRUE),
(93, 5, 'Setter dapat memeriksa nilai sebelum menyimpannya untuk ...', 'Membuat nilai selalu acak', 'Menghapus object', 'Menutup terminal', 'Menjaga data sesuai aturan', 'D', TRUE),
(94, 5, 'Field private biasanya dideklarasikan di dalam ...', 'Class', 'Query Tool saja', 'Komentar', 'Nama package saja', 'A', TRUE),
(95, 5, 'Mengapa field tidak selalu dibuat public?', 'Agar class tidak dapat dibuat', 'Agar akses langsung ke data bisa dibatasi', 'Agar Java tidak perlu tipe data', 'Agar program hanya berjalan sekali', 'B', TRUE),
(96, 5, 'Object dibuat berdasarkan ...', 'Operator', 'Komentar', 'Class', 'Database saja', 'C', TRUE),
(97, 5, 'Method publik yang disediakan untuk mengakses data merupakan bagian dari ...', 'Nama file PDF', 'Compiler', 'Komentar', 'Antarmuka class', 'D', TRUE),
(98, 5, 'Jika setter menerima parameter `nama`, parameter tersebut berisi ...', 'Nilai baru yang ingin diproses atau disimpan', 'Nama database pasti', 'Nama method lain', 'Kunci jawaban kuis', 'A', TRUE),
(99, 5, 'Encapsulation memudahkan pemeliharaan karena detail internal ...', 'Harus selalu diketahui semua pemakai', 'Dapat diubah tanpa harus mengubah cara luar menggunakan class, selama antarmukanya tetap', 'Tidak boleh memiliki method', 'Selalu menjadi public', 'B', TRUE),
(100, 5, 'Kombinasi yang umum pada enkapsulasi dasar adalah ...', 'Semua field public tanpa kendali', 'Hanya komentar dan package', 'Field private dan getter/setter sesuai kebutuhan', 'Semua field dihapus', 'C', TRUE)

ON CONFLICT (id) DO UPDATE SET
    meeting_no = EXCLUDED.meeting_no,
    question_text = EXCLUDED.question_text,
    option_a = EXCLUDED.option_a,
    option_b = EXCLUDED.option_b,
    option_c = EXCLUDED.option_c,
    option_d = EXCLUDED.option_d,
    correct_option = EXCLUDED.correct_option,
    active = TRUE;

SELECT setval(
    pg_get_serial_sequence('questions', 'id'),
    COALESCE((SELECT MAX(id) FROM questions), 1),
    TRUE
);

SELECT meeting_no AS pertemuan, COUNT(*) AS jumlah_soal
FROM questions
WHERE active = TRUE
GROUP BY meeting_no
ORDER BY meeting_no;
