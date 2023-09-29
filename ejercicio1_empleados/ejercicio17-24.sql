use personal;

-- EJERCICIO 17 Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
SELECT 
    nombre AS 'Nombre_Empleado',
    sal_emp AS 'Salario',
    comision_emp AS 'Comision'
FROM
    empleados
WHERE
    comision_emp <= (0.3 * sal_emp);
    
-- EJERCICIO 18 Hallar los empleados cuyo nombre no contiene la cadena “MA”
SELECT 
    nombre AS 'Nombre_Empleado'
FROM
    empleados
WHERE
    nombre NOT LIKE '%ma%';
    
-- EJERCICIO 19 Obtener los nombres de los departamentos que sean “Ventas”, “Investigación” o
-- ‘Mantenimiento.
SELECT 
    *
FROM
    departamentos
WHERE
    nombre_depto IN ('Ventas' , 'Investigacion', 'Mantenimiento');
    
-- EJERCICIO 20 Ahora obtener el contrario, los nombres de los departamentos que no sean “Ventas” ni
-- “Investigación” ni ‘Mantenimiento.
SELECT 
    *
FROM
    departamentos
WHERE
    nombre_depto NOT IN ('Ventas' , 'Investigacion', 'Mantenimiento');
    
-- EJERCICIO 21 Mostrar el salario más alto de la empresa.
SELECT 
    sal_emp AS 'Salario_Maximo', nombre AS 'Nombre_Empleado'
FROM
    empleados
WHERE
    sal_emp = (SELECT 
            MAX(sal_emp)
        FROM
            empleados);
    
-- EJERCICIO 22 Mostrar el nombre del último empleado de la lista por orden alfabético.
SELECT * FROM empleados where nombre = (SELECT max(nombre) from empleados order by nombre ASC);

-- EJERCICIO 23 Hallar el salario más alto, el más bajo y la diferencia entre ellos.
SELECT 
    MAX(sal_emp) AS salariomax,
    MIN(sal_emp) AS salariomin,
    (MAX(sal_emp) - MIN(sal_emp))
FROM
    empleados;

-- EJERCICIO 24 Hallar el salario promedio por departamento.
SELECT 
    ROUND(AVG(sal_emp), 2) AS Salario_Promedio,
    departamentos.nombre_depto
FROM
    empleados
        INNER JOIN
    departamentos ON empleados.id_depto = departamentos.id_depto
GROUP BY nombre_depto
ORDER BY Salario_Promedio DESC;
