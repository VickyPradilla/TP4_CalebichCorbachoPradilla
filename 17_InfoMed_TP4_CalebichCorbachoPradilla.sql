/*Obtener el nombre del médico junto con el nombre del paciente y el número total de
consultas realizadas por cada médico para cada paciente, ordenado por médico y
paciente*/

SELECT M.nombre AS medico, P.nombre AS paciente, COUNT(C.id_consulta) AS cant_consultas
FROM consultas C
JOIN medicos M ON M.id_medico = C.id_medico
JOIN pacientes P ON P.id_paciente = C.id_paciente
GROUP BY M.id_medico, M.nombre, P.id_paciente, P.nombre
ORDER BY M.nombre, P.nombre;
