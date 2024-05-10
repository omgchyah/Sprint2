DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

-- Tabla para la tienda
CREATE TABLE tienda (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(60) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    localidad VARCHAR(20) NOT NULL,
    provincia VARCHAR(20) NOT NULL
    );
    
-- Tabla para empleados
CREATE TABLE empleado (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('cocinero', 'repartidor'),
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    nif VARCHAR(9) NOT NULL,
    telefono INT(9) NOT NULL,
    id_tienda INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_tienda) REFERENCES tienda(id)
);

-- Tabla para pedidos, un cliente puede tener varios pedidos
CREATE TABLE pedido (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha_hora_entrega DATETIME NOT NULL,
    tipo_entrega ENUM('A domicilio', 'Recogida en tienda') NOT NULL,
	id_repartidor INT UNSIGNED NULL,
    cantidad_hamburguesa INT NULL,
    cantidad_bebida INT NULL,
    cantidad_pizza INT NULL,
	precio_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_repartidor) REFERENCES empleado(id)
    -- CONSTRAINT chk_repartidor_required CHECK (tipo_entrega = 'A domicilio' AND id_repartidor IS NOT NULL)
);

-- Tabla para tipos de pizza
CREATE TABLE pizza (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(60),
    descripcio VARCHAR(100),
    fecha_cambio DATE
);

-- Tabla para productos (hamburguesa, pizza, bebida)
CREATE TABLE tipo_producto (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('pizza', 'hamburguesa', 'bebida') NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    imagen BLOB NOT NULL,
    precio INT NOT NULL,
    id_pizza INT UNSIGNED NULL,
    FOREIGN KEY (id_pizza) REFERENCES pizza(id)
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
    id_pedido INT UNSIGNED,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id)
);

/*-- Tabla para definir que producto y cantidad por cada pedido (eliminado para simplificar)
CREATE TABLE pedido_lista_productos (
    id_pedido INT UNSIGNED,
    id_tipo_producto INT UNSIGNED,
    cantidad INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_pedido, id_tipo_producto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id),
    FOREIGN KEY (id_tipo_producto) REFERENCES tipo_producto(id)
);*/


INSERT INTO tienda (direccion, codigo_postal, localidad, provincia) 
VALUES 
    ('Calle Mayor, 1', '28001', 'Madrid', 'Madrid'),
    ('Calle Gran Vía, 25', '08001', 'Barcelona', 'Barcelona'),
    ('Calle Real, 15', '41001', 'Sevilla', 'Sevilla');

INSERT INTO empleado (tipo, nombre, apellidos, nif, telefono, id_tienda)
VALUES 
    ('cocinero', 'Juan', 'García', '12345678A', 666555444, 1),
    ('repartidor', 'Pedro', 'Martínez', '87654321B', 677888999, 2),
    ('repartidor', 'Ana', 'López', '11223344C', 688777999, 3);

INSERT INTO pedido (fecha_hora_entrega, tipo_entrega, id_repartidor, cantidad_pizza, cantidad_hamburguesa, cantidad_bebida, precio_total)
VALUES 
    ('2024-05-01 12:00:00', 'A domicilio', 2, 2, 2, 0, 55.50),
    ('2024-05-02 13:30:00', 'Recogida en tienda', NULL, 0, 3, 2,  34.75),
    ('2024-05-03 19:00:00', 'Recogida en tienda', NULL, 1, 2, 1,  35.50),
    ('2024-05-04 20:30:00', 'A domicilio', 3, 4, 0, 3, 54.00);

-- Inserting values into the cliente table
INSERT INTO cliente (nombre, apellidos, direccion, codigo_postal, localidad, provincia, telefono, id_pedido)
VALUES 
    ('María', 'Sánchez', 'Calle Sol, 5', '28002', 'Madrid', 'Madrid', 666777888, 1),
    ('David', 'González', 'Carrer Sants, 10', '08002', 'Barcelona', 'Barcelona', 677888999, 2),
    ('Laura', 'Fernández', 'Av. República Argentina, 20', '41002', 'Sevilla', 'Sevilla', 688999000, 3),
	('Anabel', 'Lee', "Calle l'Anoia, 5", '08038', 'Barcelona', 'Barcelona', 666555444, 4);
    
-- Inserting values into the pizza table
INSERT INTO pizza (categoria, descripcio, fecha_cambio)
VALUES 
    ('primavera', 'Pizza de primavera con ingredientes frescos', '2024-03-21'),
    ('vegetariana', 'Pizza vegetariana con verduras de temporada', '2024-06-21'),
    ('mar y tierra', 'Pizza que combina mariscos y carnes', '2024-06-21'),
    ('cuatro quesos', 'Pizza con una mezcla de cuatro quesos', '2024-06-21');
   
   -- Crear stock de productos
INSERT INTO tipo_producto (tipo, descripcion, precio, id_pizza)
VALUES 
    ('pizza', 'Pizza de temporada', 12.00, 1),
    ('hamburguesa', 'Hamburguesa BBQ con bacon y salsa barbacoa', 10.25, NULL),
    ('bebida', 'Refresco de cola', 2.00, NULL);

/*-- Eliminado para simplificar
INSERT INTO pedido_lista_productos (id_pedido, id_tipo_producto, cantidad)
VALUES 
    (1, 1, 2), -- Dos pizzas pedido 1
    (1, 4, 1), -- Un refresco pedido 1
    (2, 2, 2), -- Dos hamburguesas BBQ pedido 2
    (2, 6, 2), -- Dos cervezas pedido 2
    (3, 1, 1), -- Una pizza pedido 3
    (3, 3, 2), -- Dos hamburguesas veggie pedido 3
    (4, 2, 4), -- Cuatro hamburguesas BBQ pedido 4
    (4, 5, 4); -- Cuatro aguas pedido 4*/