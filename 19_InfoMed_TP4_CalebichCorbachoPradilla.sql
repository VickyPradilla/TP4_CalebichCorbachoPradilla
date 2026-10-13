/*Obtener el nombre del médico junto con el total de pacientes a los que ha atendido,
ordenado por el total de pacientes en orden descendente*/

SELECT M.nombre, COUNT(DISTINCT C.id_paciente) AS cant_pacientes
FROM consultas C
JOIN medicos M ON M.id_medico = C.id_medico
GROUP BY M.id_medico, M.nombre
ORDER BY cant_pacientes DESC;
