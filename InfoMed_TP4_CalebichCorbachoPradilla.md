## **16.22 Informática Médica**

***![][image1]***

**TP 4:** 

**Bases de Datos, SQL y Manejo de Versiones**

**Grupo 7**

* Calebich, Sofia					Legajo: 63481  
* Corbacho, Astrid 					Legajo: 63153  
* Pradilla, Victoria 					Legajo: 63421		 			                        
    
    
    
    
  Fecha de entrega: 19/10/2026 

**Parte 1: Bases de Datos**

1. A partir de lo relatado podemos concluir que la gestión actual se realiza a través de una base de datos (BD) relacional, ya que tiene entidades (el paciente y el médico) que se vinculan a través de relaciones (la receta y enfermedad). 

   Según su propósito es una base de datos transaccional: su función es registrar y mantener la operación diaria del centro de salud. Algunas operaciones usuales podrían ser dar de alta pacientes y médicos, registrar consultas, emitir recetas y actualizar datos de contacto. Observamos que estas son operaciones frecuentes, cortas, de inserción, actualización y consulta puntual, típicas de este tipo de base de datos. 

2. La estructura de la BD es la siguiente:

**Paciente**

* ID del paciente: clave primaria  
* Nombre completo  
* Fecha de nacimiento  
* Edad: atributo derivado (de fecha de nacimiento)   
* Sexo biológico  
* Dirección (atributo compuesto)  
  * Calle  
  * Número

**Médico**

* ID del médico: clave primaria  
* Nombre completo  
* Dirección profesional (atributo compuesto)  
  * Calle  
  * Número  
* Especialidad → pasa a ser entidad y se vincula con una relación 

**Especialidad** 

* ID de especialidad: clave primaria  
* Nombre de especialidad

**Consulta** 

* ID de consulta: clave primaria  
* Fecha

**Receta**

* Número de receta: clave primaria  
* Fecha de emisión  
* Nombre paciente y Nombre médico → se eliminan; se obtienen a través de la Consulta 

**Indicación** (entidad débil de Receta) 

* Nº de ítem: clave parcial  
* Especificación temporal (ej.: “por 5 días”, “uso indefinido”)

**Tratamiento** 

* ID de tratamiento: clave primaria  
* Nombre (ej.: Paracetamol 500 mg, Reposo, Kinesiología)  
* Tipo (medicamento / reposo / fisioterapia / otro)

**Enfermedad**

* ID de enfermedad: clave primaria  
* Nombre  
* Descripción

**Ciudad**

* ID de ciudad: clave primaria  
* Nombre

**Relaciones** 

| Relación | Cardinalidad | Participación |
| ----- | ----- | ----- |
| Médico *pertenece a* Especialidad | N:1 | Médico total, Especialidad parcial |
| Paciente *asiste a* Consulta | 1:N | Consulta total, Paciente parcial |
| Médico *realiza* Consulta | 1:N | Consulta total, Médico parcial |
| Consulta *diagnostica* Enfermedad | N:M | ambas parciales |
| Consulta *genera* Receta | 1:N | Receta total, Consulta parcial |
| Receta *contiene* Indicación (identificadora) | 1:N | ambas totales |
| Indicación *indica* Tratamiento | N:1 | Indicación total, Tratamiento parcial |
| Indicación *motivada por* Enfermedad | N:1 | Indicación total, Enfermedad parcial |
| Paciente reside en Ciudad | N:1 | Paciente total, Ciudad parcial |
| Médico trabaja en Ciudad | N:1 | Médico total, Ciudad parcial |

![][image2]

3. Diagrama de Crow

![][image3]

4. A continuación indicamos qué formas normales se violan en cada caso:

![][image4]  
En este caso se viola la primera forma normal (1FN), según la cual cada celda de la tabla puede tener un solo valor.   
![][image5]  
En este caso se viola la tercera forma normal (3FN): las columnas que no son clave tienen dependencia transitiva, ya que el código postal depende de la ciudad. 

![][image6]  
En este caso se viola la segunda forma normal (2FN): La clave primaria es compuesta (PacienteID, MédicoID), pero NombrePaciente depende únicamente de PacienteID y Especialidad depende únicamente de MédicoID. Existen dependencias funcionales parciales, lo que provoca redundancia y anomalías de actualización e inserción.   
![][image7]  
En este caso se viola la cuarta forma normal: las dependencias son multivaluadas, ya que PacienteID está asociado a un conjunto de enfermedades (gripe y diabetes) y a un conjunto de medicamentos (paracetamol e ibuprofeno) que son independientes entre sí, y la tabla repite todas las combinaciones. Se debe hacer la separación en dos tablas: paciente-enfermedad y paciente-medicamento.

**Parte 2**

**1\.** Cuando se realizan consultas sobre la tabla paciente agrupando por ciudad los tiempos de respuesta son demasiado largos. Proponer mediante una query SQL una solución a este problema.

![][image8]

*Este caso está pensado para tablas con una gran cantidad de datos. En ese caso se puede crear un índice sobre la columna ciudad, que guarda sus valores ordenados y permite agrupar sin recorrer toda la tabla fila por fila. Esto ahorra tiempo en las consultas, pero a cambio ocupa espacio extra y hace un poco más lentas las inserciones y actualizaciones, porque el índice hay que mantenerlo al día. Otra opción, que no es una query, sería pasar ciudad a una tabla aparte y relacionarla con Pacientes mediante una clave foránea, pero eso implica modificar la estructura de la base y reescribir las consultas con JOIN.*

**2\.** Se tiene la fecha de nacimiento de los pacientes. Se desea calcular la edad de los pacientes y almacenarla de forma dinámica en el sistema ya que es un valor típicamente consultado, junto con otra información relevante del paciente.

CREATE VIEW pacientes\_con\_edad AS  
SELECT \*,  
       DATE\_PART('year', AGE(CURRENT\_DATE, p.fecha\_nacimiento))::int AS edad  
FROM pacientes;

![][image9]  
![][image10]  
3\. Obtener nombre y edad de pacientes menores de edad.  
![][image11]  
![][image12]

**4\.** La paciente, “Luciana Gómez”, ha cambiado de dirección. Antes vivía en “Avenida  
Las Heras 121” en “Buenos Aires”, pero ahora vive en “Calle Corrientes 500” en  
“Buenos Aires”. Actualizar la dirección de este paciente en la base de datos.

UPDATE Pacientes  
SET calle \= ‘Calle Corrientes’ , numero \= 500  
WHERE nombre \= ‘Luciana Gómez’

**5\.** Obtener el nombre y la dirección de los pacientes que viven en Buenos Aires.

SELECT nombre, calle, numero  
FROM pacientes  
WHERE ciudad ilike '%B%Ai\_\_s%'   
![][image13]

**6\.** Puede pasar que haya inconsistencias en la forma en la que están escritos los nombres de las ciudades, ¿cómo se corrige esto? Agregar la query correspondiente.

*Para corregir las inconsistencias primero se hace un relevamiento de los valores existentes en la columna ciudad y se define cómo debe escribirse cada una. Luego se identifican las variantes mediante búsqueda por coincidencia y se las reemplaza por el valor correcto con un UPDATE. Finalmente se verifica con un GROUP BY que cada ciudad aparezca una sola vez. Para evitar que el problema se repita, lo ideal sería que ciudad sea una tabla aparte, referenciada desde Pacientes mediante una clave foránea, de modo que solo puedan cargarse ciudades ya definidas.*

![][image14]  
![][image15]![][image16]![][image17]  
![][image18]  
![][image19]

**7\.** Cantidad de pacientes por sexo que viven en cada ciudad.

![][image20]

El SUM lo hago para que quede más prolija la tabla.

**8\.** Obtener todas las consultas médicas realizadas por el médico con ID igual a 3  
durante el mes de agosto de 2024\.

![][image21]  
![][image22]  
9\. Obtener la cantidad de recetas emitidas por cada médico.  
![][image23]

![][image24]

De esa forma no se muestran los médicos que no emitieron receta, para eso podríamos hacer un JOIN con la tabla medicos y así visualizar todos los medicos.

![][image25]  
![][image26]  
![][image27]

Esto resulta confuso ya que habria q acordarse el ID de cada medico, por lo que podemos usar el JOIN para agregar los nombres  
![][image28]  
![][image29]  
![][image30]  
10\. Obtener el nombre de los pacientes junto con la fecha y el diagnóstico de todas las  
consultas médicas realizadas en agosto del 2024\.  
![][image31]

11\. Obtener el nombre de los medicamentos prescritos más de una vez por el médico  
con ID igual a 2\.

![][image32]

12\. Obtener el nombre de cada paciente junto con la cantidad total de recetas que ha  
recibido.

![][image33]  
*Continua….*

13\. Obtener el nombre de cada especialidad y la cantidad de médicos que pertenecen a  
ella, mostrando únicamente aquellas especialidades que tienen más de 2 médicos.  
![][image34]  
![][image35]  
**14\.** Obtener el nombre y la edad de los pacientes cuya edad sea mayor al promedio de  
edad de todos los pacientes, ordenados de mayor a menor edad.  
![][image36]

**15\.** Obtener los medicamentos que ocupan las dos primeras posiciones en cantidad de  
recetas emitidas, indicando para cada uno la cantidad de recetas.  
![][image37]  
Existe un empate en la segunda posición entre 5 medicamentos con 4 recetas. Se muestra uno de ellos por el criterio de `LIMIT`.” Mostrar que lo detectaron es un punto a favor.   
16\. Obtener el nombre del paciente junto con la fecha de su última consulta y el  
diagnóstico asociado.  
![][image38]

17\. Obtener el nombre del médico junto con el nombre del paciente y el número total de  
consultas realizadas por cada médico para cada paciente, ordenado por médico y  
paciente.  
![][image39]

**18\.** Obtener el nombre del medicamento junto con el total de recetas prescritas para ese  
medicamento, el nombre del médico que lo recetó y el nombre del paciente al que se  
le recetó, ordenado por total de recetas en orden descendente.  
![][image40]

19\. Obtener el nombre del médico junto con el total de pacientes a los que ha atendido,  
ordenado por el total de pacientes en orden descendente.  
![][image41]  
20\. Obtener el nombre de cada médico junto con el número total de consultas realizadas  
por cada uno a pacientes menores de edad y una tercera columna que indique si el  
médico es pediatra (TRUE/FALSE)

![][image42]

[image1]: img/image1.png

[image2]: img/image2.png

[image3]: img/image3.png

[image4]: img/image4.png

[image5]: img/image5.png

[image6]: img/image6.png

[image7]: img/image7.png

[image8]: img/image8.png

[image9]: img/image9.png

[image10]: img/image10.png

[image11]: img/image11.png

[image12]: img/image12.png

[image13]: img/image13.png

[image14]: img/image14.png

[image15]: img/image15.png

[image16]: img/image16.png

[image17]: img/image17.png

[image18]: img/image18.png

[image19]: img/image19.png

[image20]: img/image20.png

[image21]: img/image21.png

[image22]: img/image22.png

[image23]: img/image23.png

[image24]: img/image24.png

[image25]: img/image25.png

[image26]: img/image26.png

[image27]: img/image27.png

[image28]: img/image28.png

[image29]: img/image29.png

[image30]: img/image30.png

[image31]: img/image31.png

[image32]: img/image32.png

[image33]: img/image33.png

[image34]: img/image34.png

[image35]: img/image35.png

[image36]: img/image36.png

[image37]: img/image37.png

[image38]: img/image38.png

[image39]: img/image39.png

[image40]: img/image40.png

[image41]: img/image41.png

[image42]: img/image42.png