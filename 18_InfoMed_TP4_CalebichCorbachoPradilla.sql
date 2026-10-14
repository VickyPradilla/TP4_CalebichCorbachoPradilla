/*Obtener el nombre del medicamento junto con el total de recetas prescritas para ese
medicamento, el nombre del médico que lo recetó y el nombre del paciente al que se
le recetó, ordenado por total de recetas en orden descendente*/

SELECT med.nombre AS medicamento, COUNT(r.id_receta) AS cant_recetas, M.nombre AS medico, P.nombre AS paciente
FROM recetas r
JOIN medicamentos med ON med.id_medicamento = r.id_medicamento
JOIN medicos M ON M.id_medico = r.id_medico
JOIN pacientes P ON P.id_paciente = r.id_paciente
GROUP BY med.id_medicamento, med.nombre,
         M.id_medico, M.nombre,
         P.id_paciente, P.nombre
ORDER BY cant_recetas DESC;
