SELECT  med.nombre AS medicamento, COUNT(*) AS cant_recetas
FROM recetas r
JOIN medicamentos med ON r.id_medicamento = med.id_medicamento
WHERE r.id_medicamento = 2 
GROUP BY med.id_medicamento, med.nombre
HAVING COUNT (*) > 1;


