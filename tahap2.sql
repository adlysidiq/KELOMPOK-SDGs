CREATE TABLE rekap_jumlah_setor AS
SELECT  
    p.id_pengguna, 
    p.nama, 
    COUNT(s.id_setoran) AS jumlah_setor
FROM setoran s
JOIN pengguna p ON p.id_pengguna = s.id_pengguna 
GROUP BY p.id_pengguna, p.nama;
