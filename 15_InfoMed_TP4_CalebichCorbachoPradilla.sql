/*15. Obtener los medicamentos que ocupan las dos primeras posiciones en cantidad de
recetas emitidas, indicando para cada uno la cantidad de recetas.*/


SELECT med.nombre AS medicamento, COUNT(*) AS cant_recetas
FROM recetas r
JOIN medicamentos med on r.id_medicamento = med.id_medicamento
GROUP BY med.nombre
ORDER BY cant_recetas DESC
LIMIT 2;