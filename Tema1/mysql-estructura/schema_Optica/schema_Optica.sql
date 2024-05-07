DROP DATABASE IF EXISTS cull_dampolla;
CREATE DATABASE cull_dampolla CHARACTER SET utf8mb4;
USE cull_dampolla;

CREATE TABLE proveedor (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(60) NOT NULL,
    calle_nombre VARCHAR(20) NOT NULL,
    calle_numero VARCHAR(20) NOT NULL,
    piso INT(100) NOT NULL,
    puerta INT(20) NULL,
    ciudad VARCHAR(30),
    codigo_postal VARCHAR(10),
    pais VARCHAR(20),
    telefono_prefijo INT(4) NOT NULL,
    telefono INT(9) NOT NULL,
    fax INT(9) NULL,
    NIF VARCHAR(9) NOT NULL,
    INDEX (id)
);

CREATE TABLE cliente (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    codigo_postal VARCHAR(10) NULL,
    telefono INT(9) NOT NULL,
    correo_electronico VARCHAR(40) NOT NULL,
    registro_fecha DATE NOT NULL,
    recomendacion_id_cliente INT UNSIGNED NULL,
    FOREIGN KEY (recomendacion_id_cliente) REFERENCES cliente(id),
    INDEX (id)
    );
    
CREATE TABLE gafas (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	marca VARCHAR(30) NOT NULL,
    grad_ojo_derecho FLOAT NOT NULL,
    grad_ojo_izquierdo FLOAT NOT NULL,
    montura_tipo ENUM("flotante", "pasta", "metálica") NOT NULL,
    montura_color VARCHAR(20) NOT NULL,
    vidrio_color VARCHAR(20) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
	vendido_por VARCHAR(30) NOT NULL,
    fecha_venta DATE NOT NULL,
    proveedor_id INT UNSIGNED NOT NULL,
    cliente_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (proveedor_id) REFERENCES proveedor(id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(id),
    INDEX (id)
);

/*DATOS PARA COMPROBAR*/

INSERT INTO proveedor (nombre, calle_nombre, calle_numero, piso, ciudad, codigo_postal, pais, telefono_prefijo, telefono, fax, NIF)
VALUES
    ('Ojitos Bonitos', 'Carrer Boronat', '4', 1, 'Barcelona', '08018', 'España', 0034, 123456789, NULL, 'ABC123456'),
    ("Ojoloco", 'Carrer Olzinelles', '35', 2, 'Barcelona', '08014', 'España', 0034, 987654321, NULL, 'DEF987654');

INSERT INTO cliente (nombre, codigo_postal, telefono, correo_electronico, registro_fecha, recomendacion_id_cliente)
VALUES
    ('Rossana Liendo', '08950', 610433756, 'rossi@correo.com', '2023-05-01', NULL);
    
    INSERT INTO cliente (nombre, codigo_postal, telefono, correo_electronico, registro_fecha, recomendacion_id_cliente)
	VALUES
    ('Pedro Guerrero', '08038', 345879635, 'pedriños@correo.com', '2023-12-02', 1),
    ('Veronica Camacho', '08050', 614587986, 'verocute@correo.com', '2024-01-20', 1),
    ('Vanessa Bermudez', '08450', 689745126, 'vanevanei@correo.com', '2024-05-01', 2);

INSERT INTO gafas (marca, grad_ojo_derecho, grad_ojo_izquierdo, montura_tipo, montura_color, vidrio_color, precio, vendido_por, fecha_venta, proveedor_id, cliente_id)
VALUES
    ('Gucci', 1.25, 1.50, 'flotante', 'Negro', 'Azul', 299.99, 'María', '2023-05-01', 1, 1),
    ('Chanel', 2.00, 2.25, 'pasta', 'Marrón', 'Verde', 450.60, 'José', '2023-12-02', 2, 2),
	('Carolina Herrera', 1.80, 2.00, 'metálica', 'Rojo', 'Verde', 350.70, 'José', '2024-01-20', 1, 3),
    ('Oakley', 4.00, 4.75, 'pasta', 'Negro', 'Amarillo', 280.40, 'José', '2024-05-02', 2, 4);