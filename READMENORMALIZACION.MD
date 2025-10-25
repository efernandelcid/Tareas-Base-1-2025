# Normalización de `Registro_Cursos` hasta 3NF

## EDGAR FERNANDO ZUÑIGA DEL CID 2890-23-25237

---

## Objetivo
Aplicar las tres primeras formas normales (1NF, 2NF y 3NF) a la tabla inicial `Registro_Cursos` y dejar un diseño funcional y verificado.

## Tabla original (0NF)
Estructura inicial (datos no atómicos y redundantes):

| ID_Registro | Curso             | Profesor    | Email_Profesor | Estudiantes              | Emails_Estudiantes                                   | Créditos | Facultad   |
|-------------|-------------------|-------------|----------------|--------------------------|------------------------------------------------------|----------|------------|
| 1           | Bases de Datos    | Ana Torres  | ana@uni.edu    | Luis, María, Jorge       | luis@uni.edu, maria@uni.edu, jorge@uni.edu           | 4        | Ingeniería |
| 2           | Programación Web  | Carlos López| carlos@uni.edu | Pedro, Ana, Lucía        | pedro@uni.edu, ana@uni.edu, lucia@uni.edu            | 5        | Ingeniería |

**Problemas detectados**
- Celdas **no atómicas** (listas separadas por comas).
- **Redundancia**: créditos y facultad dependen de *Curso*; email del profesor depende de *Profesor*.
- **Anomalías**: de inserción, actualización y borrado.

---

## 1. Primera Forma Normal (1NF)
**Regla:** celdas atómicas; sin grupos repetidos.

**Acción:** separar los estudiantes en filas individuales (o tabla aparte).

**Resultado (intermedio):**
- `Oferta_1NF(ID_Registro, Curso, Profesor, Email_Profesor, Créditos, Facultad)`
- `Matricula_1NF(ID_Registro, Estudiante, Email_Estudiante, PK(ID_Registro, Email_Estudiante))`

---

## 2. Segunda Forma Normal (2NF)
**Regla:** sin dependencias parciales (en claves compuestas).

**Acción:** crear entidades propias para los atributos dependientes de una sola parte de la clave o de otra entidad: `Curso`, `Profesor`, `Estudiante`, `Facultad`. La oferta del curso pasa a tabla propia y la relación con estudiantes queda en `Matricula`.

---

## 3. Tercera Forma Normal (3NF)
**Regla:** sin dependencias **transitivas** entre no‑claves.

**Acción:** mover `Créditos` y `Facultad` a `Curso`; `Email_Profesor` a `Profesor`. Las vistas de reporte se basan en joins.

---

## Diseño final (3NF)

### Esquema de tablas
```sql
-- Esquema academia (PostgreSQL)
CREATE TABLE Facultad (
  facultad_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Curso (
  curso_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(120) UNIQUE NOT NULL,
  creditos INT NOT NULL CHECK (creditos BETWEEN 1 AND 20),
  facultad_id INT NOT NULL REFERENCES Facultad(facultad_id)
);

CREATE TABLE Profesor (
  profesor_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  email VARCHAR(120) UNIQUE NOT NULL
);

CREATE TABLE Estudiante (
  estudiante_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  email VARCHAR(120) UNIQUE NOT NULL
);

CREATE TABLE OfertaCurso (
  oferta_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  curso_id INT NOT NULL REFERENCES Curso(curso_id),
  profesor_id INT NOT NULL REFERENCES Profesor(profesor_id),
  UNIQUE (curso_id, profesor_id)
);

CREATE TABLE Matricula (
  oferta_id INT NOT NULL REFERENCES OfertaCurso(oferta_id) ON DELETE CASCADE,
  estudiante_id INT NOT NULL REFERENCES Estudiante(estudiante_id) ON DELETE CASCADE,
  PRIMARY KEY (oferta_id, estudiante_id)
);
```

### Vistas para reporte
```sql
CREATE OR REPLACE VIEW vw_ofertas AS
SELECT o.oferta_id, c.nombre AS curso, c.creditos, f.nombre AS facultad,
       p.nombre AS profesor, p.email AS email_profesor
FROM OfertaCurso o
JOIN Curso c     ON c.curso_id = o.curso_id
JOIN Profesor p  ON p.profesor_id = o.profesor_id
JOIN Facultad f  ON f.facultad_id = c.facultad_id;

CREATE OR REPLACE VIEW vw_matriculas_detalle AS
SELECT o.oferta_id, c.nombre AS curso, e.nombre AS estudiante, e.email
FROM Matricula m
JOIN OfertaCurso o ON o.oferta_id = m.oferta_id
JOIN Curso c       ON c.curso_id = o.curso_id
JOIN Estudiante e  ON e.estudiante_id = m.estudiante_id;
```

### Índices
```sql
CREATE INDEX idx_oferta_curso   ON OfertaCurso (curso_id);
CREATE INDEX idx_oferta_prof    ON OfertaCurso (profesor_id);
CREATE INDEX idx_mat_oferta     ON Matricula (oferta_id);
CREATE INDEX idx_mat_estudiante ON Matricula (estudiante_id);
```

---

## Datos de ejemplo (tomados del enunciado)

```sql
INSERT INTO Facultad (nombre) VALUES ('Ingeniería');

INSERT INTO Curso (nombre, creditos, facultad_id)
VALUES ('Bases de Datos', 4, 1), ('Programación Web', 5, 1);

INSERT INTO Profesor (nombre, email)
VALUES ('Ana Torres', 'ana@uni.edu'), ('Carlos López', 'carlos@uni.edu');

INSERT INTO OfertaCurso (curso_id, profesor_id) VALUES (1,1), (2,2);

INSERT INTO Estudiante (nombre, email) VALUES
('Luis','luis@uni.edu'), ('María','maria@uni.edu'), ('Jorge','jorge@uni.edu'),
('Pedro','pedro@uni.edu'), ('Ana','ana_est@uni.edu'), ('Lucía','lucia@uni.edu');

INSERT INTO Matricula (oferta_id, estudiante_id)
SELECT 1, estudiante_id FROM Estudiante WHERE email IN ('luis@uni.edu','maria@uni.edu','jorge@uni.edu');

INSERT INTO Matricula (oferta_id, estudiante_id)
SELECT 2, estudiante_id FROM Estudiante WHERE email IN ('pedro@uni.edu','ana_est@uni.edu','lucia@uni.edu');
```

---

## Consultas de verificación
```sql
SELECT * FROM vw_ofertas ORDER BY oferta_id;
SELECT * FROM vw_matriculas_detalle ORDER BY oferta_id, estudiante;

SELECT o.oferta_id, c.nombre AS curso, COUNT(*) AS inscritos
FROM Matricula m
JOIN OfertaCurso o ON o.oferta_id = m.oferta_id
JOIN Curso c       ON c.curso_id = o.curso_id
GROUP BY o.oferta_id, c.nombre
ORDER BY o.oferta_id;
```


---

## Conclusión
La tabla original presentaba datos no atómicos y dependencias que causaban anomalías. La descomposición en `Curso`, `Profesor`, `Estudiante`, `Facultad`, `OfertaCurso` y `Matricula` elimina dependencias parciales y transitivas, llevando el modelo a **3NF**. El diseño resultante reduce la redundancia, mejora la integridad y facilita las operaciones de inserción, actualización y borrado sin efectos colaterales.

---

