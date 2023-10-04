use tienda;

-- EJERCICIOS DE CONSULTAS MULTITABLA

-- Ejercicio 1: Devuelve una lista con el código del producto, nombre del producto, código del fabricante
-- y nombre del fabricante, de todos los productos de la base de datos.
SELECT 
    producto.codigo,
    producto.nombre,
    producto.codigo_fabricante,
    fabricante.nombre
FROM
    producto
        LEFT JOIN
    fabricante ON producto.codigo_fabricante = fabricante.codigo;
    
-- Ejercicio 2: Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos
-- los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por
-- orden alfabético.
SELECT 
    producto.nombre AS Nombre_Producto,
    producto.precio AS Precio_Producto,
    fabricante.nombre AS Nombre_Fabricante
FROM
    producto
        LEFT JOIN
    fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY Nombre_Fabricante ASC;

-- Ejercicio 3: Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto
-- más barato.
SELECT 
    producto.nombre AS Nombre_Producto,
    producto.precio AS Precio_Producto,
    fabricante.nombre AS Nombre_Fabricante
FROM
    producto
        LEFT JOIN
    fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY producto.precio ASC
LIMIT 1;

-- Ejercicio 4: Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT 
    producto.*, fabricante.nombre AS Nombre_Fabricante
FROM
    producto
        LEFT JOIN
    fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE
    fabricante.nombre LIKE '%Lenovo%';
    
-- Ejercicio 5: Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio
-- mayor que $200.
SELECT 
    producto.* , fabricante.nombre AS Nombre_Fabricante
FROM
    producto
        LEFT JOIN
    fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE
    fabricante.nombre LIKE '%crucial%'
        AND producto.precio > 200;
        
-- Ejercicio 6: Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard.
-- Utilizando el operador IN.
SELECT 
    producto.*, fabricante.nombre AS Nombre_Fabricante
FROM
    producto
        LEFT JOIN
    fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE
    fabricante.nombre IN ('Asus' , 'Hewlett-Packard');

-- Ejercicio 7: Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos
-- los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer
-- lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden
-- ascendente)
SELECT 
    producto.nombre AS Nombre_Producto,
    producto.precio AS Precio_Producto,
    fabricante.nombre AS Nombre_Fabricante
FROM
    producto
        LEFT JOIN
    fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE
    producto.precio >= 180
ORDER BY producto.precio DESC , producto.nombre ASC;

-- Ejercicio 1: Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los
-- productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos
-- fabricantes que no tienen productos asociados.
SELECT 
    fabricante.*, producto.nombre, producto.codigo_fabricante
FROM
    fabricante
        LEFT JOIN
    producto ON fabricante.codigo = producto.codigo_fabricante;

-- Ejercicio 2: Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún
-- producto asociado.
SELECT 
    fabricante.*, producto.nombre, producto.codigo_fabricante
FROM
    fabricante
        LEFT JOIN
    producto ON fabricante.codigo = producto.codigo_fabricante
WHERE
    producto.codigo_fabricante IS NULL;