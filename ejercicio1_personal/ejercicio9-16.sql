use personal;

-- EJERCICIO 9 Obtener el nombre de o de los jefes que tengan su departamento situado en la ciudad de “Ciudad Real”
SELECT 
    nombre AS nombre_jefe, departamentos.ciudad AS nombre_ciudad
FROM
    empleados
        INNER JOIN
    departamentos ON empleados.id_depto = departamentos.id_depto
WHERE
    cargo_emp LIKE 'JEFE%'
        AND departamentos.ciudad LIKE 'CIUDAD REAL';
    
-- EJERCICIO 10 Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las respectivas tablas de empleados.
SELECT nombre AS "Nombre", cargo_emp AS "Cargo" FROM empleados;

-- EJERCICIO 11 Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión de menor a mayor.
SELECT nombre AS "Nombre_Empleado", sal_emp AS "Salario", comision_emp AS "Comision", id_depto AS "Departamento" FROM empleados
WHERE id_depto = 2000
ORDER BY comision_emp ASC;

-- EJERCICIO 12	Obtener el valor total a pagar a cada empleado del departamento 3000, que resulta
-- 				de: sumar el salario y la comisión, más una bonificación de 500. Mostrar el nombre del
-- 				empleado y el total a pagar, en orden alfabetico

SELECT nombre AS "Nombre_Empleado", (sal_emp + comision_emp + 500) AS "Total_A_Pagar" FROM empleados
WHERE id_depto = 3000
ORDER BY nombre ASC;

-- EJERCICIO 13 Muestra los empleados cuyo nombre empiece con la letra J.
SELECT nombre AS 'Nombre_Empleado' FROM empleados
WHERE nombre LIKE "J%";

-- EJERCICIO 14 Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos
-- empleados que tienen comisión superior a 1000 
SELECT 
    nombre AS 'Nombre_Empleado',
    sal_emp AS 'Salario',
    comision_emp AS 'Comision',
    sal_emp + comision_emp AS 'Salario_Total'
FROM
    EMPLEADOS
WHERE
    comision_emp > 1000;

-- EJERCICIO 15 Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión.
SELECT 
    nombre AS 'Nombre_Empleado',
    sal_emp AS 'Salario',
    comision_emp AS 'Comision',
    sal_emp + comision_emp AS 'Salario_Total'
FROM
    EMPLEADOS
WHERE
    comision_emp = 0;
    
-- EJERCICIO 16 Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
SELECT 
    nombre AS 'Nombre_Empleado'
FROM
    empleados
WHERE
    comision_emp > sal_emp;