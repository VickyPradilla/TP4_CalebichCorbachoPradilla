SELECT p.ciudad,
       SUM(CASE WHEN s.descripcion = 'Femenino'  THEN 1 ELSE 0 END) AS femeninos,
       SUM(CASE WHEN s.descripcion = 'Masculino' THEN 1 ELSE 0 END) AS masculinos
FROM pacientes p
JOIN sexobiologico s ON s.id_sexo = p.id_sexo
GROUP BY p.ciudad
ORDER BY p.ciudad;