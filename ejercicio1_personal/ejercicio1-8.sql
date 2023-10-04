use personal;

-- EJERCICIO 1 Obtener los datos completos de los empleados.
SELECT * FROM empleados;

-- EJERCICIO 2 Obtener los datos completos de los departamentos.
SELECT * FROM departamentos;

-- EJERCICIO 3 Listar el nombre de los departamentos.
SELECT nombre_depto FROM departamentos;

-- EJERCICIO 4 Obtener el nombre y salario de todos los empleados.
SELECT nombre, sal_emp FROM empleados ORDER BY sal_emp DESC;

-- EJERCICIO 5 Listar todas las comisiones.
SELECT comision_emp FROM empleados;

-- EJERCICIO 6 Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
SELECT * FROM empleados WHERE cargo_emp LIKE "Secretaria";

-- EJERCICIO 7 Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente.
SELECT * FROM empleados WHERE cargo_emp LIKE "Vendedor" ORDER BY nombre ASC;

-- EJERCICIO 8 Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
SELECT 
    nombre, cargo_emp
FROM
    empleados
ORDER BY sal_emp ASC;