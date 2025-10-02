# DML con filtros, funciones escalares y ordenamientos
## Edgar Fernando Zuñiga Del Cid 2890-23-25237
# Consultas SQL – Chinook (PostgreSQL)

Este repositorio contiene un script SQL con 10 consultas sobre la base de datos **Chinook** (versión PostgreSQL).  
El archivo principal es `consultas.sql`.

## Cómo ejecutar

1. Restaura Chinook en PostgreSQL (por ejemplo con Docker o desde tu cliente SQL).
2. Asegúrate de que las tablas usan los nombres en minúsculas (`customer`, `invoice`, `track`, `album`, `artist`, `employee`, etc.).
3. Abre `consultas.sql` en tu IDE (DataGrip, psql, DBeaver) y ejecútalo.

---

## Descripción de cada consulta

### 1) Clientes de Brasil
**Qué hace:** lista clientes cuyo `country` es **Brazil**, ordenados por `last_name`.  
**Devuelve columnas:** `first_name`, `last_name`, `email` (en minúsculas), `country`.  
**Notas:** usa `LOWER(email)` como función escalar y `ORDER BY last_name`.

---

### 2) Álbumes del artista “AC/DC”
**Qué hace:** muestra los títulos de los álbumes cuyo artista es exactamente **AC/DC**.  
**Devuelve columnas:** `title` (de `album`).  
**Notas:** `JOIN` entre `album` y `artist`, filtrando por `artist.name = 'AC/DC'`. Ordena alfabéticamente por `title`.

---

### 3) Canciones que contengan “love” (ignorar mayúsculas)
**Qué hace:** busca tracks cuyo `name` contiene la palabra “love” sin importar mayúsculas/minúsculas.  
**Devuelve columnas:** `track_id`, `name`, `name_upper` (versión en mayúsculas), `name_length` (longitud), `album_id`.  
**Notas:** usa `ILIKE '%love%'` + funciones escalares `UPPER` y `LENGTH`.

---

### 4) Facturas mayores a 10 dólares
**Qué hace:** lista facturas con `total > 10.00`, de mayor a menor monto.  
**Devuelve columnas:** `invoice_id`, `invoice_date`, `billing` (ciudad), `country` (de facturación), `total`.  
**Notas:** ordena con `ORDER BY total DESC`.

---

### 5) Los 5 clientes más recientes
**Qué hace:** muestra los **últimos 5** clientes según `customer_id` (mayor id = más reciente).  
**Devuelve columnas:** `customer_id`, `first_name`, `last_name`, `country`.  
**Notas:** utiliza `ORDER BY customer_id DESC LIMIT 5`.

---

### 6) Canciones de más de 5 minutos
**Qué hace:** convierte la duración de `milliseconds` a **minutos** y filtra las canciones con duración **> 5**.  
**Devuelve columnas:** `track_id`, `name`, `duration_min` (minutos redondeados a 2 decimales).  
**Notas:** operación matemática `milliseconds / 60000.0`, ordenado de mayor a menor por duración.

---

### 7) Cantidad de clientes por país
**Qué hace:** agrupa clientes por `country` y cuenta cuántos hay por país.  
**Devuelve columnas:** `country`, `cantidad_clientes` (conteo).  
**Notas:** `GROUP BY country` y `ORDER BY cantidad_clientes DESC`.

---

### 8) Empleados con título específico
**Qué hace:** lista empleados cuyo `title` es exactamente **"Sales Support Agent"**.  
**Devuelve columnas:** `employee_id`, `first_name`, `last_name`, `title`, `hire_date`.  
**Notas:** filtro por igualdad exacta del `title`.

---

### 9) Top 10 canciones más largas
**Qué hace:** ordena todas las canciones por duración y devuelve las **10** más largas (en minutos).  
**Devuelve columnas:** `track_id`, `name`, `duration_min` (minutos redondeados).  
**Notas:** `ORDER BY milliseconds DESC LIMIT 10` + conversión a minutos.

---

### 10) Clientes cuyo apellido empiece con “S”
**Qué hace:** lista clientes cuyo `last_name` inicia con la letra **S** (sin distinguir mayúsculas).  
**Devuelve columnas:** `customer_id`, `first_name`, `last_name`, `country`.  
**Notas:** usa `ILIKE 'S%'`.

---

## Requisitos mínimos y cómo se cumplen

- **LIKE/ILIKE (≥2):**  
  - #3 (ILIKE), #10 (ILIKE)
- **Funciones escalares (≥2):**  
  - #1 `LOWER(email)`, #3 `UPPER(name)` y `LENGTH(name)`
- **ORDER BY (≥3):**  
  - #1, #2, #4, #6, #7, #9 (varias lo usan)
- **LIMIT (≥2):**  
  - #5 (`LIMIT 5`), #9 (`LIMIT 10`)
- **Operación matemática (≥1):**  
  - #6 y #9 convierten `milliseconds / 60000.0` a minutos y redondean.

---

## Archivos

- `consultas.sql` – Contiene las 10 consultas listas para ejecutar.
- `README.md` – Este documento.

---

## Notas de compatibilidad

- Si tus tablas/columnas están en **CamelCase** (algunas distribuciones de Chinook), ajusta comillas dobles:  
  por ejemplo `"Customer"`, `"FirstName"`, `"LastName"`, etc.  
- Este proyecto asume nombres en minúsculas según una restauración común de Chinook para PostgreSQL.

---
