-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 03 Nov 2026 pada 14.16
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `olutra_bank_sampah`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(10) UNSIGNED NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `admin`
--

INSERT INTO `admin` (`id_admin`, `nama`, `email`) VALUES
(1, 'Admin Satu', 'admin1@olutra.id'),
(2, 'Admin Dua', 'admin2@olutra.id');

-- --------------------------------------------------------

--
-- Struktur dari tabel `alamat`
--

CREATE TABLE `alamat` (
  `id_alamat` int(10) UNSIGNED NOT NULL,
  `jalan` varchar(255) NOT NULL,
  `kota` varchar(100) NOT NULL,
  `label` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `alamat`
--

INSERT INTO `alamat` (`id_alamat`, `jalan`, `kota`, `label`) VALUES
(1, 'Jl. Mawar No. 12', 'Madiun', 'Rumah'),
(2, 'Jl. Melati No. 5', 'Madiun', 'Rumah'),
(3, 'Jl. Kenanga No. 21', 'Madiun', 'Rumah'),
(4, 'Jl. Pahlawan No. 88', 'Madiun', 'Warung'),
(5, 'Jl. Diponegoro No. 40', 'Madiun', 'Bengkel'),
(6, 'Kawasan Industri Blok A-3', 'Surabaya', 'Pabrik'),
(7, 'Kawasan Industri Blok B-7', 'Sidoarjo', 'Pabrik'),
(8, 'Jl. Cempaka No. 9', 'Madiun', 'Rumah');

-- --------------------------------------------------------

--
-- Struktur dari tabel `industri`
--

CREATE TABLE `industri` (
  `id_pengguna` int(10) UNSIGNED NOT NULL,
  `tipe_pengguna` enum('rumah_tangga','umkm','industri') NOT NULL DEFAULT 'industri',
  `nama_perusahaan` varchar(150) NOT NULL,
  `nib` varchar(30) DEFAULT NULL,
  `npwp_perusahaan` varchar(30) DEFAULT NULL,
  `kontak_logistik_pabrik` varchar(50) DEFAULT NULL
) ;

--
-- Dumping data untuk tabel `industri`
--

INSERT INTO `industri` (`id_pengguna`, `tipe_pengguna`, `nama_perusahaan`, `nib`, `npwp_perusahaan`, `kontak_logistik_pabrik`) VALUES
(6, 'industri', 'PT Plastik Nusantara', '1234567890123', '01.234.567.8-901.000', '031555670001'),
(7, 'industri', 'PT Kertas Mandiri', '9876543210987', '02.345.678.9-012.000', '031555670002');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis_sampah`
--

CREATE TABLE `jenis_sampah` (
  `id_jenis` int(10) UNSIGNED NOT NULL,
  `id_kategori` int(10) UNSIGNED NOT NULL,
  `nama_jenis` varchar(100) NOT NULL,
  `harga` decimal(12,2) NOT NULL DEFAULT 0.00 CHECK (`harga` >= 0),
  `stok_sampah` decimal(12,2) NOT NULL DEFAULT 0.00 CHECK (`stok_sampah` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `jenis_sampah`
--

INSERT INTO `jenis_sampah` (`id_jenis`, `id_kategori`, `nama_jenis`, `harga`, `stok_sampah`) VALUES
(1, 1, 'Botol PET', 3000.00, 120.00),
(2, 1, 'Plastik HDPE', 2500.00, 60.00),
(3, 1, 'Gelas Plastik', 1500.00, 40.00),
(4, 2, 'Kardus', 2000.00, 85.00),
(5, 2, 'Kertas HVS', 1800.00, 30.00),
(6, 2, 'Koran', 1500.00, 25.00),
(7, 3, 'Kaleng Aluminium', 9000.00, 18.00),
(8, 3, 'Besi Tua', 4000.00, 55.00),
(9, 4, 'Botol Kaca', 800.00, 70.00);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori_sampah`
--

CREATE TABLE `kategori_sampah` (
  `id_kategori` int(10) UNSIGNED NOT NULL,
  `nama_kategori` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kategori_sampah`
--

INSERT INTO `kategori_sampah` (`id_kategori`, `nama_kategori`) VALUES
(1, 'Plastik'),
(2, 'Kertas'),
(3, 'Logam'),
(4, 'Kaca');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_transaksi`
--

CREATE TABLE `log_transaksi` (
  `id_log` int(10) UNSIGNED NOT NULL,
  `id_transaksi` int(10) UNSIGNED NOT NULL,
  `aksi` enum('dibatalkan','diproses','selesai','ditunda') NOT NULL,
  `waktu` datetime NOT NULL DEFAULT current_timestamp(),
  `keterangan` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_transaksi`
--

INSERT INTO `log_transaksi` (`id_log`, `id_transaksi`, `aksi`, `waktu`, `keterangan`) VALUES
(1, 3, 'diproses', '2026-10-04 10:30:00', 'Transaksi akan diproses admin setelah stock berkurang'),
(2, 1, 'diproses', '2026-10-01 11:00:00', 'Transaksi mulai diproses admin'),
(3, 2, 'diproses', '2026-10-03 11:00:00', 'Transaksi mulai diproses admin'),
(4, 3, 'diproses', '2026-10-04 11:00:00', 'Transaksi mulai diproses admin'),
(5, 4, 'diproses', '2026-10-06 11:00:00', 'Transaksi mulai diproses admin'),
(6, 5, 'diproses', '2026-10-08 11:00:00', 'Transaksi mulai diproses admin'),
(7, 6, 'diproses', '2026-10-10 11:00:00', 'Transaksi mulai diproses admin'),
(8, 7, 'diproses', '2026-10-12 11:00:00', 'Transaksi mulai diproses admin'),
(9, 8, 'diproses', '2026-10-15 11:00:00', 'Transaksi mulai diproses admin'),
(10, 9, 'diproses', '2026-10-18 11:00:00', 'Transaksi mulai diproses admin'),
(11, 10, 'diproses', '2026-10-20 11:00:00', 'Transaksi mulai diproses admin'),
(12, 11, 'diproses', '2026-10-22 11:00:00', 'Transaksi mulai diproses admin'),
(13, 16, 'diproses', '2026-10-05 14:00:00', 'Transaksi mulai diproses admin'),
(14, 17, 'diproses', '2026-10-09 14:00:00', 'Transaksi mulai diproses admin'),
(15, 18, 'diproses', '2026-10-14 14:00:00', 'Transaksi mulai diproses admin'),
(16, 19, 'diproses', '2026-10-07 14:00:00', 'Transaksi mulai diproses admin'),
(17, 20, 'diproses', '2026-10-16 14:00:00', 'Transaksi mulai diproses admin'),
(18, 21, 'diproses', '2026-10-21 14:00:00', 'Transaksi mulai diproses admin'),
(19, 22, 'diproses', '2026-10-26 14:00:00', 'Transaksi mulai diproses admin'),
(20, 23, 'diproses', '2026-10-28 14:00:00', 'Transaksi mulai diproses admin'),
(21, 24, 'diproses', '2026-10-30 14:00:00', 'Transaksi mulai diproses admin'),
(22, 25, 'diproses', '2026-11-01 14:00:00', 'Transaksi mulai diproses admin'),
(23, 26, 'diproses', '2026-10-29 14:00:00', 'Transaksi mulai diproses admin'),
(33, 1, 'selesai', '2026-10-01 13:00:00', 'Transaksi selesai'),
(34, 2, 'selesai', '2026-10-03 13:00:00', 'Transaksi selesai'),
(35, 3, 'selesai', '2026-10-04 13:00:00', 'Transaksi selesai'),
(36, 4, 'selesai', '2026-10-06 13:00:00', 'Transaksi selesai'),
(37, 5, 'selesai', '2026-10-08 13:00:00', 'Transaksi selesai'),
(38, 6, 'selesai', '2026-10-10 13:00:00', 'Transaksi selesai'),
(39, 7, 'selesai', '2026-10-12 13:00:00', 'Transaksi selesai'),
(40, 8, 'selesai', '2026-10-15 13:00:00', 'Transaksi selesai'),
(41, 9, 'selesai', '2026-10-18 13:00:00', 'Transaksi selesai'),
(42, 10, 'selesai', '2026-10-20 13:00:00', 'Transaksi selesai'),
(43, 11, 'selesai', '2026-10-22 13:00:00', 'Transaksi selesai'),
(44, 16, 'selesai', '2026-10-05 16:00:00', 'Transaksi selesai'),
(45, 17, 'selesai', '2026-10-09 16:00:00', 'Transaksi selesai'),
(46, 18, 'selesai', '2026-10-14 16:00:00', 'Transaksi selesai'),
(47, 19, 'selesai', '2026-10-07 16:00:00', 'Transaksi selesai'),
(48, 20, 'selesai', '2026-10-16 16:00:00', 'Transaksi selesai'),
(49, 21, 'selesai', '2026-10-21 16:00:00', 'Transaksi selesai'),
(50, 22, 'selesai', '2026-10-26 16:00:00', 'Transaksi selesai'),
(51, 24, 'selesai', '2026-10-30 16:00:00', 'Transaksi selesai'),
(52, 26, 'selesai', '2026-10-29 16:00:00', 'Transaksi selesai'),
(64, 23, 'dibatalkan', '2026-10-28 13:20:00', 'Dibatalkan pembeli, diajukan ulang');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembelian`
--

CREATE TABLE `pembelian` (
  `id_pembelian` int(10) UNSIGNED NOT NULL,
  `id_pengguna` int(10) UNSIGNED NOT NULL,
  `id_admin` int(10) UNSIGNED DEFAULT NULL,
  `id_jenis` int(10) UNSIGNED NOT NULL,
  `tanggal_pembelian` date NOT NULL,
  `status` enum('menunggu','diproses','selesai','ditolak') NOT NULL DEFAULT 'menunggu',
  `jumlah_barang` decimal(12,2) NOT NULL CHECK (`jumlah_barang` > 0),
  `harga_beli` decimal(12,2) NOT NULL CHECK (`harga_beli` >= 0),
  `sub_total` decimal(15,2) GENERATED ALWAYS AS (`jumlah_barang` * `harga_beli`) STORED,
  `total_harga` decimal(15,2) GENERATED ALWAYS AS (`jumlah_barang` * `harga_beli`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pembelian`
--

INSERT INTO `pembelian` (`id_pembelian`, `id_pengguna`, `id_admin`, `id_jenis`, `tanggal_pembelian`, `status`, `jumlah_barang`, `harga_beli`) VALUES
(1, 6, 1, 1, '2026-10-05', 'selesai', 25.00, 4000.00),
(2, 6, 1, 2, '2026-10-09', 'selesai', 15.00, 3500.00),
(3, 6, 2, 3, '2026-10-14', 'selesai', 10.00, 2200.00),
(4, 7, 2, 4, '2026-10-07', 'selesai', 30.00, 3000.00),
(5, 7, 2, 5, '2026-10-16', 'selesai', 12.00, 2800.00),
(6, 7, 1, 6, '2026-10-21', 'selesai', 18.00, 2200.00),
(7, 6, 1, 1, '2026-10-26', 'selesai', 20.00, 4000.00),
(8, 7, 2, 4, '2026-10-28', 'diproses', 25.00, 3000.00),
(9, 4, 1, 7, '2026-10-30', 'selesai', 3.00, 11000.00),
(10, 5, 2, 8, '2026-11-01', 'diproses', 10.00, 5500.00),
(11, 6, NULL, 7, '2026-11-02', 'menunggu', 4.00, 11000.00),
(12, 7, NULL, 2, '2026-11-03', 'menunggu', 8.00, 3500.00),
(13, 1, 1, 9, '2026-10-29', 'selesai', 5.00, 1200.00),
(14, 5, 2, 1, '2026-10-24', 'ditolak', 6.00, 4000.00);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengguna`
--

CREATE TABLE `pengguna` (
  `id_pengguna` int(10) UNSIGNED NOT NULL,
  `id_alamat` int(10) UNSIGNED NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `no_telepon` varchar(20) DEFAULT NULL,
  `status_akun` enum('aktif','nonaktif') NOT NULL DEFAULT 'aktif',
  `tipe_pengguna` enum('rumah_tangga','umkm','industri') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pengguna`
--

INSERT INTO `pengguna` (`id_pengguna`, `id_alamat`, `nama`, `email`, `password`, `no_telepon`, `status_akun`, `tipe_pengguna`) VALUES
(1, 1, 'Budi Santoso', 'budi@mail.com', 'bee5688aea66a47460b19c76f8f199c6b9585eb726f8322b1429793863609ca2', '081234560001', 'aktif', 'rumah_tangga'),
(2, 2, 'Siti Aminah', 'siti@mail.com', 'bee5688aea66a47460b19c76f8f199c6b9585eb726f8322b1429793863609ca2', '081234560002', 'aktif', 'rumah_tangga'),
(3, 3, 'Dewi Lestari', 'dewi@mail.com', 'bee5688aea66a47460b19c76f8f199c6b9585eb726f8322b1429793863609ca2', '081234560003', 'aktif', 'rumah_tangga'),
(4, 4, 'Rina Wulandari', 'rina@warungrina.id', 'bee5688aea66a47460b19c76f8f199c6b9585eb726f8322b1429793863609ca2', '081234560004', 'aktif', 'umkm'),
(5, 5, 'Agus Prasetyo', 'agus@daurulang.id', 'bee5688aea66a47460b19c76f8f199c6b9585eb726f8322b1429793863609ca2', '081234560005', 'aktif', 'umkm'),
(6, 6, 'Hendra Wijaya', 'hendra@plastiknusa.co.id', 'bee5688aea66a47460b19c76f8f199c6b9585eb726f8322b1429793863609ca2', '031555660006', 'aktif', 'industri'),
(7, 7, 'Lina Marlina', 'lina@kertasmandiri.co.id', 'bee5688aea66a47460b19c76f8f199c6b9585eb726f8322b1429793863609ca2', '031555660007', 'aktif', 'industri'),
(8, 8, 'Joko Susilo', 'joko@mail.com', 'bee5688aea66a47460b19c76f8f199c6b9585eb726f8322b1429793863609ca2', '081234560008', 'aktif', 'rumah_tangga');

-- --------------------------------------------------------

--
-- Struktur dari tabel `rekap_jumlah_setor`
--

CREATE TABLE `rekap_jumlah_setor` (
  `id_pengguna` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `nama` varchar(100) NOT NULL,
  `jumlah_setor` bigint(21) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `rekap_jumlah_setor`
--

INSERT INTO `rekap_jumlah_setor` (`id_pengguna`, `nama`, `jumlah_setor`) VALUES
(1, 'Budi Santoso', 3),
(2, 'Siti Aminah', 3),
(3, 'Dewi Lestari', 2),
(4, 'Rina Wulandari', 3),
(5, 'Agus Prasetyo', 2),
(8, 'Joko Susilo', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `rumah_tangga`
--

CREATE TABLE `rumah_tangga` (
  `id_pengguna` int(10) UNSIGNED NOT NULL,
  `tipe_pengguna` enum('rumah_tangga','umkm','industri') NOT NULL DEFAULT 'rumah_tangga',
  `rt_rw` varchar(20) DEFAULT NULL,
  `jumlah_rumah_tgg` int(10) UNSIGNED DEFAULT NULL
) ;

--
-- Dumping data untuk tabel `rumah_tangga`
--

INSERT INTO `rumah_tangga` (`id_pengguna`, `tipe_pengguna`, `rt_rw`, `jumlah_rumah_tgg`) VALUES
(1, 'rumah_tangga', '02/05', 4),
(2, 'rumah_tangga', '03/05', 3),
(3, 'rumah_tangga', '01/02', 5),
(8, 'rumah_tangga', '04/01', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `setoran`
--

CREATE TABLE `setoran` (
  `id_setoran` int(10) UNSIGNED NOT NULL,
  `id_pengguna` int(10) UNSIGNED NOT NULL,
  `id_admin` int(10) UNSIGNED DEFAULT NULL,
  `id_jenis` int(10) UNSIGNED NOT NULL,
  `tanggal_setoran` date NOT NULL,
  `status_setoran` enum('menunggu','disetujui','ditolak') NOT NULL DEFAULT 'menunggu',
  `jumlah` decimal(12,2) NOT NULL CHECK (`jumlah` > 0),
  `harga_setor` decimal(12,2) NOT NULL CHECK (`harga_setor` >= 0),
  `subtotal_setor` decimal(15,2) GENERATED ALWAYS AS (`jumlah` * `harga_setor`) STORED,
  `foto_bukti` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `setoran`
--

INSERT INTO `setoran` (`id_setoran`, `id_pengguna`, `id_admin`, `id_jenis`, `tanggal_setoran`, `status_setoran`, `jumlah`, `harga_setor`, `foto_bukti`) VALUES
(1, 1, 1, 1, '2026-10-01', 'disetujui', 5.00, 3000.00, 'bukti/setoran_01.jpg'),
(2, 1, 1, 4, '2026-10-03', 'disetujui', 8.00, 2000.00, 'bukti/setoran_02.jpg'),
(3, 2, 2, 1, '2026-10-04', 'disetujui', 6.50, 3000.00, 'bukti/setoran_03.jpg'),
(4, 2, 2, 7, '2026-10-06', 'disetujui', 2.00, 9000.00, 'bukti/setoran_04.jpg'),
(5, 3, 1, 4, '2026-10-08', 'disetujui', 10.00, 2000.00, 'bukti/setoran_05.jpg'),
(6, 3, 1, 9, '2026-10-10', 'disetujui', 12.00, 800.00, 'bukti/setoran_06.jpg'),
(7, 4, 2, 1, '2026-10-12', 'disetujui', 20.00, 3000.00, 'bukti/setoran_07.jpg'),
(8, 4, 2, 2, '2026-10-15', 'disetujui', 15.00, 2500.00, 'bukti/setoran_08.jpg'),
(9, 5, 1, 8, '2026-10-18', 'disetujui', 30.00, 4000.00, 'bukti/setoran_09.jpg'),
(10, 5, 1, 7, '2026-10-20', 'disetujui', 5.00, 9000.00, 'bukti/setoran_10.jpg'),
(11, 8, 2, 5, '2026-10-22', 'disetujui', 7.00, 1800.00, 'bukti/setoran_11.jpg'),
(12, 8, 2, 6, '2026-10-25', 'ditolak', 4.00, 1500.00, 'bukti/setoran_12.jpg'),
(13, 1, NULL, 3, '2026-11-01', 'menunggu', 3.00, 1500.00, 'bukti/setoran_13.jpg'),
(14, 2, NULL, 4, '2026-11-02', 'menunggu', 9.00, 2000.00, 'bukti/setoran_14.jpg'),
(15, 4, NULL, 1, '2026-11-03', 'menunggu', 12.00, 3000.00, 'bukti/setoran_15.jpg');

--
-- Trigger `setoran`
--
DELIMITER $$
CREATE TRIGGER `trg_setoran_bukan_industri` BEFORE INSERT ON `setoran` FOR EACH ROW BEGIN
    DECLARE v_tipe VARCHAR(20);
    SELECT tipe_pengguna INTO v_tipe
    FROM pengguna WHERE id_pengguna = NEW.id_pengguna;

    IF v_tipe = 'industri' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Pengguna industri tidak dapat melakukan setoran';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(10) UNSIGNED NOT NULL,
  `id_setoran` int(10) UNSIGNED DEFAULT NULL,
  `id_pembelian` int(10) UNSIGNED DEFAULT NULL,
  `jenis_transaksi` enum('setoran','pembelian') NOT NULL,
  `total_nilai` decimal(15,2) NOT NULL DEFAULT 0.00,
  `tanggal_transaksi` datetime NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_setoran`, `id_pembelian`, `jenis_transaksi`, `total_nilai`, `tanggal_transaksi`) VALUES
(1, 1, NULL, 'setoran', 15000.00, '2026-10-01 10:00:00'),
(2, 2, NULL, 'setoran', 16000.00, '2026-10-03 10:00:00'),
(3, 3, NULL, 'setoran', 19500.00, '2026-10-04 10:00:00'),
(4, 4, NULL, 'setoran', 18000.00, '2026-10-06 10:00:00'),
(5, 5, NULL, 'setoran', 20000.00, '2026-10-08 10:00:00'),
(6, 6, NULL, 'setoran', 9600.00, '2026-10-10 10:00:00'),
(7, 7, NULL, 'setoran', 60000.00, '2026-10-12 10:00:00'),
(8, 8, NULL, 'setoran', 37500.00, '2026-10-15 10:00:00'),
(9, 9, NULL, 'setoran', 120000.00, '2026-10-18 10:00:00'),
(10, 10, NULL, 'setoran', 45000.00, '2026-10-20 10:00:00'),
(11, 11, NULL, 'setoran', 12600.00, '2026-10-22 10:00:00'),
(16, NULL, 1, 'pembelian', 100000.00, '2026-10-05 13:00:00'),
(17, NULL, 2, 'pembelian', 52500.00, '2026-10-09 13:00:00'),
(18, NULL, 3, 'pembelian', 22000.00, '2026-10-14 13:00:00'),
(19, NULL, 4, 'pembelian', 90000.00, '2026-10-07 13:00:00'),
(20, NULL, 5, 'pembelian', 33600.00, '2026-10-16 13:00:00'),
(21, NULL, 6, 'pembelian', 39600.00, '2026-10-21 13:00:00'),
(22, NULL, 7, 'pembelian', 80000.00, '2026-10-26 13:00:00'),
(23, NULL, 8, 'pembelian', 75000.00, '2026-10-28 13:00:00'),
(24, NULL, 9, 'pembelian', 33000.00, '2026-10-30 13:00:00'),
(25, NULL, 10, 'pembelian', 55000.00, '2026-11-01 13:00:00'),
(26, NULL, 13, 'pembelian', 6000.00, '2026-10-29 13:00:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `umkm`
--

CREATE TABLE `umkm` (
  `id_pengguna` int(10) UNSIGNED NOT NULL,
  `tipe_pengguna` enum('rumah_tangga','umkm','industri') NOT NULL DEFAULT 'umkm',
  `nama_usaha` varchar(150) NOT NULL,
  `jenis_usaha` varchar(100) DEFAULT NULL
) ;

--
-- Dumping data untuk tabel `umkm`
--

INSERT INTO `umkm` (`id_pengguna`, `tipe_pengguna`, `nama_usaha`, `jenis_usaha`) VALUES
(4, 'umkm', 'Warung Makan Bu Rina', 'Kuliner'),
(5, 'umkm', 'Bengkel Daur Ulang Agus', 'Kerajinan Daur Ulang');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD UNIQUE KEY `uq_admin_email` (`email`);

--
-- Indeks untuk tabel `alamat`
--
ALTER TABLE `alamat`
  ADD PRIMARY KEY (`id_alamat`);

--
-- Indeks untuk tabel `industri`
--
ALTER TABLE `industri`
  ADD PRIMARY KEY (`id_pengguna`),
  ADD KEY `fk_industri_pengguna` (`id_pengguna`,`tipe_pengguna`);

--
-- Indeks untuk tabel `jenis_sampah`
--
ALTER TABLE `jenis_sampah`
  ADD PRIMARY KEY (`id_jenis`),
  ADD KEY `fk_jenis_kategori` (`id_kategori`);

--
-- Indeks untuk tabel `kategori_sampah`
--
ALTER TABLE `kategori_sampah`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indeks untuk tabel `log_transaksi`
--
ALTER TABLE `log_transaksi`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `idx_log_transaksi` (`id_transaksi`);

--
-- Indeks untuk tabel `pembelian`
--
ALTER TABLE `pembelian`
  ADD PRIMARY KEY (`id_pembelian`),
  ADD KEY `idx_pembelian_pengguna` (`id_pengguna`),
  ADD KEY `idx_pembelian_admin` (`id_admin`),
  ADD KEY `idx_pembelian_jenis` (`id_jenis`);

--
-- Indeks untuk tabel `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id_pengguna`),
  ADD UNIQUE KEY `uq_pengguna_email` (`email`),
  ADD UNIQUE KEY `uq_pengguna_alamat` (`id_alamat`),
  ADD UNIQUE KEY `uq_pengguna_tipe` (`id_pengguna`,`tipe_pengguna`);

--
-- Indeks untuk tabel `rumah_tangga`
--
ALTER TABLE `rumah_tangga`
  ADD PRIMARY KEY (`id_pengguna`),
  ADD KEY `fk_rt_pengguna` (`id_pengguna`,`tipe_pengguna`);

--
-- Indeks untuk tabel `setoran`
--
ALTER TABLE `setoran`
  ADD PRIMARY KEY (`id_setoran`),
  ADD KEY `idx_setoran_pengguna` (`id_pengguna`),
  ADD KEY `idx_setoran_admin` (`id_admin`),
  ADD KEY `idx_setoran_jenis` (`id_jenis`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD UNIQUE KEY `uq_transaksi_setoran` (`id_setoran`),
  ADD UNIQUE KEY `uq_transaksi_pembelian` (`id_pembelian`);

--
-- Indeks untuk tabel `umkm`
--
ALTER TABLE `umkm`
  ADD PRIMARY KEY (`id_pengguna`),
  ADD KEY `fk_umkm_pengguna` (`id_pengguna`,`tipe_pengguna`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `alamat`
--
ALTER TABLE `alamat`
  MODIFY `id_alamat` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `jenis_sampah`
--
ALTER TABLE `jenis_sampah`
  MODIFY `id_jenis` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `kategori_sampah`
--
ALTER TABLE `kategori_sampah`
  MODIFY `id_kategori` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `log_transaksi`
--
ALTER TABLE `log_transaksi`
  MODIFY `id_log` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT untuk tabel `pembelian`
--
ALTER TABLE `pembelian`
  MODIFY `id_pembelian` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id_pengguna` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `setoran`
--
ALTER TABLE `setoran`
  MODIFY `id_setoran` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `industri`
--
ALTER TABLE `industri`
  ADD CONSTRAINT `fk_industri_pengguna` FOREIGN KEY (`id_pengguna`,`tipe_pengguna`) REFERENCES `pengguna` (`id_pengguna`, `tipe_pengguna`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `jenis_sampah`
--
ALTER TABLE `jenis_sampah`
  ADD CONSTRAINT `fk_jenis_kategori` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_sampah` (`id_kategori`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `log_transaksi`
--
ALTER TABLE `log_transaksi`
  ADD CONSTRAINT `fk_log_transaksi` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pembelian`
--
ALTER TABLE `pembelian`
  ADD CONSTRAINT `fk_pembelian_admin` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pembelian_jenis` FOREIGN KEY (`id_jenis`) REFERENCES `jenis_sampah` (`id_jenis`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pembelian_pengguna` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna` (`id_pengguna`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pengguna`
--
ALTER TABLE `pengguna`
  ADD CONSTRAINT `fk_pengguna_alamat` FOREIGN KEY (`id_alamat`) REFERENCES `alamat` (`id_alamat`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `rumah_tangga`
--
ALTER TABLE `rumah_tangga`
  ADD CONSTRAINT `fk_rt_pengguna` FOREIGN KEY (`id_pengguna`,`tipe_pengguna`) REFERENCES `pengguna` (`id_pengguna`, `tipe_pengguna`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `setoran`
--
ALTER TABLE `setoran`
  ADD CONSTRAINT `fk_setoran_admin` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_setoran_jenis` FOREIGN KEY (`id_jenis`) REFERENCES `jenis_sampah` (`id_jenis`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_setoran_pengguna` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna` (`id_pengguna`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `fk_transaksi_pembelian` FOREIGN KEY (`id_pembelian`) REFERENCES `pembelian` (`id_pembelian`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaksi_setoran` FOREIGN KEY (`id_setoran`) REFERENCES `setoran` (`id_setoran`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `umkm`
--
ALTER TABLE `umkm`
  ADD CONSTRAINT `fk_umkm_pengguna` FOREIGN KEY (`id_pengguna`,`tipe_pengguna`) REFERENCES `pengguna` (`id_pengguna`, `tipe_pengguna`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
