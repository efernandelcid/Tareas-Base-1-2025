-- 1) Clientes de Brasil (ordenados por last_name)  [usa ORDER BY y función escalar]
SELECT
  first_name,
  last_name,
  LOWER(email) AS email,   -- función escalar
  country
FROM customer
WHERE country = 'Brazil'
ORDER BY last_name;

-- 2) Álbumes del artista "AC/DC"  [usa ORDER BY]
SELECT a.title
FROM album a
JOIN artist ar ON ar.artist_id = a.artist_id
WHERE ar.name = 'AC/DC'
ORDER BY a.title;

-- 3) Canciones que contengan "love" (ignorar mayúsculas)  [usa ILIKE + funciones escalares]
SELECT
  t.track_id,
  t.name,
  UPPER(t.name)  AS name_upper,     -- función escalar
  LENGTH(t.name) AS name_length,    -- función escalar
  t.album_id
FROM track t
WHERE t.name ILIKE '%love%';

-- 4) Facturas mayores a 10 dólares (de mayor a menor)  [usa ORDER BY]
SELECT
  invoice_id,
  invoice_date,
  billing_city  AS billing,
  billing_country AS country,
  total
FROM invoice
WHERE total > 10.00
ORDER BY total DESC;

-- 5) Los 5 clientes más recientes según customer_id  [usa ORDER BY + LIMIT]
SELECT
  customer_id,
  first_name,
  last_name,
  country
FROM customer
ORDER BY customer_id DESC
LIMIT 5;

-- 6) Canciones de más de 5 minutos (ms / 60000.0)  [operación matemática]
SELECT
  track_id,
  name,
  ROUND(milliseconds / 60000.0, 2) AS duration_min
FROM track
WHERE (milliseconds / 60000.0) > 5
ORDER BY duration_min DESC;

-- 7) Cantidad de clientes por país (descendente)  [usa ORDER BY]
SELECT
  country,
  COUNT(*) AS cantidad_clientes
FROM customer
GROUP BY country
ORDER BY cantidad_clientes DESC;

-- 8) Empleados con título exacto "Sales Support Agent"
SELECT
  employee_id,
  first_name,
  last_name,
  title,
  hire_date
FROM employee
WHERE title = 'Sales Support Agent';

-- 9) Top 10 canciones más largas (minutos)  [operación matemática + ORDER BY + LIMIT]
SELECT
  track_id,
  name,
  ROUND(milliseconds / 60000.0, 2) AS duration_min
FROM track
ORDER BY milliseconds DESC
LIMIT 10;

-- 10) Clientes cuyo apellido empiece con “S”  [usa ILIKE]
SELECT
  customer_id,
  first_name,
  last_name,
  country
FROM customer
WHERE last_name ILIKE 'S%';
