-- Relevamiento de las ciudades existentes
SELECT DISTINCT ciudad FROM pacientes ORDER BY ciudad;

-- Correccion de las variantes
UPDATE pacientes SET ciudad = 'Buenos Aires'
WHERE ciudad ILIKE '%B%Ai__s%';

UPDATE pacientes SET ciudad = 'Córdoba'
WHERE ciudad IN ('Cordoba', 'Córodba');

UPDATE pacientes SET ciudad = 'Mendoza'
WHERE ciudad = 'Mendzoa';

UPDATE pacientes SET ciudad = 'Rosario'
WHERE ciudad = 'rosario';

-- Verificacion
SELECT ciudad, COUNT(*) FROM pacientes GROUP BY ciudad ORDER BY ciudad;