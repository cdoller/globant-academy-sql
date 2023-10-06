use tienda;

-- Ejercicio 1: Lista el nombre de todos los productos que hay en la tabla producto.
SELECT 
    nombre
FROM
    producto;

-- Ejercicio 2: Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT 
    nombre, precio
FROM
    producto;
    
-- Ejercicio 3: Lista todas las columnas de la tabla producto.
SELECT 
    *
FROM
    producto;
    
-- Ejercicio4: Lista los nombres y los precios de todos los productos de la tabla producto, redondeando
-- el valor del precio.
SELECT 
    nombre, ROUND(precio) AS Precio_Redondeado
FROM
    producto;
    
-- Ejercicio 5: Lista el código de los fabricantes que tienen productos en la tabla producto.
-- Ejercicio 6: Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar
-- los repetidos.
-- Resueltos ambos en la misma consulta.
SELECT 
    fabricante.codigo
FROM
    fabricante
        INNER JOIN
    producto ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.codigo;

-- Ejercicio 7: Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT 
    nombre
FROM
    fabricante
ORDER BY nombre ASC;

-- Ejercicio 8: Lista los nombres de los productos ordenados en primer lugar por el nombre de forma
-- ascendente y en segundo lugar por el precio de forma descendente.
SELECT 
    nombre
FROM
    producto
ORDER BY nombre ASC , precio DESC;

-- Ejercicio 9: Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT 
    *
FROM
    fabricante
LIMIT 5 ;

-- Ejercicio 10: Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas
-- ORDER BY y LIMIT)
SELECT 
    nombre, precio
FROM
    producto
ORDER BY precio ASC
LIMIT 1;

select min(precio) from producto;

-- Ejercicio 11: Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER
-- BY y LIMIT)
SELECT 
    nombre, precio
FROM
    producto
ORDER BY precio DESC
LIMIT 1;

-- Ejercicio 12: Lista el nombre de los productos que tienen un precio menor o igual a $120.
SELECT 
    nombre, precio
FROM
    producto
WHERE
    precio <= 120;
    
-- Ejercicio 13: Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador
-- BETWEEN.
SELECT 
    *
FROM
    producto
WHERE
    precio BETWEEN 60 AND 200;

-- Ejercicio 14: Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador
-- IN.
SELECT 
    *
FROM
    producto
WHERE
    codigo_fabricante IN (1 , 3, 5);
    
-- Ejercicio 15: Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil
-- en el nombre.
SELECT 
    nombre
FROM
    producto
WHERE
    nombre LIKE '%Portátil%';