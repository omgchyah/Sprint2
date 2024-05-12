DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify CHARACTER SET utf8mb4;
USE spotify;

CREATE TABLE usuario (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM("free", "premium") NOT NULL,
    email VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    nombre_usuario VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    sexo ENUM("mujer", "hombre", "no binario") NOT NULL,
    pais VARCHAR(30) NOT NULL,
    codigo_postal VARCHAR(20) NOT NULL
);

-- Para usuarios premium
CREATE TABLE subscripcion (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	id_usuario INT UNSIGNED NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_renovacion DATE NOT NULL,
    forma_pago ENUM("tarjeta de crédito", "PayPal") NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

-- Datos de la tarjeta de crédito
CREATE TABLE tarjeta_credito (
	id_usuario INT UNSIGNED NOT NULL,
	numero BIGINT(16) UNSIGNED NOT NULL,
    mes_caducidad INT NOT NULL,
    anyo_caducidad INT NOT NULL,
    codigo_seguridad INT(3) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

CREATE TABLE paypal (
	id_usuario INT UNSIGNED NOT NULL,
    usuario_paypal VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

CREATE TABLE pago_subscripcion (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT UNSIGNED NOT NULL,
    id_subscripcion INT UNSIGNED NOT NULL,
    fecha_pago DATE NOT NULL,
    orden VARCHAR(20) UNIQUE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_subscripcion) REFERENCES subscripcion(id)
);

CREATE TABLE playlist (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	titulo VARCHAR(30) NOT NULL,
	id_usuario INT UNSIGNED NOT NULL,
    numero_canciones INT UNSIGNED NOT NULL,
    estado ENUM("activa", "eliminada"),
    fecha_creacion DATE NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

-- Tabla para relacionar artistas
CREATE TABLE genero (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL
);

CREATE TABLE artista (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    imagen BLOB,
	id_genero INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_genero) REFERENCES genero(id)
);

CREATE TABLE album (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_artista INT UNSIGNED NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    anyo INT(4) NOT NULL,
    imagen_portada BLOB,
    FOREIGN KEY (id_artista) REFERENCES artista(id)
);

CREATE TABLE cancion (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_artista INT UNSIGNED NOT NULL,
    id_album INT UNSIGNED NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    duracion INT NOT NULL,
    reproducciones INT NOT NULL,
    FOREIGN KEY (id_artista) REFERENCES artista(id),
    FOREIGN KEY (id_album) REFERENCES album(id)
);

-- Agregar cancion a playlist
CREATE TABLE agregar_cancion (
	id_playlist INT UNSIGNED NOT NULL,
    id_cancion INT UNSIGNED NOT NULL,
    id_usuario INT UNSIGNED NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_playlist) REFERENCES playlist(id),
    FOREIGN KEY (id_cancion) REFERENCES cancion (id),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

-- Artistas favoritos de un usuario
CREATE TABLE siguiendo (
	id_usuario INT UNSIGNED NOT NULL,
    id_artista INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_artista) REFERENCES artista(id)
);


-- Canciones y albumes favoritos de un usuario
CREATE TABLE canciones_favoritas (
	id_usuario INT UNSIGNED NOT NULL,
    id_cancion INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_cancion) REFERENCES cancion(id)
);

CREATE TABLE albumes_favoritos (
	id_usuario INT UNSIGNED NOT NULL,
    id_album INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_album) REFERENCES album(id)
);

INSERT INTO usuario (tipo, email, password_hash, nombre_usuario, fecha_nacimiento, sexo, pais, codigo_postal)
VALUES ("free", "john123@gmail.com", 123456, "John Doe", "1990-01-01", "hombre", "España", "08001"),
		("premium", "jane123@gmail,com", "qwerty", "Jane Fonda", "1985-02-15", "mujer", "Francia", "75001");

INSERT INTO subscripcion (id_usuario, fecha_inicio, fecha_renovacion, forma_pago)
VALUES (2, "2024-05-10", "2024-06-10", "tarjeta de crédito");

INSERT INTO tarjeta_credito (id_usuario, numero, mes_caducidad, anyo_caducidad, codigo_seguridad)
VALUES (2, 4911123445678912, 11, 2027, 123);

INSERT INTO paypal (id_usuario, usuario_paypal)
VALUES (2, "jfondap");

INSERT INTO pago_subscripcion (id_usuario, id_subscripcion, fecha_pago, orden, total)
VALUES (2, 1, "2024-05-10",	"SUBS-2024-05-001", 9.99);

INSERT INTO playlist (titulo, id_usuario, numero_canciones, estado, fecha_creacion)
VALUES ("My Workout Hits", 2, 15, "activa", "2024-05-11"),
		("Rumbita", 1, 10, "activa", "2024-05-12");
        
INSERT INTO genero (nombre)
VALUES ("Pop"),
		("Rock"),
        ("Dance");
        
INSERT INTO artista (nombre, id_genero)
VALUES ("Michael Jackson", 1),
		("The Beatles", 2);

INSERT INTO album (id_artista, titulo, anyo)
VALUES (1, "Thriller", "1982"),
		(2, "Abbey Road", "1969");
        
INSERT INTO cancion (id_artista, id_album, titulo, duracion, reproducciones)
VALUES (1, 1, "Billie Jean", 298, 10000000),
		(2, 2, "Come Together", 478, 8500000);
        
INSERT INTO agregar_cancion (id_playlist, id_cancion, id_usuario, fecha)
VALUES (1, 1, 2, "2024-05-11");

INSERT INTO siguiendo (id_usuario, id_artista)
VALUES (2, 1);

INSERT INTO canciones_favoritas (id_usuario, id_cancion)
VALUES (1, 2);

INSERT INTO albumes_favoritos (id_usuario, id_album)
VALUES (2, 1);

