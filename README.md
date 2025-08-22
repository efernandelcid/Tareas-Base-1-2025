# Proyecto de Bases de Datos en PostgreSQL

Este repositorio contiene la implementación de tres modelos de base de datos diferentes en **PostgreSQL**, cada uno basado en un enunciado dado.  
El archivo SQL (`proyecto.sql`) incluye las sentencias `CREATE TABLE` y las relaciones con sus llaves primarias y foráneas.

---

## 1. Registro de importación de vehículos

**Descripción:**  
Una empresa de importación recibe vehículos de distintos países. Los vehículos se agrupan en lotes y se asignan a concesionarios locales.

**Entidades principales:**
- **Lote de importación:** código, fecha de llegada, país de origen.  
- **Concesionario:** código, nombre comercial, dirección, persona de contacto.  
- **Vehículo:** número de serie, marca, modelo, año, velocidad máxima, precio, id de lote y concesionario.  

**Estructura SQL:**
```sql
CREATE TABLE lote_importacion (...);
CREATE TABLE concesionario (...);
CREATE TABLE vehiculo (...);
```

---

## 2. Plataforma de gestión de eventos deportivos

**Descripción:**  
Un sistema que administra torneos de fútbol, baloncesto, voleibol, etc. Los torneos registran partidos, equipos participantes y estadios.

**Entidades principales:**
- **Torneo:** nombre, fechas, ciudad sede.  
- **Equipo:** nombre oficial, año de fundación, entrenador.  
- **Estadio:** nombre, capacidad, ubicación.  
- **Partido:** código, fecha, equipos participantes, marcador, estadio.  

**Estructura SQL:**
```sql
CREATE TABLE torneo (...);
CREATE TABLE equipo (...);
CREATE TABLE estadio (...);
CREATE TABLE partido (...);
```

---

## 3. Sistema de seguimiento de envíos internacionales

**Descripción:**  
Una compañía de logística maneja envíos, con remitente, destinatario, servicio de transporte y eventos de seguimiento.

**Entidades principales:**
- **Cliente:** código, nombre, dirección, teléfono.  
- **Servicio de transporte:** código, tipo de transporte, empresa operadora.  
- **Envío:** número de guía, fecha de creación, peso, valor declarado, cliente remitente y destinatario.  
- **Evento de seguimiento:** código, fecha, hora, ubicación, estado del paquete.  

**Estructura SQL:**
```sql
CREATE TABLE cliente (...);
CREATE TABLE servicio_transporte (...);
CREATE TABLE envio (...);
CREATE TABLE evento_seguimiento (...);
```

---

