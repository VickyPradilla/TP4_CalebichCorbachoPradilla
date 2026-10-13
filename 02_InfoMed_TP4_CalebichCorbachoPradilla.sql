CREATE OR REPLACE VIEW pacientes_con_edad AS
SELECT *,
       DATE_PART('year', AGE(CURRENT_DATE, fecha_nacimiento))::int AS edad
FROM pacientes;