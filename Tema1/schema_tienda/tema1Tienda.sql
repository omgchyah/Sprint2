USE tienda;
SELECT nombre FROM producto;
SELECT nombre, precio FROM producto;
SELECT * FROM producto;
SELECT nombre, precio, precio * 1.07 AS precio_USD FROM producto;
SELECT nombre AS "nombre de producto",
precio AS euros,
precio * 1.07 AS "dólares estadounidenses"
FROM producto;
SELECT UPPER(nombre) AS "NOMBRE MAYÚSUCLA",
precio FROM producto;
SELECT LOWER(nombre) AS "Nombre minúscula",
precio FROM producto;
SELECT * FROM fabricante;
SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) AS Iniciales
FROM fabricante;
SELECT nombre, ROUND(precio) AS "precio redondeado" FROM producto;
SELECT nombre, TRUNCATE(precio, 0) AS "precio entero" FROM producto;
SELECT DISTINCT codigo_fabricante FROM producto;
SELECT nombre FROM fabricante ORDER BY nombre ASC;
SELECT nombre FROM fabricante ORDER BY nombre DESC;
SELECT nombre, precio FROM producto ORDER BY nombre ASC;
SELECT nombre, precio FROM producto ORDER BY precio DESC;
SELECT * FROM fabricante LIMIT 5;
SELECT * FROM fabricante LIMIT 2 OFFSET 3;
SELECT nombre, precio FROM producto
ORDER BY precio ASC LIMIT 1;
SELECT nombre, precio FROM producto
ORDER BY precio DESC LIMIT 1;
SELECT nombre, codigo_fabricante FROM producto
WHERE codigo_fabricante = 2;
SELECT producto.nombre, producto.precio,
fabricante.nombre FROM producto AS producto
JOIN fabricante AS fabricante
ON producto.codigo_fabricante = fabricante.codigo;
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
AS producto JOIN fabricante
AS fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY fabricante.nombre ASC;
SELECT producto.codigo AS "Código producto", producto.nombre AS "Nombre producto",
producto.codigo_fabricante, fabricante.nombre AS "Nombre fabricante"
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY producto.precio ASC LIMIT 1;
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY producto.precio DESC LIMIT 1;
SELECT producto.nombre, fabricante.nombre FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = "Lenovo";
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = "Crucial" AND producto.precio >= 200
ORDER BY producto.precio;
SELECT producto.nombre AS nombre_producto,
fabricante.nombre AS nombre_fabricante
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = "Asus"
OR fabricante.nombre = "Hewlett-Packard"
OR fabricante.nombre = "Seagate";
SELECT producto.nombre AS nombre_producto,
fabricante.nombre AS fabricante_nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ("Asus", "Hewlett-Packard", "Seagate");
SELECT producto.nombre AS nombre_producto,
producto.precio AS precio_producto,
fabricante.nombre AS nombre_fabricante
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE "%e";
SELECT producto.nombre AS nombre_producto,
producto.precio AS precio_producto
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE 
