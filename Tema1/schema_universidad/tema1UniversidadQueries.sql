USE universidad;
/*1*/ SELECT persona.apellido1, persona.apellido2, persona.nombre
FROM persona
WHERE persona.tipo LIKE "alumno"
ORDER BY persona.apellido1, persona.apellido2, persona.nombre ASC;
/*2*/ SELECT persona.nombre, persona.apellido1, persona.apellido2
FROM persona
WHERE persona.tipo LIKE "alumno"
AND persona.telefono IS NULL;
/*3*/ SELECT persona.nombre, persona.apellido1, persona.apellido2
FROM persona
WHERE persona.tipo LIKE "alumno"
AND YEAR(persona.fecha_nacimiento) = 1999;
/*4*/ SELECT persona.nombre, persona.apellido1, persona.apellido2,
persona.nif, persona.telefono
FROM persona
WHERE tipo LIKE "profesor"
AND persona.telefono IS NULL
AND persona.nif LIKE "%K";
/*5*/ SELECT asignatura.nombre, asignatura.cuatrimestre,
asignatura.curso, asignatura.id_grado
FROM asignatura
WHERE asignatura.cuatrimestre = 1
AND asignatura.curso = 3
AND asignatura.id_grado = 7;
/*6*/ SELECT persona.apellido1, persona.apellido2, persona.nombre,
departamento.nombre
FROM persona
JOIN profesor ON persona.id = profesor.id_profesor
CROSS JOIN departamento
ON departamento.id = profesor.id_departamento
ORDER BY persona.apellido1, persona.apellido2, persona.nombre ASC;
/*7*/ SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin
FROM asignatura
JOIN curso_escolar ON asignatura.curso = curso_escolar.id
CROSS JOIN alumno_se_matricula_asignatura
ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura
CROSS JOIN persona
ON alumno_se_matricula_asignatura.id_alumno = persona.id
WHERE persona.tipo LIKE "alumno"
AND persona.nif LIKE "26902806M";
/*8*/ SELECT DISTINCT departamento.nombre FROM departamento
JOIN profesor ON departamento.id = profesor.id_departamento
CROSS JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
CROSS JOIN grado ON asignatura.id_grado = grado.id
WHERE grado.nombre LIKE "Grado en Ingeniería Informática (Plan 2015)";
/*9*/ SELECT persona.apellido1, persona.apellido2, persona.nombre
FROM persona
JOIN alumno_se_matricula_asignatura
ON persona.id = alumno_se_matricula_asignatura.id_alumno
CROSS JOIN asignatura
ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
CROSS JOIN curso_escolar
ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
WHERE persona.tipo LIKE "alumno"
AND curso_escolar.anyo_inicio = 2018;
/*LEFT JOIN i RIGHT JOIN*/
/*1*/ SELECT departamento.nombre AS nombre_departamento,
persona.apellido1,
persona.apellido2,
persona.nombre
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
RIGHT JOIN persona ON profesor.id_profesor = persona.id
WHERE persona.tipo LIKE "profesor"
OR profesor.id_profesor IS NULL
ORDER BY departamento.nombre ASC,
persona.apellido1 ASC,
persona.apellido2 ASC,
persona.nombre ASC;
/*2*/ SELECT persona.apellido1, persona.apellido2, persona.nombre
FROM persona
LEFT JOIN profesor ON persona.id = profesor.id_profesor
WHERE profesor.id_profesor IS NULL;
/*3*/ SELECT departamento.nombre
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
WHERE profesor.id_profesor IS NULL;
/*4*/ SELECT persona.apellido1,
persona.apellido2,
persona.nombre
FROM persona
LEFT JOIN asignatura ON persona.id = asignatura.id_profesor
WHERE asignatura.id_profesor IS NULL;
/*5*/ SELECT asignatura.nombre FROM asignatura
WHERE asignatura.id_profesor IS NULL;
/*6*/ SELECT departamento.nombre AS nombre_departamento
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.id IS NULL
GROUP BY departamento.nombre;
/*CONSULTES RESUM*/
/*1*/ SELECT COUNT(*) AS total_estudiantes
FROM persona
WHERE persona.tipo LIKE "alumno";
/*2*/ SELECT COUNT(*) AS total_estudiantes_1999
FROM persona
WHERE persona.tipo LIKE "alumno"
AND YEAR(persona.fecha_nacimiento) = 1999;
/*3*/ SELECT departamento.nombre,
COUNT(DISTINCT persona.id) AS numero_profesores
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
LEFT JOIN persona ON profesor.id_profesor = persona.id
GROUP BY departamento.nombre;
/*4*/ SELECT departamento.nombre AS nombre_departamento,
persona.apellido1, persona.apellido2, persona.nombre
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
LEFT JOIN persona ON profesor.id_profesor = persona.id;
/*5*/ SELECT DISTINCT grado.nombre AS nombre_grado,
COUNT(asignatura.id) AS numero_asignaturas
FROM grado
LEFT JOIN asignatura ON asignatura.id_grado = grado.id
GROUP BY grado.nombre
HAVING COUNT(grado.id) > 40;


