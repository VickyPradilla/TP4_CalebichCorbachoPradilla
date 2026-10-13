/*Obtener el nombre de cada médico junto con el número total de consultas realizadas
por cada uno a pacientes menores de edad y una tercera columna que indique si el
médico es pediatra (TRUE/FALSE)*/

SELECT M.nombre AS medico,
       COUNT(P.id_paciente) AS consultas_menores,
       CASE WHEN e.nombre = 'Pediatría' THEN 'TRUE' ELSE 'FALSE' END AS es_pediatra
FROM medicos M
LEFT JOIN especialidades e ON e.id_especialidad = M.especialidad_id
LEFT JOIN consultas C ON C.id_medico = M.id_medico
LEFT JOIN pacientes P ON P.id_paciente = C.id_paciente
     AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, P.fecha_nacimiento)) < 18
GROUP BY M.id_medico, M.nombre, e.nombre
ORDER BY M.nombre;
