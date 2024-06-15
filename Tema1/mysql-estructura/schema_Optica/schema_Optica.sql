DROP DATABASE IF EXISTS cull_dampolla;
CREATE DATABASE cull_dampolla CHARACTER SET utf8mb4;
USE cull_dampolla;

CREATE TABLE proveedor (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    calle_nombre VARCHAR(20) NOT NULL,
    calle_numero VARCHAR(20) NOT NULL,
    piso VARCHAR(5),
    puerta VARCHAR(5),
    ciudad VARCHAR(30) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    pais VARCHAR(20) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    fax VARCHAR(15),
    NIF CHAR(9) NOT NULL,
    UNIQUE (NIF)
);

CREATE TABLE cliente (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    codigo_postal VARCHAR(10),
    telefono VARCHAR(15) NOT NULL,
    correo_electronico VARCHAR(40) NOT NULL,
    registro_fecha DATE NOT NULL,
    id_cliente_recomendacion INT UNSIGNED,
    FOREIGN KEY (id_cliente_recomendacion) REFERENCES cliente(id),
    INDEX (id_cliente_recomendacion)
);

CREATE TABLE empleado (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL
);

CREATE TABLE marcas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    UNIQUE (nombre)
);

CREATE TABLE proveedor_marcas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    proveedor_id INT UNSIGNED NOT NULL,
    marca_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (proveedor_id) REFERENCES proveedor(id),
    FOREIGN KEY (marca_id) REFERENCES marcas(id),
    UNIQUE (marca_id)
);

CREATE TABLE gafas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    proveedor_marca_id INT UNSIGNED NOT NULL,
    grad_ojo_derecho FLOAT NOT NULL,
    grad_ojo_izquierdo FLOAT NOT NULL,
    montura_tipo ENUM('flotante', 'pasta', 'metálica') NOT NULL,
    montura_color VARCHAR(20) NOT NULL,
    vidrio_color VARCHAR(20) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (proveedor_marca_id) REFERENCES proveedor_marcas(id)
);

CREATE TABLE ventas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT UNSIGNED NOT NULL,
    id_gafas INT UNSIGNED NOT NULL,
    id_empleado INT UNSIGNED NOT NULL,
    fecha_venta DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    FOREIGN KEY (id_gafas) REFERENCES gafas(id),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id),
    INDEX (id_cliente),
    INDEX (id_gafas),
    INDEX (id_empleado)
);

/*DATOS PARA COMPROBAR*/

INSERT INTO proveedor (nombre, calle_nombre, calle_numero, piso, puerta, ciudad, codigo_postal, pais, telefono, fax, NIF)
VALUES
    ('Ojitos Bonitos', 'Carrer Boronat', '4', '1', NULL, 'Barcelona', '08018', 'España', '0034123456789', NULL, 'ABC123456'),
    ('Ojoloco', 'Carrer Olzinelles', '35', '2', NULL, 'Barcelona', '08014', 'España', '0034987654321', NULL, 'DEF987654');

INSERT INTO empleado (nombre_completo, fecha_inicio)
VALUES
    ('María Pérez', '2020-04-18'),
    ('Pol Casses', '2019-05-15');

INSERT INTO cliente (nombre, codigo_postal, telefono, correo_electronico, registro_fecha, id_cliente_recomendacion)
VALUES
    ('Rossana Liendo', '08950', '610433756', 'rossi@correo.com', '2023-05-01', NULL),
    ('Pedro Guerrero', '08038', '345879635', 'pedriños@correo.com', '2023-12-02', 1),
    ('Veronica Camacho', '08050', '614587986', 'verocute@correo.com', '2024-01-20', 1),
    ('Vanessa Bermudez', '08450', '689745126', 'vanevanei@correo.com', '2024-05-01', 2);

INSERT INTO marcas (nombre) VALUES ('Gucci'), ('Chanel'), ('Carolina Herrera'), ('Oakley');

INSERT INTO proveedor_marcas (proveedor_id, marca_id)
VALUES
    (1, 1),  -- Ojitos Bonitos sells Gucci
    (2, 2),  -- Ojoloco sells Chanel
    (1, 3),  -- Ojitos Bonitos sells Carolina Herrera
    (2, 4);  -- Ojoloco sells Oakley

INSERT INTO gafas (proveedor_marca_id, grad_ojo_derecho, grad_ojo_izquierdo, montura_tipo, montura_color, vidrio_color, precio)
VALUES
    (1, 1.25, 1.50, 'flotante', 'Negro', 'Azul', 299.99),  -- Gucci by Ojitos Bonitos
    (2, 2.00, 2.25, 'pasta', 'Marrón', 'Verde', 450.60),   -- Chanel by Ojoloco
    (3, 1.80, 2.00, 'metálica', 'Rojo', 'Verde', 350.70),  -- Carolina Herrera by Ojitos Bonitos
    (4, 4.00, 4.75, 'pasta', 'Negro', 'Amarillo', 280.40); -- Oakley by Ojoloco

INSERT INTO ventas (id_cliente, id_gafas, id_empleado, fecha_venta)
VALUES
    (1, 1, 1, '2023-05-01'),
    (2, 2, 1, '2023-12-02'),
    (3, 3, 1, '2024-01-20'),
    (4, 4, 2, '2024-05-02');
    
-- Da error
INSERT INTO proveedor_marcas (proveedor_id, marca_id)
VALUES
    (2, 1);