-- ############################
-- ###	CORRECIÓN - CONSULTAS  ###
-- ############################

use examen;

## Consultas sobre una tabla

-- 1. Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos. El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.

SELECT apellido1, apellido2, nombre
FROM alumno
ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

-- 2. Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.

select apellido1, apellido2, nombre
from alumno
where telefono IS NULL;

-- 3. Devuelve el listado de los alumnos que nacieron en 1999.

SELECT *
FROM alumno
WHERE YEAR(fecha_nacimiento) = 1999;

-- 4. Devuelve el listado de profesores que no han dado de alta su número de teléfono en la base de datos y además su nif termina en K.

SELECT nombre, apellido1, apellido2
FROM profesor
WHERE (telefono IS NULL)
AND nif LIKE '%K';

-- 5. Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.

SELECT *
FROM asignatura
WHERE cuatrimestre = 1
AND curso = 3
AND id_grado = 7;

## Consultas multitabla

-- 1. Devuelve un listado con los datos de todas las alumnas que se han matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).

SELECT a.nombre, a.apellido1, a.apellido2
FROM alumno a
JOIN alumno_se_matricula_asignatura am ON a.id = am.id_alumno
JOIN asignatura asi ON am.id_asignatura = asi.id
JOIN grado g ON asi.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)'
AND a.sexo = 'M';

--  2. Devuelve un listado con todas las asignaturas ofertadas en el Grado en Ingeniería Informática (Plan 2015).

SELECT asi.nombre
FROM asignatura asi
JOIN grado g ON asi.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 3. Devuelve un listado de los profesores junto con el nombre del departamento al que están vinculados. El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento. El resultado estará ordenado alfabéticamente de menor a mayor por los apellidos y el nombre.

SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS nombre_departamento
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id
ORDER BY p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;

-- 4. Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno con nif 26902806M.

SELECT asi.nombre, ce.anyo_inicio, ce.anyo_fin
FROM alumno a
JOIN alumno_se_matricula_asignatura am ON a.id = am.id_alumno
JOIN asignatura asi ON am.id_asignatura = asi.id
JOIN curso_escolar ce ON am.id_curso_escolar = ce.id
WHERE a.nif = '26902806M';

-- 5. Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).

SELECT DISTINCT d.nombre
FROM departamento d
JOIN profesor p ON d.id = p.id_departamento
JOIN asignatura asi ON p.id = asi.id_profesor
JOIN grado g ON asi.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 6. Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.

SELECT DISTINCT a.*
FROM alumno a
JOIN alumno_se_matricula_asignatura am ON a.id = am.id_alumno
JOIN curso_escolar ce ON am.id_curso_escolar = ce.id
WHERE ce.anyo_inicio = '2018' AND ce.anyo_fin = '2019';

## Consultas multitabla (Composición externa)

-- 1. Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados. El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado. El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.

SELECT d.nombre AS nombre_departamento, p.apellido1, p.apellido2, p.nombre
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id
ORDER BY nombre_departamento ASC, p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;

-- 2. Devuelve un listado con los profesores que no están asociados a un departamento.

SELECT p.apellido1, p.apellido2, p.nombre
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id
WHERE d.id IS NULL;

-- 3. Devuelve un listado con los departamentos que no tienen profesores asociados.

SELECT d.nombre AS nombre_departamento
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
WHERE p.id IS NULL;

-- 4. Devuelve un listado con los profesores que no imparten ninguna asignatura.

SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(asi.id) AS numero_asignaturas
FROM profesor p
LEFT JOIN asignatura asi ON p.id = asi.id_profesor
GROUP BY p.id, p.nombre, p.apellido1, p.apellido2
HAVING numero_asignaturas = 0;

-- 5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.

SELECT asi.nombre
FROM asignatura asi
LEFT JOIN profesor p ON asi.id_profesor = p.id
WHERE p.id IS NULL;

-- 6. Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar. El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca.

SELECT d.nombre AS nombre_departamento, asi.nombre AS nombre_asignatura
FROM departamento d
JOIN profesor p ON d.id = p.id_departamento
JOIN asignatura asi ON p.id = asi.id_profesor
WHERE NOT EXISTS (
    SELECT 1
    FROM curso_escolar ce
    JOIN alumno_se_matricula_asignatura am ON ce.id = am.id_curso_escolar AND am.id_asignatura = asi.id
)
ORDER BY nombre_departamento ASC, nombre_asignatura ASC;

## Consultas resúmen

-- 1. Devuelve el número total de alumnas que hay.

SELECT COUNT(*)
FROM alumno
WHERE sexo = 'M';

-- 2. Calcula cuántos alumnos nacieron en 1999.

SELECT COUNT(*)
FROM alumno
WHERE YEAR(fecha_nacimiento) = 1999;

-- 3. Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.

SELECT d.nombre AS nombre_departamento, COUNT(p.id) AS numero_profesores
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.nombre
HAVING COUNT(p.id) > 0
ORDER BY numero_profesores DESC;

-- 4. Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también tienen que aparecer en el listado.

SELECT d.nombre AS nombre_departamento, COUNT(p.id) AS numero_profesores
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.nombre
ORDER BY nombre_departamento ASC;

-- 5. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados también tienen que aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.

SELECT g.nombre AS nombre_grado, COUNT(asi.id) AS numero_asignaturas
FROM grado g
LEFT JOIN asignatura asi ON g.id = asi.id_grado
GROUP BY g.nombre
ORDER BY numero_asignaturas DESC;

-- 6. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.

SELECT g.nombre AS nombre_grado, COUNT(asi.id) AS numero_asignaturas
FROM grado g
LEFT JOIN asignatura asi ON g.id = asi.id_grado
GROUP BY g.nombre
HAVING COUNT(asi.id) > 40
ORDER BY numero_asignaturas DESC;

-- 7. Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo. Ordene el resultado de mayor a menor por el número total de crédidos.

SELECT g.nombre AS nombre_grado, asi.tipo, SUM(asi.creditos) AS total_creditos
FROM grado g
JOIN asignatura asi ON g.id = asi.id_grado
GROUP BY g.nombre, asi.tipo
ORDER BY total_creditos DESC;

-- 8. Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.

SELECT ce.anyo_inicio, COUNT(am.id_alumno) AS numero_alumnos
FROM curso_escolar ce
LEFT JOIN alumno_se_matricula_asignatura am ON ce.id = am.id_curso_escolar
GROUP BY ce.anyo_inicio
ORDER BY ce.anyo_inicio ASC;

-- 9. Devuelve un listado con el número de asignaturas que imparte cada profesor. El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas.

SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(asi.id) AS numero_asignaturas
FROM profesor p
LEFT JOIN asignatura asi ON p.id = asi.id_profesor
GROUP BY p.id, p.nombre, p.apellido1, p.apellido2
ORDER BY numero_asignaturas DESC;

-- Desarrollado por Oliver Lopez / ID 1097911715