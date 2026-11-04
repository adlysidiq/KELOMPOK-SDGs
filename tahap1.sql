SELECT  
p.id_pengguna, 
p.nama, 
COUNT(id_setoran) AS jumlah_setor
FROM setoran s
JOIN pengguna p ON p.id_pengguna = s.id_pengguna 
GROUP BY id_pengguna, nama;
