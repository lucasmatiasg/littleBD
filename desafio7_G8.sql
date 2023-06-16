-- #GRUPO 8#
-- Correa Sapiega, Ignacio Julián
-- Díaz, Liliana Esther
-- Gómez, Lucas Matías
-- Sasowsky, María Carolina

-- Crear Base de Datos para el desafío 7

CREATE DATABASE IF NOT EXISTS desafio_7;

-- Seleccionar base de datos creada:

USE desafio_7;

-- Consigna: escribir los comandos SQL que permitan la creacion de las tablas con sus respectivas restricciones de claves primarias y foraneas.

-- #Primero# Agregar comando necesario que introduzca en la tabla usuario, 1 usuario con rol de admin, 4 con rol de administrador, y 5 con rol de publico.
-- Donde los campos: es_publico, es_colaborador, es_admin son boleanos.

-- Crear tabla para "Usuario":

CREATE TABLE usuario (
	id_usuario INT NOT NULL AUTO_INCREMENT,
	nombre   VARCHAR(64) NOT NULL,
	apellido VARCHAR(64) NULL,
	telefono VARCHAR(20) NULL UNIQUE,
	username VARCHAR(64) NOT NULL, 
	email    VARCHAR(64) NOT NULL UNIQUE,
	contrasena  VARCHAR(32) NOT NULL,
	estado   BOOLEAN,
	fecha_creacion DATE NULL,
	avatar BLOB NULL,
	es_publico BOOLEAN,
	es_colaborador BOOLEAN,
	es_admin BOOLEAN,
    PRIMARY KEY(id_usuario)
    );


 -- Agregar usuarios con roles   
    
INSERT INTO usuario (nombre, username, email, contrasena, es_publico, es_colaborador, es_admin)
VALUES ('admin', 'user1', 'email@email1', '1234', FALSE, FALSE, TRUE);

INSERT INTO usuario (nombre, username, email, contrasena, es_publico, es_colaborador, es_admin)
VALUES ('colab1', 'user2', 'email@email2', '1234', FALSE, TRUE, FALSE),
	   ('colab2', 'user3', 'email@email3', '1234', FALSE, TRUE, FALSE),
       ('colab3', 'user4', 'email@email4', '1234', FALSE, TRUE, FALSE),
       ('colab4', 'user5', 'email@email5', '1234', FALSE, TRUE, FALSE);

INSERT INTO usuario (nombre, username, email, contrasena, es_publico, es_colaborador, es_admin)
VALUES ('Publico1',  'user6', 'email@email6', '1234',TRUE, FALSE, FALSE),
	   ('Publico5',  'user7', 'email@email7', '1234',TRUE, FALSE, FALSE),
       ('Publico6',  'user8', 'email@email8', '1234',TRUE, FALSE, FALSE),
       ('Publico7',  'user9', 'email@email9', '1234',TRUE, FALSE, FALSE),
       ('Publico8',  'user10', 'email@email10','1234',TRUE, FALSE, FALSE);
    
-- ///Para probar y eliminar
SELECT * FROM usuario;

-- #Segundo# Agregar el comando necesario para actualizar el rol a admin de uno de los usuarios agregados con rol de colaborador. 

UPDATE usuario SET es_colaborador = FALSE,
es_admin = TRUE WHERE id_usuario = 2;

-- ///Para probar y eliminar
SELECT * FROM usuario;

-- #Tercero# Agregar el comando necesario que introduzca en la tabla "Articulo", 3 articulos con estado TRUE y uno con estado FALSE.
-- Donde el campo estado en todas las tablas es Booleano.

-- Crear una tabla para "Articulo" con el campo 'estado' y sus 'valores'.

CREATE TABLE articulo (
id_articulo INT NOT NULL AUTO_INCREMENT,
titulo VARCHAR(100),
resumen TEXT NOT NULL,
contenido LONGTEXT NOT NULL,
fecha_publicacion DATE,
estado BOOLEAN,
imagen BLOB NULL,
PRIMARY KEY (id_articulo)
);

ALTER TABLE articulo
ADD COLUMN id_usuario INT;


-- Agregar a la tabla 3 articulos con "estado" TRUE, y un articulo con "estado" FALSE. --

INSERT INTO articulo (titulo, resumen, contenido, fecha_publicacion, estado)
VALUES ('Articulo1', 'resumen1', 'contenido1', '2023-01-01', TRUE),
	   ('Articulo2', 'resumen2', 'contenido2', '2023-01-01', TRUE),
       ('Articulo3', 'resumen3', 'contenido3', '2023-01-01', TRUE),
       ('Articulo4', 'resumen4', 'contenido4', '2023-01-01', FALSE);

-- ///Para probar y eliminar
SELECT * FROM articulo;

-- #Cuarto# Agregar el "comando" necesario para eliminar el articulo con "estado FALSE".

DELETE FROM articulo
WHERE estado = FALSE;


-- #Quinto# Agregar el comando necesario que introduzca 3 comentarios al primer artículo agregado y 2 comentarios al segundo artículo.

-- Creación de la tabla "Comentario".

CREATE TABLE comentario (
id_comentario INT NOT NULL AUTO_INCREMENT,
id_usuario INT NOT NULL ,
id_articulo INT NOT NULL,
fecha_hora DATETIME,
comentario_texto TEXT,
estado BOOLEAN NULL,
PRIMARY KEY (id_comentario),
FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
FOREIGN KEY (id_articulo) REFERENCES articulo(id_articulo)
);


INSERT INTO comentario (id_usuario, id_articulo, fecha_hora, comentario_texto)
VALUES(1, 1, '2023-12-1 22:20:59', 'Primer Comentario'),
	  (1, 1, '2023-12-1 22:20:59', 'Segundo Comentario'),
      (1, 1, '2023-12-1 22:20:59', 'Tercer Comentario'),
      (2, 2, '2023-12-1 22:20:59', 'Primer Comentario segundo artículo'),
      (2, 2, '2023-12-1 22:20:59', 'Segundo Comentario segundo artículo');
	
-- #Sexto# Agregar el comando necesario para listar todos los artículos que tengan comentarios, mostrando el titulo del articulo,--
-- la fecha_publicacion del articulo, el nombre del usuario que realizo el comentario y la fecha_hora que realizo dicho comentario--
-- agrupados por articulos.

SELECT articulo.titulo, articulo.fecha_publicacion, usuario.nombre, comentario.fecha_hora
FROM articulo
JOIN comentario ON articulo.id_articulo = comentario.id_articulo
JOIN usuario ON comentario.id_usuario = usuario.id_usuario
ORDER BY articulo.titulo;


