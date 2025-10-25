
-- 01_schema_uni.sql
-- Ejecutar conectados a la base "uni"
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_namespace WHERE nspname = 'academia') THEN
    EXECUTE 'DROP SCHEMA academia CASCADE';
  END IF;
END $$;

CREATE SCHEMA academia;
SET search_path TO academia, public;

-- Catálogos
CREATE TABLE academia.Facultad (
  facultad_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE academia.Curso (
  curso_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(120) UNIQUE NOT NULL,
  creditos INT NOT NULL CHECK (creditos BETWEEN 1 AND 20),
  facultad_id INT NOT NULL REFERENCES academia.Facultad(facultad_id)
);

CREATE TABLE academia.Profesor (
  profesor_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  email VARCHAR(120) UNIQUE NOT NULL
);

CREATE TABLE academia.Estudiante (
  estudiante_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  email VARCHAR(120) UNIQUE NOT NULL
);

-- Oferta (sección/edición del curso)
CREATE TABLE academia.OfertaCurso (
  oferta_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  curso_id INT NOT NULL REFERENCES academia.Curso(curso_id),
  profesor_id INT NOT NULL REFERENCES academia.Profesor(profesor_id),
  UNIQUE (curso_id, profesor_id)
);

-- Relación N–a–N
CREATE TABLE academia.Matricula (
  oferta_id INT NOT NULL REFERENCES academia.OfertaCurso(oferta_id) ON DELETE CASCADE,
  estudiante_id INT NOT NULL REFERENCES academia.Estudiante(estudiante_id) ON DELETE CASCADE,
  PRIMARY KEY (oferta_id, estudiante_id)
);

-- Datos de ejemplo
INSERT INTO academia.Facultad (nombre) VALUES ('Ingeniería');

INSERT INTO academia.Curso (nombre, creditos, facultad_id)
VALUES ('Bases de Datos', 4, 1),
       ('Programación Web', 5, 1);

INSERT INTO academia.Profesor (nombre, email)
VALUES ('Ana Torres', 'ana@uni.edu'),
       ('Carlos López', 'carlos@uni.edu');

INSERT INTO academia.OfertaCurso (curso_id, profesor_id) VALUES (1, 1), (2, 2);

INSERT INTO academia.Estudiante (nombre, email) VALUES
('Luis',  'luis@uni.edu'),
('María', 'maria@uni.edu'),
('Jorge', 'jorge@uni.edu'),
('Pedro', 'pedro@uni.edu'),
('Ana',   'ana_est@uni.edu'),
('Lucía', 'lucia@uni.edu');

INSERT INTO academia.Matricula (oferta_id, estudiante_id)
SELECT 1, estudiante_id FROM academia.Estudiante
WHERE email IN ('luis@uni.edu','maria@uni.edu','jorge@uni.edu');

INSERT INTO academia.Matricula (oferta_id, estudiante_id)
SELECT 2, estudiante_id FROM academia.Estudiante
WHERE email IN ('pedro@uni.edu','ana_est@uni.edu','lucia@uni.edu');

-- Vistas
CREATE OR REPLACE VIEW academia.vw_ofertas AS
SELECT o.oferta_id, c.nombre AS curso, c.creditos, f.nombre AS facultad,
       p.nombre AS profesor, p.email AS email_profesor
FROM academia.OfertaCurso o
JOIN academia.Curso c ON c.curso_id = o.curso_id
JOIN academia.Profesor p ON p.profesor_id = o.profesor_id
JOIN academia.Facultad f ON f.facultad_id = c.facultad_id;

CREATE OR REPLACE VIEW academia.vw_matriculas_detalle AS
SELECT o.oferta_id, c.nombre AS curso, e.nombre AS estudiante, e.email
FROM academia.Matricula m
JOIN academia.OfertaCurso o ON o.oferta_id = m.oferta_id
JOIN academia.Curso c       ON c.curso_id = o.curso_id
JOIN academia.Estudiante e  ON e.estudiante_id = m.estudiante_id;

-- Índices
CREATE INDEX idx_oferta_curso   ON academia.OfertaCurso (curso_id);
CREATE INDEX idx_oferta_prof    ON academia.OfertaCurso (profesor_id);
CREATE INDEX idx_mat_oferta     ON academia.Matricula (oferta_id);
CREATE INDEX idx_mat_estudiante ON academia.Matricula (estudiante_id);

-- Consultas de verificación (descomenta para probar)
-- SELECT * FROM academia.vw_ofertas ORDER BY oferta_id;
-- SELECT * FROM academia.vw_matriculas_detalle ORDER BY oferta_id, estudiante;
-- SELECT o.oferta_id, c.nombre AS curso, COUNT(*) AS inscritos
-- FROM academia.Matricula m
-- JOIN academia.OfertaCurso o ON o.oferta_id = m.oferta_id
-- JOIN academia.Curso c       ON c.curso_id = o.curso_id
-- GROUP BY o.oferta_id, c.nombre
-- ORDER BY o.oferta_id;

SELECT * FROM academia.vw_ofertas ORDER BY oferta_id;
SELECT * FROM academia.vw_matriculas_detalle ORDER BY oferta_id, estudiante;

SELECT o.oferta_id, c.nombre AS curso, COUNT(*) AS inscritos
FROM academia.Matricula m
JOIN academia.OfertaCurso o ON o.oferta_id = m.oferta_id
JOIN academia.Curso c       ON c.curso_id = o.curso_id
GROUP BY o.oferta_id, c.nombre
ORDER BY o.oferta_id;

SELECT current_database();
SHOW search_path;  -- debería mostrar: "academia, public"

DROP VIEW IF EXISTS academia.vw_matriculas_detalle;

CREATE OR REPLACE VIEW academia.vw_matriculas_detalle AS
SELECT
  o.oferta_id,
  c.nombre AS curso,
  e.nombre AS estudiante,
  e.email
FROM academia.Matricula m
JOIN academia.OfertaCurso o ON o.oferta_id = m.oferta_id
JOIN academia.Curso       c ON c.curso_id = o.curso_id
JOIN academia.Estudiante  e ON e.estudiante_id = m.estudiante_id;

DROP VIEW IF EXISTS academia.vw_ofertas;

CREATE OR REPLACE VIEW academia.vw_ofertas AS
SELECT
  o.oferta_id,
  c.nombre AS curso,
  c.creditos,
  f.nombre AS facultad,
  p.nombre AS profesor,
  p.email  AS email_profesor
FROM academia.OfertaCurso o
JOIN academia.Curso    c ON c.curso_id     = o.curso_id
JOIN academia.Profesor p ON p.profesor_id  = o.profesor_id
JOIN academia.Facultad f ON f.facultad_id  = c.facultad_id;

SELECT * FROM academia.vw_ofertas ORDER BY oferta_id;
SELECT * FROM academia.vw_matriculas_detalle ORDER BY oferta_id, estudiante;

SELECT table_schema, table_name
FROM information_schema.views
WHERE table_schema = 'academia';

