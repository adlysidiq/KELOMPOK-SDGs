

// CREATE

INSERT INTO `setoran` (`id_setoran`, `id_pengguna`, `id_admin`, `id_jenis`, `tanggal_setoran`, `status_setoran`, `jumlah`, `harga_setor`, `foto_bukti`) VALUES
(700001,31375,2,5,'2025-01-30','disetujui',3.75,1800.00,'bukti/setoran_0250001.jpg');

INSERT INTO `alamat` (`id_alamat`, `jalan`, `kota`, `label`) VALUES
(100001,'Jl. Veteran No. 106','Malang','Rumah');

INSERT INTO `pengguna` (`id_pengguna`, `id_alamat`, `nama`, `email`, `password`, `no_telepon`, `status_akun`, `tipe_pengguna`) VALUES
(100001,100001,'Maya Setyagwati','maya.setygawati1@mail.com','bee5688aea66a47460b19c76f8f199c6b9585eb726f8322b1429793863609ca2','085790940711','aktif','rumah_tangga');



// READ
SELECT * FROM setoran;

// UPDATE 
UPDATE setoran
SET id_pengguna = 1000012
WHERE id_setoran = 1;

// DELETE
DELETE FROM pengguna WHERE id = 14;