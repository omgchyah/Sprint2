-- Queries for Schema Tienda and Schema Universidad

USE tienda;
/*1*/ SELECT nombre FROM producto;
/*2*/ SELECT nombre, precio FROM producto;
/*3*/ SELECT * FROM producto;
/*4*/ SELECT nombre, precio, precio * 1.07 AS precio_USD FROM producto;
/*5*/ SELECT nombre AS "nombre de producto", precio AS euros, precio * 1.07 AS "dólares estadounidenses" FROM producto;
/*6*/ SELECT UPPER(nombre) AS "NOMBRE MAYÚSUCLA", precio FROM producto;
/*7*/ SELECT LOWER(nombre) AS "Nombre minúscula", precio FROM producto;
/*8*/ SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) AS Iniciales FROM fabricante;
/*9*/ SELECT nombre, ROUND(precio) AS "precio redondeado" FROM producto;
/*10*/ SELECT nombre, TRUNCATE(precio, 0) AS "precio entero" FROM producto;
/*11*/ SELECT codigo_fabricante FROM producto;
/*12*/ SELECT DISTINCT codigo_fabricante FROM producto;
/*13*/ SELECT nombre FROM fabricante ORDER BY nombre ASC;
/*14*/ SELECT nombre FROM fabricante ORDER BY nombre DESC;
/*15*/ SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
/*16*/ SELECT * FROM fabricante LIMIT 5;
/*17*/ SELECT * FROM fabricante LIMIT 2 OFFSET 3;
/*18*/ SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
/*19*/ SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
/*20*/ SELECT nombre, codigo_fabricante FROM producto WHERE codigo_fabricante = 2;
/*21*/ SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
/*22*/ SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY fabricante.nombre ASC;
/*23*/ SELECT producto.codigo AS "Código producto", producto.nombre AS "Nombre producto", producto.codigo_fabricante, fabricante.nombre AS "Nombre fabricante" FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
/*24*/ SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY producto.precio ASC LIMIT 1;
/*25*/ SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY producto.precio DESC LIMIT 1;
/*26*/ SELECT producto.nombre, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = "Lenovo";
/*27*/ SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = "Crucial" AND producto.precio > 200 ORDER BY producto.precio;
/*28*/ SELECT producto.nombre AS nombre_producto, fabricante.nombre AS nombre_fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = "Asus" OR fabricante.nombre = "Hewlett-Packard" OR fabricante.nombre = "Seagate";
/*29*/ SELECT producto.nombre AS nombre_producto, fabricante.nombre AS fabricante_nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre IN ("Asus", "Hewlett-Packard", "Seagate");
/*30*/ SELECT producto.nombre AS nombre_producto, producto.precio AS precio_producto, fabricante.nombre AS nombre_fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "%e";
/*31*/ SELECT producto.nombre AS nombre_producto, producto.precio AS precio_producto, fabricante.nombre AS fabricante_nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "%w%";
/*32*/ SELECT producto.nombre AS nombre_producto, producto.precio AS precio_producto, fabricante.nombre AS nombre_fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= 180 ORDER BY producto.precio DESC, producto.nombre ASC;
/*33*/ SELECT DISTINCT fabricante.codigo, fabricante.nombre FROM fabricante JOIN producto ON fabricante.codigo = producto.codigo_fabricante;
/*34*/ SELECT fabricante.nombre, producto.nombre AS producto_nombre FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante UNION ALL SELECT fabricante.nombre, NULL AS producto_nombre FROM fabricante JOIN producto ON fabricante.codigo = producto.codigo_fabricante WHERE producto.nombre IS NULL;
/*35*/ SELECT fabricante.nombre FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante WHERE producto.nombre IS NULL;
/*36 Subquery*/ SELECT producto.nombre FROM producto WHERE producto.codigo_fabricante IN (SELECT fabricante.codigo FROM fabricante WHERE fabricante.nombre LIKE "Lenovo");
/*37*/ WITH producto_mas_caro_Lenovo AS (SELECT MAX(precio) AS max_precio FROM producto WHERE producto.codigo_fabricante IN (SELECT fabricante.codigo FROM fabricante WHERE nombre LIKE "Lenovo")) SELECT producto.nombre, producto.precio FROM producto WHERE producto.precio = (SELECT max_precio FROM producto_mas_caro_Lenovo);
/*38*/ SELECT producto.nombre, producto.precio FROM producto WHERE producto.codigo_fabricante IN (SELECT fabricante.codigo FROM fabricante WHERE fabricante.nombre = "Lenovo") ORDER BY producto.precio DESC LIMIT 1;
/*39*/ SELECT producto.nombre, producto.precio FROM producto WHERE producto.codigo_fabricante in (SELECT fabricante.codigo FROM fabricante WHERE fabricante.nombre LIKE "Hewlett-Packard") ORDER BY producto.precio ASC LIMIT 1;
/*40*/ WITH producto_mas_caro_Lenovo AS (SELECT MAX(producto.precio) AS precio_max FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "Lenovo") SELECT producto.nombre, producto.precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= (SELECT precio_max FROM producto_mas_caro_Lenovo);
/*41*/ WITH precio_medio_Asus AS (SELECT AVG(producto.precio) AS promedio_precios FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "Asus") SELECT producto.nombre, producto.precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE "Asus" AND producto.precio > (SELECT promedio_precios FROM precio_medio_Asus);
    
USE universidad;
/*1*/ SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona WHERE persona.tipo LIKE "alumno" ORDER BY persona.apellido1, persona.apellido2, persona.nombre ASC;
/*2*/ SELECT persona.nombre, persona.apellido1, persona.apellido2 FROM persona WHERE persona.tipo LIKE "alumno" AND persona.telefono IS NULL;
/*3*/ SELECT persona.nombre, persona.apellido1, persona.apellido2 FROM persona WHERE persona.tipo LIKE "alumno" AND YEAR(persona.fecha_nacimiento) = 1999;
/*4*/ SELECT persona.nombre, persona.apellido1, persona.apellido2, persona.nif, persona.telefono FROM persona WHERE tipo LIKE "profesor" AND persona.telefono IS NULL AND persona.nif LIKE "%K";
/*5*/ SELECT asignatura.nombre, asignatura.cuatrimestre, asignatura.curso, asignatura.id_grado FROM asignatura WHERE asignatura.cuatrimestre = 1 AND asignatura.curso = 3 AND asignatura.id_grado = 7;
/*6*/ SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre FROM persona JOIN profesor ON persona.id = profesor.id_profesor CROSS JOIN departamento ON departamento.id = profesor.id_departamento ORDER BY persona.apellido1, persona.apellido2, persona.nombre ASC;
/*7*/ SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM asignatura JOIN curso_escolar ON asignatura.curso = curso_escolar.id CROSS JOIN alumno_se_matricula_asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura CROSS JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id WHERE persona.tipo LIKE "alumno" AND persona.nif LIKE "26902806M";
/*8*/ SELECT DISTINCT departamento.nombre FROM departamento JOIN profesor ON departamento.id = profesor.id_departamento CROSS JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor CROSS JOIN grado ON asignatura.id_grado = grado.id WHERE grado.nombre LIKE "Grado en Ingeniería Informática (Plan 2015)";
/*9*/ SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno CROSS JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id CROSS JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE persona.tipo LIKE "alumno" AND curso_escolar.anyo_inicio = 2018;
/*LEFT JOIN i RIGHT JOIN*/
/*1*/ SELECT departamento.nombre AS nombre_departamento, persona.apellido1, persona.apellido2, persona.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento RIGHT JOIN persona ON profesor.id_profesor = persona.id WHERE persona.tipo LIKE "profesor" OR profesor.id_profesor IS NULL ORDER BY departamento.nombre ASC, persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;
/*2*/ SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor WHERE profesor.id_profesor IS NULL;
/*3*/ SELECT departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento WHERE profesor.id_profesor IS NULL;
/*4*/ SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN asignatura ON persona.id = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;
/*5*/ SELECT asignatura.nombre FROM asignatura WHERE asignatura.id_profesor IS NULL;
/*6*/ SELECT departamento.nombre AS nombre_departamento FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id IS NULL GROUP BY departamento.nombre;
/*CONSULTES RESUM*/
/*1*/ SELECT COUNT(*) AS total_estudiantes FROM persona WHERE persona.tipo LIKE "alumno";
/*2*/ SELECT COUNT(*) AS total_estudiantes_1999 FROM persona WHERE persona.tipo LIKE "alumno" AND YEAR(persona.fecha_nacimiento) = 1999;
/*3*/SELECT departamento.nombre, COUNT(DISTINCT persona.id) AS numero_profesores FROM departamento JOIN profesor ON departamento.id = profesor.id_departamento JOIN persona ON profesor.id_profesor = persona.id WHERE persona.tipo LIKE "profesor" GROUP BY departamento.nombre ORDER BY numero_profesores DESC;
/*4*/ SELECT departamento.nombre, COUNT(DISTINCT persona.id) AS numero_profesores FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN persona ON profesor.id_profesor = persona.id GROUP BY departamento.nombre;
/*5*/ SELECT DISTINCT grado.nombre AS nombre_grado, COUNT(asignatura.id) AS numero_asignaturas FROM grado LEFT JOIN asignatura ON asignatura.id_grado = grado.id GROUP BY grado.nombre;
/*6*/ SELECT grado.nombre AS nombre_grado, COUNT(DISTINCT asignatura.id) AS numero_asignaturas FROM grado JOIN asignatura ON grado.id = asignatura.id_grado HAVING numero_asignaturas > 40;
/*7*/ SELECT grado.nombre, asignatura.tipo, SUM(asignatura.creditos) AS numero_creditos FROM grado JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre;
/*8*/ SELECT curso_escolar.anyo_inicio, COUNT(alumno_se_matricula_asignatura.id_alumno) AS cantidad_alumnos FROM curso_escolar LEFT JOIN alumno_se_matricula_asignatura ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar GROUP BY curso_escolar.anyo_inicio;
/*9*/ SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.id) AS numero_asignatura FROM persona LEFT JOIN asignatura ON persona.id = asignatura.id_profesor WHERE persona.tipo LIKE "profesor" GROUP BY persona.id ORDER BY numero_asignatura DESC;
/*10*/SELECT * from persona WHERE persona.tipo LIKE "alumno" ORDER BY persona.fecha_nacimiento DESC LIMIT 1;
/*11*/SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2 FROM persona JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id IS NULL AND profesor.id_departamento IS NOT NULL;


