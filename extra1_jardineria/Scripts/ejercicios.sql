
use jardineria;
-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
select
	codigo_oficina,
	ciudad
from
	oficina ;

-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
select
	ciudad,
	telefono
from
	oficina
where
	pais = 'España';

-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un
-- código de jefe igual a 7.
select
	nombre,
	concat(apellido1, " ", apellido2) as apellido_s,
	email
from
	empleado
where
	codigo_jefe = 7;

-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
select
	nombre,
	concat(apellido1, " ", apellido2) as apellido_s,
	email,
	puesto
from
	empleado
where
	puesto = 'Director General';

-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean
-- representantes de ventas.
select
	nombre,
	concat(apellido1, " ", apellido2) as apellido_s,
	puesto
from
	empleado
where
	puesto != 'Representante Ventas' ;

-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
select
	nombre_cliente,
	pais
from
	cliente
where
	pais = 'Spain' ;

-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
select
	distinct estado
from
	pedido;

-- 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago
-- en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan
-- repetidos. Resuelva la consulta:
-- o Utilizando la función YEAR de MySQL.
-- o Utilizando la función DATE_FORMAT de MySQL.
-- o Sin utilizar ninguna de las funciones anteriores.
select
	codigo_cliente
from
	cliente
where
	codigo_cliente in (
	select
		codigo_cliente
	from
		pago
	where
		year (fecha_pago) = 2008);

-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
-- entrega de los pedidos que no han sido entregados a tiempo.
select
	codigo_pedido,
	codigo_cliente,
	fecha_esperada,
	fecha_entrega
from
	pedido
where
	fecha_entrega > fecha_esperada  ;

-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
-- entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha
-- esperada.
-- o Utilizando la función ADDDATE de MySQL.
-- o Utilizando la función DATEDIFF de MySQL.
select
	codigo_pedido,
	codigo_cliente,
	fecha_esperada,
	fecha_entrega,
	datediff(fecha_esperada, fecha_entrega) as dias_antes
from
	pedido
where
	datediff(fecha_esperada, fecha_entrega) >= 2;

-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
select
	p.*
from
	pedido p
where
	estado = 'Rechazado'
	and year (fecha_pedido) = 2009;

-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de
-- cualquier año.
select
	p.*
from
	pedido p
where
	estado = 'Entregado'
	and month (fecha_entrega) = 1;

-- 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal.
-- Ordene el resultado de mayor a menor.
select
	pago.*
from
	pago
where
	forma_pago = 'PayPal'
	and year (fecha_pago) = 2008
order by
	total asc;

-- 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en
-- cuenta que no deben aparecer formas de pago repetidas.
select distinct forma_pago from pago;

-- 15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que
-- tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de
-- venta, mostrando en primer lugar los de mayor precio.
