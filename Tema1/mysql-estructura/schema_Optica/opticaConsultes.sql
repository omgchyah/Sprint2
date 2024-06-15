USE cull_dampolla;

/*1 Llista el total de compres d’un client/a.*/
SELECT cliente.nombre, COUNT(DISTINCT id_gafas) AS numero_compras FROM cliente LEFT JOIN ventas ON cliente.id = ventas.id_gafas GROUP BY cliente.nombre;

/*2 Llista les diferents ulleres que ha venut un empleat durant un any*/
SELECT empleado.nombre_completo AS nombre_empleado, ventas.id_gafas AS id_gafas, YEAR(ventas.fecha_venta) AS anyo_venta FROM ventas LEFT JOIN empleado ON ventas.id_empleado = empleado.id WHERE YEAR(ventas.fecha_venta) = 2024;

/*3 Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.*/
SELECT proveedor.nombre AS nombre_proveedor, COUNT(DISTINCT gafas.id) AS gafas_vendidas FROM proveedor JOIN proveedor_marcas ON proveedor.id = proveedor_marcas.proveedor_id JOIN gafas ON proveedor_marcas.id = gafas.proveedor_marca_id JOIN ventas ON gafas.id = ventas.id_gafas GROUP BY nombre_proveedor;