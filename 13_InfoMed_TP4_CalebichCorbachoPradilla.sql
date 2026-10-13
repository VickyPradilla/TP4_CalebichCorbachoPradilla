/*Obtener el nombre de cada especialidad y la cantidad de médicos que pertenecen a
ella, mostrando únicamente aquellas especialidades que tienen más de 2 médicos*/

SELECT e.nombre AS especialidad,
       COUNT(M.id_medico) AS cant_medicos
FROM especialidades e
JOIN medicos M ON e.id_especialidad = M.especialidad_id
GROUP BY e.id_especialidad, e.nombre
HAVING COUNT(M.id_medico) > 2;