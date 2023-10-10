
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
	datediff(fecha_esperada, fecha_entrega) as dias_anes
from
	pedido
where
	datediff(fecha_esperada, fecha_entrega) >= 2;

-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
select
	p.codigo_pedido,
	p.estado 
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
select
	*
from
	producto
where
	gama = 'Ornamentales'
	and cantidad_en_stock > 100
order by
	precio_venta desc;

-- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo
-- representante de ventas tenga el código de empleado 11 o 30.
select
	*
from
	cliente
where
	ciudad = 'Madrid'
	and codigo_empleado_rep_ventas in (11, 30);

-- Consultas multitabla (Composición interna)

-- Las consultas se deben resolver con INNER JOIN.
-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante
-- de ventas.
select
	c.nombre_cliente,
	concat(nombre, " ", apellido1, " ", apellido2) as nombre_completo_empleado
from
	cliente c
inner join empleado e on
	c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus
-- representantes de ventas.
select
	c.nombre_cliente,
	concat(nombre, " ", apellido1, " ", apellido2) as nombre_completo_empleado,
	p.id_transaccion 
from
	cliente c
inner join empleado e on
	c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join pago p on
	c.codigo_cliente = p.codigo_cliente ;

-- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de
-- sus representantes de ventas.
select
	c.nombre_cliente,
	concat(nombre, " ", apellido1, " ", apellido2) as nombre_completo_empleado,
	p.id_transaccion
from
	cliente c
inner join empleado e on
	c.codigo_empleado_rep_ventas = e.codigo_empleado
left join pago p on
	c.codigo_cliente = p.codigo_cliente
where
	p.id_transaccion is null;

-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
-- junto con la ciudad de la oficina a la que pertenece el representante.
select
	c.nombre_cliente,
	concat(nombre, " ", apellido1, " ", apellido2) as nombre_completo_representante,
	p.id_transaccion,
	o.ciudad as ciudad_representante
from
	cliente c
inner join empleado e on
	c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join pago p on
	c.codigo_cliente = p.codigo_cliente 
inner join oficina o on
	e.codigo_oficina = o.codigo_oficina ;
	
-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus
-- representantes junto con la ciudad de la oficina a la que pertenece el representante.
select
	c.nombre_cliente,
	concat(nombre, " ", apellido1, " ", apellido2) as nombre_completo_representante,
	p.id_transaccion,
	o.ciudad as ciudad_representante
from
	cliente c
inner join empleado e on
	c.codigo_empleado_rep_ventas = e.codigo_empleado
left join pago p on
	c.codigo_cliente = p.codigo_cliente 
inner join oficina o on
	e.codigo_oficina = o.codigo_oficina
where
	p.id_transaccion is null;
	
-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
select
	o.codigo_oficina,
	o.ciudad,
	o.linea_direccion1,
	c.nombre_cliente ,
	c.ciudad
from
	oficina o
inner join empleado e on o.codigo_oficina = e.codigo_oficina 
inner join cliente c on c.codigo_empleado_rep_ventas = e.codigo_empleado 
where c.ciudad = 'Fuenlabrada' ;

-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad
-- de la oficina a la que pertenece el representante.
select
	c.nombre_cliente, 
	concat(e.nombre, " ", e.apellido1, " ", e.apellido2) as nombre_completo_representante,
	o.ciudad as ciudad_oficina_representante
from
	cliente c
inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado 
inner join oficina o on o.codigo_oficina = e.codigo_oficina 
order by nombre_completo_representante asc;

-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
select
	concat(e.nombre, " ", e.apellido1, " ", e.apellido2) as nombre_completo_empleado,
	concat(e1.nombre, " ", e1.apellido1, " ", e1.apellido2) as nombre_completo_jefe
from
	empleado e
inner join empleado e1 on e.codigo_jefe = e1.codigo_empleado ;

-- 9. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
select
	c.nombre_cliente,
	count(*) as cantidad_pedidos_entregados_retrasados
from
	cliente c
inner join pedido p on
	c.codigo_cliente = p.codigo_cliente 
where
	p.fecha_entrega > p.fecha_esperada 
group by c.nombre_cliente ;


-- 10. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
select
	c.nombre_cliente,
	p.gama
from
	producto p
inner join detalle_pedido dp on
	p.codigo_producto = dp.codigo_producto 
inner join pedido p2 on
	dp.codigo_pedido = p2.codigo_pedido 
inner join cliente c on
	p2.codigo_cliente = c.codigo_cliente 
group by p.gama, c.nombre_cliente 
order by c.nombre_cliente;

