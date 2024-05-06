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
