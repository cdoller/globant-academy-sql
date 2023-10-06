use tienda;

-- EJERCICIOS DE SUBCONSULTAS

-- Con operadores basicos de comparacion
-- Ejercicio 1: Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT 
	*
FROM
    producto
WHERE
    codigo_fabricante = (SELECT 
            codigo
        FROM
            fabricante
        WHERE
            nombre LIKE '%Lenovo%');

-- Ejercicio 2: Devuelve todos los datos de los productos que tienen el mismo precio que el producto
-- más caro del fabricante Lenovo. (Sin utilizar INNER JOIN). 
SELECT 
    *
FROM
    producto
WHERE
    precio = (SELECT 
            MAX(precio)
        FROM
            producto
        WHERE
            codigo_fabricante = (SELECT 
                    codigo
                FROM
                    fabricante
                WHERE
                    nombre LIKE '%lenovo%'));
                    
-- Ejercicio 3: Lista el nombre del producto más caro del fabricante Lenovo.
SELECT 
    *
FROM
    producto
WHERE
    codigo_fabricante = (SELECT 
            codigo
        FROM
            fabricante
        WHERE
            nombre LIKE '%lenovo%')
ORDER BY precio DESC
LIMIT 1;

-- Ejercicio 4: Lista todos los productos del fabricante Asus que tienen un precio superior al precio
-- medio de todos sus productos.
-- opcion1
select
	*
from
	producto
where
	precio > (
	select
		AVG(precio)
	from
		producto
	where
		codigo_fabricante = (
		select
			codigo
		from
			fabricante
		where
			nombre = 'Asus'))
	and codigo_fabricante = (
	select
		codigo
	from
		fabricante
	where
		nombre = 'Asus');

-- opcion 2
select
	*
from
	producto
where
	codigo_fabricante = (
	select
		codigo
	from
		fabricante
	where
		nombre = 'Asus')
	and precio > (
	select
		avg(precio)
	from
		producto);
            
-- Subconsultas con IN y NOT IN
-- Ejercicio 1: Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o
-- NOT IN).
SELECT 
    nombre
FROM
    fabricante
WHERE
    codigo IN (SELECT 
            codigo_fabricante
        FROM
            producto
        GROUP BY codigo_fabricante);
        
-- Ejercicio 2: Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando
-- IN o NOT IN).
SELECT 
    nombre
FROM
    fabricante
WHERE
    codigo NOT IN (SELECT 
            codigo_fabricante
        FROM
            producto
        GROUP BY codigo_fabricante);
    
-- Subconsultas (En la cláusula HAVING)
-- Ejercicio 1: Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número
-- de productos que el fabricante Lenovo.
select
	count(producto.nombre) as "Cantidad_Productos",
	fabricante.nombre
from
	producto
inner join fabricante on
	producto.codigo_fabricante = fabricante.codigo
group by
	codigo_fabricante, fabricante.nombre
having
	count(producto.nombre) = (
	select
		count(nombre)
	from
		producto
	where
		codigo_fabricante = (
		select
			codigo
		from
			fabricante
		where
			nombre = "Lenovo"));


