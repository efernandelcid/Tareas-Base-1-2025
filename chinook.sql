-- 1) Todas las columnas de una tabla
SELECT * FROM album;

-- 2) Solo algunas columnas
SELECT first_name, last_name, email
FROM customer;

-- 3) Diferentes tablas sin filtros (JOIN)
SELECT
  t.name  AS track,
  a.title AS album,
  r.name  AS artist
FROM track t
JOIN album a  ON t.album_id  = a.album_id
JOIN artist r ON a.artist_id = r.artist_id;

-- 4) LIMIT para algunos resultados
SELECT * FROM invoice
ORDER BY total DESC
LIMIT 5;

-- 5) Todas las filas usando *
SELECT * FROM invoice_line;
