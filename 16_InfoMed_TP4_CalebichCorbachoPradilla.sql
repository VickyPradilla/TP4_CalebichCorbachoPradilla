/*Obtener el nombre del paciente junto con la fecha de su última consulta y el
diagnóstico asociado*/

SELECT P.nombre, C.fecha, C.diagnostico
FROM Pacientes P
JOIN Consultas C ON C.id_paciente = P.id_paciente
WHERE C.fecha = (
    SELECT MAX(c2.fecha)
    FROM consultas c2
    WHERE c2.id_paciente = C.id_paciente
);
