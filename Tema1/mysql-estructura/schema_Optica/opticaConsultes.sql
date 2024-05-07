USE cull_dampolla;

/*1*/
SELECT cliente.nombre,
COUNT(DISTINCT gafas.id) AS numero_compras
FROM cliente
LEFT JOIN gafas ON cliente.id = gafas.cliente_id
GROUP BY cliente.nombre;

/*2*/
SELECT gafas.vendido_por AS nombre_empleado,
gafas.id AS id_gafas,
YEAR(gafas.fecha_venta) AS anyo_venta
FROM gafas
WHERE YEAR(gafas.fecha_venta) = 2024
AND gafas.vendido_por LIKE "José";

/*3*/
SELECT proveedor.nombre AS nombre_proveedor,
COUNT(DISTINCT gafas.id) AS gafas_vendidas
FROM proveedor
LEFT JOIN gafas ON proveedor.id = gafas.proveedor_id
GROUP BY nombre_proveedor;