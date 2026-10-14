/*Obtener el nombre de cada paciente junto con la cantidad total de recetas que haya recibido*/
 
SELECT P.nombre, COUNT(r.id_receta) AS total_recetas
FROM Pacientes P
LEFT JOIN Recetas r ON r.id_paciente = P.id_paciente
GROUP BY P.id_paciente, P.nombre
ORDER BY P.id_paciente;
