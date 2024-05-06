USE tienda;
/*1*/ SELECT nombre FROM producto;
/*2*/ SELECT nombre, precio FROM producto;
/*3*/ SELECT * FROM producto;
/*4*/ SELECT nombre, precio, precio * 1.07 AS precio_USD FROM producto;
/*5*/ SELECT nombre AS "nombre de producto",
			precio AS euros,
			precio * 1.07 AS "dólares estadounidenses"
			FROM producto;
/*6*/ SELECT UPPER(nombre) AS "NOMBRE MAYÚSUCLA",
			precio FROM producto;
/*7*/ SELECT LOWER(nombre) AS "Nombre minúscula",
			precio FROM producto;
/*8*/ SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) AS Iniciales
		FROM fabricante;
/*9*/ SELECT nombre, ROUND(precio) AS "precio redondeado" FROM producto;
/*10*/ SELECT nombre, TRUNCATE(precio, 0) AS "precio entero" FROM producto;
/*11*/ SELECT codigo_fabricante FROM producto;
/*12*/ SELECT DISTINCT codigo_fabricante FROM producto;
/*13*/ SELECT nombre FROM fabricante ORDER BY nombre ASC;
/*14*/ SELECT nombre FROM fabricante ORDER BY nombre DESC;
/*15*/ SELECT nombre, precio FROM producto
ORDER BY nombre ASC, precio DESC;
/*16*/ SELECT * FROM fabricante LIMIT 5;
/*17*/ SELECT * FROM fabricante LIMIT 2 OFFSET 3;
/*18*/ SELECT nombre, precio FROM producto
		ORDER BY precio ASC LIMIT 1;
/*19*/ SELECT nombre, precio FROM producto
		ORDER BY precio DESC LIMIT 1;
/*20*/ SELECT nombre, codigo_fabricante FROM producto
		WHERE codigo_fabricante = 2;
/*21*/ SELECT producto.nombre, producto.precio,
		fabricante.nombre FROM producto
		JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
/*22*/ SELECT producto.nombre, producto.precio, fabricante.nombre
			FROM producto
			JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
			ORDER BY fabricante.nombre ASC;
/*23*/ SELECT producto.codigo AS "Código producto", producto.nombre AS "Nombre producto",
		producto.codigo_fabricante, fabricante.nombre AS "Nombre fabricante"
		FROM producto
		JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
/*24*/ SELECT producto.nombre, producto.precio, fabricante.nombre
		FROM producto
		JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
		ORDER BY producto.precio ASC LIMIT 1;
/*25*/ SELECT producto.nombre, producto.precio, fabricante.nombre
			FROM producto
            JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
			ORDER BY producto.precio DESC LIMIT 1;
/*26*/ SELECT producto.nombre, fabricante.nombre FROM producto
		JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
		WHERE fabricante.nombre = "Lenovo";
/*27*/ SELECT producto.nombre, producto.precio, fabricante.nombre
	FROM producto
	JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
	WHERE fabricante.nombre = "Crucial" AND producto.precio > 200
	ORDER BY producto.precio;
/*28*/ SELECT producto.nombre AS nombre_producto,
	fabricante.nombre AS nombre_fabricante
	FROM producto
	JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
	WHERE fabricante.nombre = "Asus"
	OR fabricante.nombre = "Hewlett-Packard"
	OR fabricante.nombre = "Seagate";
/*29*/ SELECT producto.nombre AS nombre_producto,
	fabricante.nombre AS fabricante_nombre
	FROM producto
	JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
	WHERE fabricante.nombre IN ("Asus", "Hewlett-Packard", "Seagate");
/*30*/ SELECT producto.nombre AS nombre_producto,
	producto.precio AS precio_producto,
	fabricante.nombre AS nombre_fabricante
	FROM producto
	JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
	WHERE fabricante.nombre LIKE "%e";
/*31*/ SELECT producto.nombre AS nombre_producto,
	producto.precio AS precio_producto,
	fabricante.nombre AS fabricante_nombre
	FROM producto
	JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
	WHERE fabricante.nombre LIKE "%w%";
    /*32*/ SELECT producto.nombre AS nombre_producto,
		producto.precio AS precio_producto,
        fabricante.nombre AS nombre_fabricante
        FROM producto
        JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
        WHERE producto.precio >= 180
        ORDER BY producto.precio DESC;
	SELECT producto.nombre AS nombre_producto,
		producto.precio AS precio_producto,
        fabricante.nombre AS nombre_fabricante
        FROM producto
        JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
        WHERE producto.precio >= 180
        ORDER BY producto.nombre ASC;
/*33*/ SELECT DISTINCT fabricante.codigo, fabricante.nombre
	FROM fabricante
    JOIN producto ON fabricante.codigo = producto.codigo_fabricante;
/*34*/ SELECT fabricante.nombre, producto.nombre AS producto_nombre
	FROM fabricante
    LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
    UNION ALL
    SELECT fabricante.nombre, NULL AS producto_nombre
    FROM fabricante
    JOIN producto ON fabricante.codigo = producto.codigo_fabricante
    WHERE producto.nombre IS NULL;
    /*35*/ SELECT fabricante.nombre FROM fabricante
    LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
    WHERE producto.nombre IS NULL;
    /*36 Subquery*/ SELECT producto.nombre FROM producto
    WHERE producto.codigo_fabricante IN (
		SELECT fabricante.codigo
        FROM fabricante
        WHERE fabricante.nombre LIKE "Lenovo"
        );
	/*37*/ WITH producto_mas_caro_Lenovo AS (
		SELECT MAX(precio) AS max_precio
		FROM producto
		WHERE producto.codigo_fabricante IN (
		SELECT fabricante.codigo
		FROM fabricante
		WHERE nombre LIKE "Lenovo"
		)
    )
    SELECT producto.nombre, producto.precio
    FROM producto
    WHERE producto.precio = (
    SELECT max_precio
    FROM producto_mas_caro_Lenovo
    );
    /*38*/ SELECT producto.nombre, producto.precio
    FROM producto
    WHERE producto.codigo_fabricante IN (
    SELECT fabricante.codigo
    FROM fabricante
    WHERE fabricante.nombre = "Lenovo"
    )
    ORDER BY producto.precio DESC LIMIT 1;
    /*39*/ SELECT producto.nombre, producto.precio
    FROM producto
    WHERE producto.codigo_fabricante in (
    SELECT fabricante.codigo
    FROM fabricante
    WHERE fabricante.nombre LIKE "Hewlett-Packard"
    )
    ORDER BY producto.precio ASC LIMIT 1;
    /*40*/ WITH producto_mas_caro_Lenovo AS (
		SELECT MAX(producto.precio) AS precio_max
		FROM producto
		JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
		WHERE fabricante.nombre LIKE "Lenovo"
        )
    SELECT producto.nombre, producto.precio
    FROM producto
    JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
    WHERE producto.precio >= (SELECT precio_max FROM producto_mas_caro_Lenovo);
    /*41*/ WITH precio_medio_Asus AS (
    SELECT AVG(producto.precio) AS promedio_precios
    FROM producto
    JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
    )
    SELECT producto.nombre, producto.precio
    FROM producto
    JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
    WHERE producto.precio > (SELECT promedio_precios FROM precio_medio_Asus);
    
    
	
