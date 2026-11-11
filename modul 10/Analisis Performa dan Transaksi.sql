
// EXPLAIN
EXPLAIN SELECT * FROM setoran WHERE jumlah >= 5 ABD jumlah <= 15;

// membuat index
ALTER TABLE setoran ADD INDEX(`id_setoran`, `id_pengguna`, 'jumlah');

//COMMIT
START TRANSACTION;

INSERTT INTO admin (`nama`, `email`)
VALUE (`ajima`,`ajima23@olutra.id`)

COMMIT;

//ROLLBACK
START TRANSACTION;

DELETE FROM admin WHERE id_admin = 11;

ROLLBACK;
