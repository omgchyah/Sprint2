USE pizzeria;

-- CONSULTA 1
-- Llista quants productes de tipus “Begudes” s'han venut en una determinada localitat.
SELECT 
COUNT(producto.id) AS cantidad_bebidas,
cliente.localidad AS localidad_tienda
FROM producto
JOIN pedido_producto ON producto.id = pedido_producto.id_producto
JOIN pedido ON pedido_producto.id_pedido = pedido.id
JOIN cliente ON pedido.id_cliente = cliente.id
WHERE producto.tipo = 'bebida'
AND cliente.localidad = 'Barcelona'
GROUP BY cliente.localidad;

-- CONSULTA 2
-- Llista quantes comandes ha efectuat un determinat empleat/da.
SELECT COUNT(pedido.id) AS cantidad_pedidos, empleado.nombre
FROM pedido
JOIN empleado ON pedido.id_repartidor = empleado.id
WHERE empleado.tipo = 'repartidor'
AND empleado.nombre = 'Pedro'
GROUP BY empleado.nombre;