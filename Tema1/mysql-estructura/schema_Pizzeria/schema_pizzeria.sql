DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria;
USE pizerria;

CREATE TABLE tienda (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(60) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    localidad VARCHAR(20) NOT NULL,
    provincia VARCHAR(20) NOT NULL
    );
    
CREATE TABLE empleado (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    nif VARCHAR(9) NOT NULL,
    telefono INT(9) NOT NULL,
    id_tienda INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_tienda) REFERENCES tienda(id)
);

CREATE TABLE cliente (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    direccion VARCHAR(60) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    localidad VARCHAR(60) NOT NULL,
    provincia VARCHAR(20) NOT NULL,
    telefono INT(9) NOT NULL,
    id_pedido INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id)
);

CREATE TABLE pedido (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha_hora_entrega DATETIME NOT NULL,
    tipo_entrega ENUM('A domicilio', 'Recogida en tienda') NOT NULL,
    
	precio_total INT NOT NULL
);

CREATE TABLE producto (
	id UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    imagen 
);