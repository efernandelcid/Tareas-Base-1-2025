
# PostgreSQL DDL desde Python (psycopg2) — Proyecto VS Code

Cumple con:
- Conectarse a PostgreSQL desde **Python**.
- Crear **al menos 2 tablas**.
- Operaciones DDL desde Python:
  - Agregar columnas nuevas.
  - Renombrar columnas.
  - Eliminar columnas.
  - Agregar un **CHECK**.
  - Eliminar una tabla.
- Incluir `README.md`, `main.py` y PDF para enlaces de entrega.

## Requisitos
- Python 3.10+
- Docker (opcional) con contenedor `practicas-pyton`
- VS Code + extensión Python

## Arrancar DB (opcional con Docker)
```powershell
# crea/arranca el contenedor practicas-pyton en 5432
./start_db.ps1
```

## Configurar .env
Copia `.env.example` a `.env` y ajusta si cambiaste puerto/usuario:
```ini
PGHOST=localhost
PGPORT=5432
PGUSER=postgres
PGPASSWORD=postgres
PGDATABASE=practicas_pyton
```

## Ejecutar
```powershell
# crear venv e instalar
py -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt

# correr
python .\main.py
```

## Verificar con psql (Docker)
```powershell
docker exec -it practicas-pyton psql -U postgres -d practicas_pyton
\dt
\d authors
\d books
SELECT * FROM authors;
SELECT * FROM books;
```
