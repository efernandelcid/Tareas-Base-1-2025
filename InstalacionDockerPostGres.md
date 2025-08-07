# PostgreSQL con Docker y DataGrip
### EDGAR FERNANDO ZUÑIGA DEL CID 2890-23-25237

Este repositorio contiene una guía paso a paso para:

- Ejecutar PostgreSQL en un contenedor Docker.
- Configurar la conexión desde DataGrip.
- Crear una base de datos PostgreSQL desde DataGrip.

---

## Paso 1: Descargar e iniciar PostgreSQL en Docker

Abre una terminal y ejecuta el siguiente comando:

```bash
docker run --name postgres-db -e POSTGRES_PASSWORD=yourpassword -p 5432:5432 -d postgres
```

Luego asegúrate de que el contenedor esté activo con:

```bash
docker ps
```

---

## Paso 2: Instalar DataGrip

- Descarga e instala DataGrip desde [JetBrains DataGrip](https://www.jetbrains.com/datagrip/).
- Registra tu licencia gratuita con tu correo institucional de la UMG.

---

## Paso 3: Configuración en DataGrip

1. Abre DataGrip.
2. Ve a **File → Data Sources and Drivers**.
3. Haz clic en el botón **+** y selecciona **PostgreSQL**.
4. Configura los siguientes datos de conexión:

   - **Host:** `localhost`
   - **Port:** `5432`
   - **User:** `postgres`
   - **Password:** `yourpassword`
   - **Database:** `postgres`

5. Haz clic en **Test Connection** para verificar la conexión.
6. Si es exitosa, haz clic en **OK** para guardar.

---

## Paso 4: Crear tu Base de Datos

1. Abre una nueva consola SQL en DataGrip.
2. Ejecuta el siguiente comando para crear una nueva base de datos:

```sql
CREATE DATABASE my_first_database;
```

---

## Resultado esperado

- Contenedor PostgreSQL corriendo en Docker.
- Conexión establecida correctamente en DataGrip.
- Base de datos creada exitosamente desde la consola SQL de DataGrip.