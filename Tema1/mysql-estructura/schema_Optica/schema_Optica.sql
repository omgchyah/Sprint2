DROP DATABASE IF EXISTS cull_dampolla;
CREATE DATABASE cull_dampolla CHARACTER SET utf8mb4;
USE cull_dampolla;

CREATE TABLE proveedor (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(60) NOT NULL,
    calle_nombre VARCHAR(20) NOT NULL,
    calle_numero VARCHAR(20) NOT NULL,
    piso INT NULL,
    puerta INT NULL,
    ciudad VARCHAR(30) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    pais VARCHAR(20) NOT NULL,
    telefono_prefijo INT(4) NOT NULL,
    telefono INT(9) NOT NULL,
    fax INT(9) NULL,
    NIF VARCHAR(9) NOT NULL
);

CREATE TABLE cliente (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    codigo_postal VARCHAR(10) NULL,
    telefono INT(9) NOT NULL,
    correo_electronico VARCHAR(40) NOT NULL,
    registro_fecha DATE NOT NULL,
    id_cliente_recomendacion INT UNSIGNED NULL,
    FOREIGN KEY (id_cliente_recomendacion) REFERENCES cliente(id),
    INDEX (id)
    );
    
CREATE TABLE empleado (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL
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
    fecha_venta DATE NOT NULL,
	id_empleado INT UNSIGNED NOT NULL,
    id_proveedor INT UNSIGNED NOT NULL,
    id_cliente INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    INDEX (id),
    CONSTRAINT unico_proveedor_marca UNIQUE (marca, id_proveedor)
);


/*DATOS PARA COMPROBAR*/

INSERT INTO proveedor (nombre, calle_nombre, calle_numero, piso, ciudad, codigo_postal, pais, telefono_prefijo, telefono, fax, NIF)
VALUES
    ('Ojitos Bonitos', 'Carrer Boronat', '4', 1, 'Barcelona', '08018', 'España', 0034, 123456789, NULL, 'ABC123456'),
    ("Ojoloco", 'Carrer Olzinelles', '35', 2, 'Barcelona', '08014', 'España', 0034, 987654321, NULL, 'DEF987654');
    
INSERT INTO empleado (nombre_completo, fecha_inicio)
VALUES
	('María Pérez', '2020-04-18'),
    ('Pol Casses', '2019-05-15');

INSERT INTO cliente (nombre, codigo_postal, telefono, correo_electronico, registro_fecha, id_cliente_recomendacion)
VALUES
    ('Rossana Liendo', '08950', 610433756, 'rossi@correo.com', '2023-05-01', NULL);
    
INSERT INTO cliente (nombre, codigo_postal, telefono, correo_electronico, registro_fecha, id_cliente_recomendacion)
VALUES
    ('Pedro Guerrero', '08038', 345879635, 'pedriños@correo.com', '2023-12-02', 1),
    ('Veronica Camacho', '08050', 614587986, 'verocute@correo.com', '2024-01-20', 1),
    ('Vanessa Bermudez', '08450', 689745126, 'vanevanei@correo.com', '2024-05-01', 2);

INSERT INTO gafas (marca, grad_ojo_derecho, grad_ojo_izquierdo, montura_tipo, montura_color, vidrio_color, precio, fecha_venta, id_empleado, id_proveedor, id_cliente)
VALUES
    ('Gucci', 1.25, 1.50, 'flotante', 'Negro', 'Azul', 299.99, '2023-05-01', 1, 1, 1),
    ('Chanel', 2.00, 2.25, 'pasta', 'Marrón', 'Verde', 450.60, '2023-12-02', 1, 2, 2),
	('Carolina Herrera', 1.80, 2.00, 'metálica', 'Rojo', 'Verde', 350.70, '2024-01-20', 1, 1, 3),
    ('Oakley', 4.00, 4.75, 'pasta', 'Negro', 'Amarillo', 280.40, '2024-05-02', 2, 2, 4);