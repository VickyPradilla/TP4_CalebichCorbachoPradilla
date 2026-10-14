/*14. Obtener el nombre y la edad de los pacientes cuya edad sea mayor al promedio de
edad de todos los pacientes, ordenados de mayor a menor edad.*/

SELECT nombre, edad
FROM pacientes_con_edad
WHERE edad > (SELECT AVG(edad) FROM pacientes_con_edad)
ORDER BY edad DESC;
