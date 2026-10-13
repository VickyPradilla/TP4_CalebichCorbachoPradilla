SELECT m.id_medico, COUNT(r.id_receta) AS cantidad_recetas
FROM medicos m
LEFT JOIN recetas r ON r.id_medico = m.id_medico
GROUP BY m.id_medico
ORDER BY cantidad_recetas DESC, m.id_medico;

-- Si se quiere mostrar el nombre del medico, se agrega nombre al SELECT y al GROUP BY:
SELECT m.id_medico, m.nombre, COUNT(r.id_receta) AS cantidad_recetas
FROM medicos m
LEFT JOIN recetas r ON r.id_medico = m.id_medico
GROUP BY m.id_medico, m.nombre
ORDER BY cantidad_recetas DESC, m.id_medico;