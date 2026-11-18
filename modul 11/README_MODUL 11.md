# Modul 11 – Analisis Penerapan DBMS: OLUTRA

Kelompok TempleOS · Teknologi Rekayasa Perangkat Lunak · Politeknik Negeri Madiun

Anggota:
- Adly Naurus Zaman Assidiq
- Dimas Pramodya Bagaskara
- Muhammad Ridwan Hazim

## Deskripsi

OLUTRA adalah marketplace limbah bernilai guna yang mendukung SDG 12. Limbah dikumpulkan dari rumah tangga dan UMKM, lalu disalurkan ke industri (B2B) atau ke pengguna lain (B2C/B2B mikro).

Repositori ini berisi hasil Modul 11:
1. Perbandingan DBMS (MySQL, SQLite, PostgreSQL).
2. Implementasi tipe data JSON (insert, select, update, delete, dan pencarian atribut).
3. Pemodelan objek dan perbedaannya dengan model relasional.
4. Analisis kesesuaian DBMS untuk OLUTRA beserta demonstrasinya.

## DBMS yang Dipilih: PostgreSQL

| Alasan | Penjelasan |
|---|---|
| Data relasional dan bernilai uang | Foreign key, constraint, dan transaksi ACID menjaga stok dan nilai transaksi tetap akurat |
| Banyak pengguna bersamaan | MVCC membuat pembaca dan penulis tidak saling menunggu |
| Atribut limbah beragam | JSONB menyimpan atribut berbeda tiap jenis tanpa menambah tabel |
| Pengembangan ke depan | PostGIS untuk pencocokan lokasi penjual–pembeli, window function untuk analitik |
| Biaya | Gratis dan open source |

## Struktur Repositori

```
modul-11/
├── README.md
├── sql/
│   ├── olutra_bank_sampah.sql   # struktur database asli (MariaDB/phpMyAdmin)
│   ├── json_mariadb.sql         # skrip praktik JSON (MariaDB)
│   └── olutra_pgadmin.sql       # versi PostgreSQL untuk pgAdmin
└── docs/                        # tangkapan layar hasil demonstrasi
```

## Cara Menjalankan

**MariaDB (phpMyAdmin/XAMPP)**
1. Buat database `olutra_bank_sampah`, lalu import `olutra_bank_sampah.sql`.
2. Jalankan `json_mariadb.sql` untuk praktik JSON.

**PostgreSQL (pgAdmin 4)**
1. Buat database `olutra`, lalu buka Query Tool.
2. Jalankan Bagian A di `olutra_pgadmin.sql` untuk membuat struktur dan data contoh.
3. Jalankan Bagian B satu per satu untuk demonstrasi.

## Isi Demonstrasi

**Praktik JSON (MariaDB)** menggunakan kolom `detail_tambahan` pada tabel `setoran`:
- `INSERT` data dengan atribut JSON yang berbeda tiap baris.
- `SELECT` atribut dengan `JSON_EXTRACT`.
- `UPDATE` atribut dengan `JSON_SET`.
- `DELETE` atribut dengan `JSON_REMOVE`.
- Pencarian berdasarkan atribut JSON.
- `JSON_OBJECT`, `JSON_ARRAY`, `JSON_VALID`, dan `JSON_LENGTH`.

**Demonstrasi PostgreSQL (`olutra_pgadmin.sql`)**
1. Tampilkan data setoran dengan JOIN.
2. Laporan total setoran per kategori dan jenis (indikator SDG 12).
3. Uji constraint: jumlah negatif, pengguna tidak ada, dan trigger yang menolak setoran dari pengguna industri.
4. Transaksi `ROLLBACK` dan `COMMIT` pada stok.

## Catatan

- Data contoh bersifat fiktif dan hanya untuk demonstrasi.
- Praktik JSON dikerjakan di MariaDB karena database proyek dibuat di sana. PostgreSQL punya padanan yang lebih kuat lewat JSONB (`->>`, `jsonb_set`, `@>`).
