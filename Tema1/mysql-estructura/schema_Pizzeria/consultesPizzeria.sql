USE pizzeria;

-- CONSULTA 1
SELECT COUNT(producto.id) AS cantidad_bebidas,
cliente.localidad AS localidad_tienda
FROM producto
JOIN pedido ON producto.id_pedido = pedido.id
JOIN cliente ON pedido.id_cliente = cliente.id
WHERE producto.tipo LIKE "bebida"
AND cliente.localidad LIKE "Barcelona"
GROUP BY producto.tipo;

-- CONSULTA 2
SELECT COUNT(pedido.id) AS cantidad_pedidos,
empleado.nombre
FROM pedido
RIGHT JOIN empleado ON pedido.id_repartidor = empleado.id
WHERE empleado.tipo LIKE "repartidor"
AND empleado.nombre LIKE "Pedro";