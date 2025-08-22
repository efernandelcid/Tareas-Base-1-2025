-- BASE de registro de importación de vehículos
CREATE TABLE lote_importacion (
  id_lote           INT PRIMARY KEY,
  codigo_lote       VARCHAR(50) NOT NULL,
  fecha_llegada     DATE NOT NULL,
  pais_origen       VARCHAR(60) NOT NULL
);

CREATE TABLE concesionario (
  id_concesionario      INT PRIMARY KEY,
  codigo_concesionario  VARCHAR(30) NOT NULL,
  nombre_comercial      VARCHAR(80) NOT NULL,
  direccion             VARCHAR(200) NOT NULL,
  persona_contacto      VARCHAR(80)
);

CREATE TABLE vehiculo (
  id_vehiculo        INT PRIMARY KEY,
  numero_serie       VARCHAR(25) NOT NULL,
  marca              VARCHAR(50) NOT NULL,
  modelo             VARCHAR(50) NOT NULL,
  ano_fabricacion    INT NOT NULL,
  velocidad_max_kmh  INT,
  precio_declarado   DECIMAL(12,2) NOT NULL,
  id_lote            INT NOT NULL,
  id_concesionario   INT NOT NULL,
  FOREIGN KEY (id_lote) REFERENCES lote_importacion(id_lote),
  FOREIGN KEY (id_concesionario) REFERENCES concesionario(id_concesionario)
);

-- BASE De Plataforma de gestión de eventos deportivos

CREATE TABLE torneo (
  id_torneo       INT PRIMARY KEY,
  nombre          VARCHAR(100) NOT NULL,
  fecha_inicio    DATE NOT NULL,
  fecha_fin       DATE NOT NULL,
  ciudad_sede     VARCHAR(100) NOT NULL
);

CREATE TABLE equipo (
  id_equipo       INT PRIMARY KEY,
  nombre_oficial  VARCHAR(100) NOT NULL,
  anio_fundacion  INT,
  entrenador      VARCHAR(80)
);

CREATE TABLE estadio (
  id_estadio   INT PRIMARY KEY,
  nombre       VARCHAR(100) NOT NULL,
  capacidad    INT,
  ubicacion    VARCHAR(150)
);

CREATE TABLE partido (
  id_partido      INT PRIMARY KEY,
  fecha           DATE NOT NULL,
  marcador_final  VARCHAR(20),
  id_torneo       INT NOT NULL,
  id_equipo_local INT NOT NULL,
  id_equipo_vis   INT NOT NULL,
  id_estadio      INT NOT NULL,
  FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo),
  FOREIGN KEY (id_equipo_local) REFERENCES equipo(id_equipo),
  FOREIGN KEY (id_equipo_vis) REFERENCES equipo(id_equipo),
  FOREIGN KEY (id_estadio) REFERENCES estadio(id_estadio)
);


-- BASE De Sistema de seguimiento de envíos internacionales

CREATE TABLE cliente (
  id_cliente       INT PRIMARY KEY,
  codigo_cliente   VARCHAR(20) NOT NULL,
  nombre           VARCHAR(100) NOT NULL,
  direccion        VARCHAR(150) NOT NULL,
  telefono         VARCHAR(30)
);

CREATE TABLE servicio_transporte (
  id_servicio        INT PRIMARY KEY,
  codigo_servicio    VARCHAR(20) NOT NULL,
  tipo_transporte    VARCHAR(20) NOT NULL,
  empresa_operadora  VARCHAR(100) NOT NULL
);

CREATE TABLE envio (
  id_envio                 INT PRIMARY KEY,
  numero_guia              VARCHAR(30) NOT NULL,
  fecha_creacion           DATE NOT NULL,
  peso_kg                  DECIMAL(10,2),
  valor_declarado          DECIMAL(12,2) NOT NULL,
  id_cliente_remitente     INT NOT NULL,
  id_cliente_destinatario  INT NOT NULL,
  id_servicio              INT NOT NULL,
  FOREIGN KEY (id_cliente_remitente) REFERENCES cliente(id_cliente),
  FOREIGN KEY (id_cliente_destinatario) REFERENCES cliente(id_cliente),
  FOREIGN KEY (id_servicio) REFERENCES servicio_transporte(id_servicio)
);

CREATE TABLE evento_seguimiento (
  id_evento       INT PRIMARY KEY,
  codigo_evento   VARCHAR(20) NOT NULL,
  fecha           DATE NOT NULL,
  hora            TIME NOT NULL,
  ubicacion       VARCHAR(120),
  estado          VARCHAR(40),
  id_envio        INT NOT NULL,
  FOREIGN KEY (id_envio) REFERENCES envio(id_envio)
);


