DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify CHARACTER SET utf8mb4;
USE spotify;

CREATE TABLE usuario (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM("free", "premium") NOT NULL,
    email VARCHAR(100) NOT NULL,
    nombre_usuario VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    sexo ENUM("mujer", "hombre", "no binario") NOT NULL,
    pais VARCHAR(30) NOT NULL,
    codigo_postal VARCHAR(20) NOT NULL
);

CREATE TABLE subscripcion (
	id INT UNSIGNED PRIMARY KEY,
	id_usuario INT UNSIGNED NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_renovacion DATE NOT NULL,
    forma_pago ENUM("tarjeta de crédito", "PayPal") NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

CREATE TABLE tarjeta_credito (
	id_usuario INT UNSIGNED NOT NULL,
	numero INT(16) UNSIGNED NOT NULL,
    mes INT NOT NULL,
    anyo INT NOT NULL,
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
    orden VARCHAR(20) NOT NULL UNIQUE,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_subscripcion) REFERENCES subscripcion(id)
);

CREATE TABLE playlist (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
	titulo VARCHAR(30) NOT NULL,
	id_usuario INT UNSIGNED NOT NULL,
    numero_canciones INT UNSIGNED NOT NULL,
    estado ENUM("activa", "eliminada"),
    fecha_creacion DATE NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);
