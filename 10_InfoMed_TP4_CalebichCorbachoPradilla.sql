SELECT P.nombre, C.fecha, C.diagnostico
FROM consultas C
JOIN pacientes P ON C.id_paciente = P.id_paciente
WHERE C.fecha BETWEEN '2024-08-01' AND '2024-08-31';