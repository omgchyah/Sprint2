USE cull_dampolla;

/*1 Llista el total de compres d’un client/a.*/
SELECT cliente.nombre, COUNT(DISTINCT gafas.id) AS numero_compras FROM cliente LEFT JOIN gafas ON cliente.id = gafas.id_cliente GROUP BY cliente.nombre;

/*2 Llista les diferents ulleres que ha venut un empleat durant un any*/
SELECT empleado.nombre_completo AS nombre_empleado, gafas.id AS id_gafas, YEAR(gafas.fecha_venta) AS anyo_venta FROM gafas LEFT JOIN empleado ON gafas.id_empleado = empleado.id WHERE YEAR(gafas.fecha_venta) = 2024;

/*3 Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.*/
SELECT proveedor.nombre AS nombre_proveedor, COUNT(DISTINCT gafas.id) AS gafas_vendidas FROM proveedor JOIN gafas ON proveedor.id = gafas.id_proveedor GROUP BY nombre_proveedor;