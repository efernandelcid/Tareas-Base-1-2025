# Proyecto: Consultas en la base de datos Chinook (PostgreSQL)

Este proyecto muestra cómo restaurar la base de datos **Chinook** en PostgreSQL utilizando Docker y cómo ejecutar al menos 5 consultas `SELECT` desde DataGrip.

## Restauración de la base de datos
La restauración se realizó de dos formas posibles:
1. Con Docker: se usó la imagen oficial de PostgreSQL, se levantó el contenedor con `docker compose up -d` y el archivo `Chinook_PostgreSql.sql` se colocó dentro de la carpeta `init/` para que se ejecutara automáticamente.
2. Manual en DataGrip: se creó la base `chinook` y se ejecutó el script `Chinook_PostgreSql.sql` desde DataGrip para generar las tablas y poblar los datos.

## Consultas realizadas
```sql
-- Consulta 1: Seleccionar todas las columnas de una tabla
SELECT * FROM album;

-- Consulta 2: Seleccionar solo algunas columnas de una tabla
SELECT first_name, last_name, email
FROM customer;

-- Consulta 3: Seleccionar registros de diferentes tablas sin filtros
SELECT t.name AS track, a.title AS album, r.name AS artist
FROM track t
JOIN album a  ON t.album_id = a.album_id
JOIN artist r ON a.artist_id = r.artist_id;

-- Consulta 4: Usar LIMIT para mostrar solo algunos resultados
SELECT * FROM invoice
ORDER BY total DESC
LIMIT 5;

-- Consulta 5: Seleccionar todas las filas de una tabla utilizando *
SELECT * FROM invoice_line;
