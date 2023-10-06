use personal;

-- EJERCICIO 25 Hallar los departamentos que tienen más de tres empleados. Mostrar el número de
-- empleados de esos departamentos.
SELECT 
    COUNT(departamentos.id_depto) AS Cantidad_Empleados,
    departamentos.nombre_depto
FROM
    departamentos
        INNER JOIN
    empleados ON departamentos.id_depto = empleados.id_depto 
GROUP BY departamentos.nombre_depto
HAVING COUNT(departamentos.id_depto) > 3
ORDER BY Cantidad_Empleados DESC;

-- EJERCICIO 26 Hallar los departamentos que no tienen empleados
SELECT
	COUNT(departamentos.id_depto) AS Cantidad_Empleados,
	departamentos.nombre_depto
FROM
	departamentos
INNER JOIN
    empleados ON
	departamentos.id_depto = empleados.id_depto
GROUP BY
	departamentos.nombre_depto
HAVING
	COUNT(departamentos.id_depto) = 0
ORDER BY
	Cantidad_Empleados DESC;

-- EJERCICIO 28 Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la
-- empresa. Ordenarlo por departamento.
SELECT 
    nombre as Nombre_Empleado, sal_emp as Salario_Empleado, departamentos.nombre_depto as Departamento
FROM
    empleados
    inner join departamentos ON empleados.id_depto = departamentos.id_depto
WHERE
    sal_emp >= (SELECT 
            AVG(sal_emp)
        FROM
            empleados)
ORDER BY Departamento ASC, sal_emp DESC;

