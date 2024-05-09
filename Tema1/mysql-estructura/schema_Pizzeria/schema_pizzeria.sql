DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria;
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
	precio_total DECIMAL(10, 2) NOT NULL,
	id_repartidor INT UNSIGNED,
    FOREIGN KEY (id_repartidor) REFERENCES empleado(id),
    CONSTRAINT chk_repartidor_required CHECK (tipo_entrega = 'A domicilio' AND id_repartidor IS NOT NULL)
);

-- Tabla para tipos de pizza
CREATE TABLE pizza (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    categoria ENUM('primavera', 'vegetariana', 'mar y tierra', 'cuatro quesos'),
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
    id_pizza INT UNSIGNED,
    FOREIGN KEY (id_pizza) REFERENCES pizza(id),
    CONSTRAINT chk_tipo_pizza CHECK (tipo = 'pizza' AND id_pizza IS NOT NULL)
);

-- Tabla para definir que producto y cantidad por cada pedido
CREATE TABLE pedido_lista_productos (
    id_pedido INT UNSIGNED,
    id_tipo_producto INT UNSIGNED,
    cantidad INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_pedido, id_tipo_producto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id),
    FOREIGN KEY (id_tipo_producto) REFERENCES tipo_producto(id)
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


INSERT INTO pedido (fecha_hora_entrega, tipo_entrega, precio_total, id_repartidor)
VALUES 
    ('2024-05-01 12:00:00', 'A domicilio', 25.50, 2),
    ('2024-05-02 13:30:00', 'Recogida en tienda', 18.75, NULL),
    ('2024-05-03 19:00:00', 'A domicilio', 30.00, 3);

-- Inserting values into the cliente table
INSERT INTO cliente (nombre, apellidos, direccion, codigo_postal, localidad, provincia, telefono, id_pedido)
VALUES 
    ('María', 'Sánchez', 'Calle Sol, 5', '28002', 'Madrid', 'Madrid', 666777888, 1),
    ('David', 'González', 'Carrer Sants, 10', '08002', 'Barcelona', 'Barcelona', 677888999, 2),
    ('Laura', 'Fernández', 'Av. República Argentina, 20', '41002', 'Sevilla', 'Sevilla', 688999000, 3);

-- Inserting values into the pizza table
INSERT INTO pizza (categoria, descripcio, fecha_cambio)
VALUES 
    ('primavera', 'Pizza de primavera con ingredientes frescos', '2024-03-21'),
    ('vegetariana', 'Pizza vegetariana con verduras de temporada', '2024-06-21'),
    ('mar y tierra', 'Pizza que combina mariscos y carnes', '2024-06-21'),
    ('cuatro quesos', 'Pizza con una mezcla de cuatro quesos', '2024-06-21');

INSERT INTO tipo_producto (tipo, descripcion, precio, id_pizza)
VALUES 
    ('pizza', 'Pizza Margarita', 10.50, 1),
    ('pizza', 'Pizza Vegetariana', 12.00, 2),
    ('pizza', 'Pizza Barbacoa', 13.75, 3),
    ('pizza', 'Pizza Cuatro Quesos', 11.25, 4),
    ('hamburguesa', 'Hamburguesa clásica con queso', 8.50, NULL),
    ('hamburguesa', 'Hamburguesa vegetariana de lentejas', 9.00, NULL),
    ('hamburguesa', 'Hamburguesa BBQ con bacon y salsa barbacoa', 10.25, NULL),
    ('hamburguesa', 'Hamburguesa de pollo con guacamole', 9.75, NULL),
    ('bebida', 'Refresco de cola', 2.00, NULL),
    ('bebida', 'Agua mineral', 1.50, NULL),
    ('bebida', 'Zumo de naranja natural', 2.50, NULL),
    ('bebida', 'Cerveza artesanal', 3.00, NULL);

-- Inserting values into the pedido_lista_productos table
INSERT INTO pedido_lista_productos (id_pedido, id_producto, cantidad)
VALUES 
    (1, 1, 2), -- Dos pizzas Margarita en un pedido
    (2, 2, 1), -- Una pizza Vegetariana en otro pedido
    (3, 3, 1), -- Una pizza Barbacoa en otro pedido
    (3, 4, 2); -- Dos pizzas Cuatro Quesos en otro pedido