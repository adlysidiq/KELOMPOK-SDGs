-- =====================================================================
-- SCRIPT PENGUJIAN PENYIMPANAN DATA JSON
-- Tabel utama : setoran (kolom detail_tambahan bertipe JSON)
-- =====================================================================
-- Prasyarat: tabel pengguna sudah berisi id_pengguna 1, 4, dan 5,
-- dan kolom detail_tambahan sudah ada di tabel setoran:
-- ALTER TABLE setoran ADD COLUMN detail_tambahan JSON NULL;


-- =====================================================================
-- 1. PERSIAPAN DATA (bukan pengujian JSON)
-- =====================================================================

INSERT INTO jenis_sampah (id_jenis, nama_jenis, harga, stok_sampah) VALUES
(1, 'Plastik PET', 3000, 100),
(2, 'Kardus',      2000, 250),
(3, 'Kaleng',      5000, 80);

-- Setoran tanpa data JSON (detail_tambahan bernilai NULL)
INSERT INTO setoran
    (id_setoran, id_pengguna, id_jenis, jumlah, tanggal_setoran, harga_setor)
VALUES
    (101, 1, 1, 3.00, '2026-10-04 09:00:00', 6000),
    (102, 4, 2, 3.00, '2026-10-04 09:00:00', 5000),
    (103, 5, 3, 4.00, '2026-10-04 09:00:00', 6000);


-- =====================================================================
-- 2. PENGUJIAN: MENYIMPAN DATA JSON (INSERT)
-- Struktur JSON tiap setoran boleh berbeda-beda.
-- =====================================================================

-- Setoran 104: kaleng, memuat atribut kemasan dan tipe_jumlah
INSERT INTO setoran
    (id_setoran, id_pengguna, id_jenis, jumlah, harga_setor, detail_tambahan)
VALUES
    (104, 1, 3, 7, 5000,
     '{
        "kondisi": "bersih",
        "sudah_dipilah": true,
        "kemasan": "karung",
        "metode_setor": "dijemput",
        "merk": "pepsi",
        "tipe_jumlah": "KG"
     }');

-- Setoran 105: plastik PET, memuat atribut catatan dan merk
INSERT INTO setoran
    (id_setoran, id_pengguna, id_jenis, jumlah, harga_setor, detail_tambahan)
VALUES
    (105, 1, 1, 3, 3000,
     '{
        "kondisi": "bersih",
        "metode_setor": "ditempat",
        "catatan": "sudah dipisah sesuai merk botol",
        "merk": "coca-cola, fanta"
     }');

-- Setoran 106: kardus, memuat atribut jam_penjemputan dan jenis_kardus
INSERT INTO setoran
    (id_setoran, id_pengguna, id_jenis, jumlah, harga_setor, detail_tambahan)
VALUES
    (106, 1, 2, 7, 2000,
     '{
        "kondisi": "bersih",
        "sudah_dipilah": true,
        "kemasan": "karung",
        "metode_setor": "dijemput",
        "jam_penjemputan": "09:00-11:00",
        "jenis_kardus": "kardus kraft",
        "tipe_jumlah": "KG"
     }');


-- =====================================================================
-- 3. PENGUJIAN: MEMBACA ATRIBUT JSON (SELECT dengan JSON_EXTRACT)
-- =====================================================================

-- 3a. Mengambil atribut metode_setor
SELECT
    id_setoran, foto_bukti,
    JSON_EXTRACT(detail_tambahan, '$.metode_setor') AS metode_setor
FROM setoran;

-- 3b. Mengambil atribut kondisi
SELECT
    id_setoran, foto_bukti,
    JSON_EXTRACT(detail_tambahan, '$.kondisi') AS kondisi_sampah
FROM setoran;

-- 3c. Mengambil atribut kemasan
SELECT
    id_setoran, foto_bukti,
    JSON_EXTRACT(detail_tambahan, '$.kemasan') AS kemasan
FROM setoran;


-- =====================================================================
-- 4. PENGUJIAN: MENGUBAH ATRIBUT JSON (UPDATE dengan JSON_SET)
-- Atribut yang sudah ada diganti nilainya.
-- =====================================================================

UPDATE setoran
SET detail_tambahan = JSON_SET(detail_tambahan, '$.kondisi', 'kotor')
WHERE id_setoran = 105;

-- Verifikasi hasil perubahan
SELECT
    id_setoran,
    JSON_EXTRACT(detail_tambahan, '$.kondisi') AS kondisi_barang
FROM setoran
WHERE id_setoran = 105;


-- =====================================================================
-- 5. PENGUJIAN: MENAMBAHKAN ATRIBUT JSON (UPDATE dengan JSON_SET)
-- Atribut baru (merk_botol) ditambahkan tanpa mengubah struktur tabel.
-- =====================================================================

UPDATE setoran
SET detail_tambahan = JSON_SET(detail_tambahan, '$.merk_botol', 'pepsi')
WHERE id_setoran = 105;

-- Verifikasi hasil penambahan
SELECT id_setoran, detail_tambahan
FROM setoran
WHERE id_setoran = 105;


-- =====================================================================
-- 6. PENGUJIAN: MENGHAPUS ATRIBUT JSON (UPDATE dengan JSON_REMOVE)
-- =====================================================================

UPDATE setoran
SET detail_tambahan = JSON_REMOVE(detail_tambahan, '$.merk_botol')
WHERE id_setoran = 105;

-- Verifikasi hasil penghapusan
SELECT id_setoran, detail_tambahan
FROM setoran
WHERE id_setoran = 105;


-- =====================================================================
-- 7. PENGUJIAN: MEMFILTER DATA BERDASARKAN ATRIBUT JSON (WHERE)
-- JSON_UNQUOTE dipakai agar nilai dibandingkan tanpa tanda kutip.
-- =====================================================================

-- 7a. Setoran dengan metode_setor = 'dijemput'
SELECT
    id_setoran, id_jenis, harga_setor, detail_tambahan
FROM setoran
WHERE JSON_UNQUOTE(JSON_EXTRACT(detail_tambahan, '$.metode_setor')) = 'dijemput';

-- 7b. Setoran dengan kondisi = 'kotor'
SELECT
    id_setoran, id_jenis, harga_setor, detail_tambahan
FROM setoran
WHERE JSON_UNQUOTE(JSON_EXTRACT(detail_tambahan, '$.kondisi')) = 'kotor';


-- =====================================================================
-- 8. PENGUJIAN: FUNGSI PENDUKUNG JSON
-- =====================================================================

-- 8a. Membuat objek JSON (JSON_OBJECT)
SELECT JSON_OBJECT(
    'nama', 'Budi',
    'umur', 21,
    'status', 'Mahasiswa'
) AS data_mahasiswa;

-- 8b. Membuat array JSON (JSON_ARRAY)
SELECT JSON_ARRAY('MySQL', 'MariaDB', 'PostgreSQL') AS daftar_dbms;

-- 8c. Memeriksa validitas JSON (JSON_VALID): 1 = valid, 0 = tidak valid
SELECT JSON_VALID('{"nama":"Budi","umur":21}') AS json_valid;

-- 8d. Menghitung jumlah atribut JSON (JSON_LENGTH)
SELECT
    id_setoran,
    JSON_LENGTH(detail_tambahan) AS jumlah_atribut
FROM setoran;
