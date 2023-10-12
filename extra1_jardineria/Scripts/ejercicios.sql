
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

-- Consultas multitabla (Composición externa)
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN.

-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
select
	c.*
from
	cliente c
left join pago p on
	c.codigo_cliente = p.codigo_cliente
where
	p.id_transaccion is null;

-- 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún
-- pedido.
select
	c.*,
	p.codigo_pedido
from
	cliente c
left join pedido p on
	c.codigo_cliente = p.codigo_cliente
where
	p.codigo_cliente is null;
	
-- 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que
-- no han realizado ningún pedido.
select
	c.* ,
	p.codigo_pedido,
	p2.id_transaccion
from
	cliente c
left join pedido p on
	c.codigo_cliente = p.codigo_cliente
left join pago p2 on
	c.codigo_cliente = p2.codigo_cliente
where
	p.codigo_cliente is null
	and p2.id_transaccion is null;
	
-- 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina
-- asociada.
select
	e.*
from
	empleado e
left join oficina o on
	e.codigo_oficina = o.codigo_oficina
where
	o.codigo_oficina is null;
	
-- 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente
-- asociado.
select
	e.*,
	c.codigo_empleado_rep_ventas
from
	empleado e
left join cliente c on
	e.codigo_empleado = c.codigo_empleado_rep_ventas
where 
	c.codigo_empleado_rep_ventas is null;
	
-- 6. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los
-- que no tienen un cliente asociado.
select
	e.*,
	c.codigo_empleado_rep_ventas,
	o.codigo_oficina
from
	empleado e
left join cliente c on
	e.codigo_empleado = c.codigo_empleado_rep_ventas
left join oficina o on
	e.codigo_oficina = o.codigo_oficina
where
	c.codigo_empleado_rep_ventas is null
	or o.codigo_oficina is null;
	
-- 7. Devuelve un listado de los productos que nunca han aparecido en un pedido.
select
	dp.codigo_producto as codigo_producto_detalle_pedido,
	p.*
from
	producto p
left join detalle_pedido dp on
	p.codigo_producto = dp.codigo_producto
where
	dp.codigo_producto is null;
	
-- 8. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los
-- representantes de ventas de algún cliente que haya realizado la compra de algún producto
-- de la gama Frutales.
select
	o2.*
from
	oficina o2
where
	o2.codigo_oficina not in (
	select
		o.codigo_oficina
	from
		oficina o
	left join empleado e on
		o.codigo_oficina = e.codigo_oficina
	left join cliente c on
		e.codigo_empleado = c.codigo_empleado_rep_ventas
	left join pedido p on
		c.codigo_cliente = p.codigo_cliente
	left join detalle_pedido dp on
		p.codigo_pedido = dp.codigo_pedido
	left join producto pr on
		dp.codigo_producto = pr.codigo_producto
	where
		pr.gama = 'Frutales');
		
-- 9. Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado
-- ningún pago.
select
	c.*, pa.id_transaccion
from
	cliente c
left join pedido p on
	c.codigo_cliente = p.codigo_cliente
left join pago pa on
	c.codigo_cliente = pa.codigo_cliente 
where 
	pa.id_transaccion is null;
	
-- 10. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el
-- nombre de su jefe asociado.
select
	coalesce(concat(e2.nombre, " ", e2.apellido1, " ", e2.apellido2), "No tiene jefe") as nombre_completo_jefe,
	e.*,
	c.codigo_empleado_rep_ventas
from
	empleado e
left join cliente c on
	e.codigo_empleado = c.codigo_empleado_rep_ventas
left join empleado e2 on 
	e.codigo_jefe = e2.codigo_empleado
where
	c.codigo_empleado_rep_ventas is null;

-- opcion 2
select
	distinct e.*,
	CONCAT(e1.nombre, ' ', e1.apellido1, ' ', e1.apellido2) as 'Jefe'
from
	empleado e
left join cliente c on
	e.codigo_empleado = c.codigo_empleado_rep_ventas
left join empleado e1 on
	e.codigo_jefe = e1.codigo_empleado
where
	c.codigo_cliente is null;

-- Consultas resumen:
-- 1. ¿Cuántos empleados hay en la compañía?
select count(*) as cantidad_empleados from empleado;

-- 2. ¿Cuántos clientes tiene cada país?
select count(*) as cantidad_clientes, pais from cliente group by pais; 

-- 3. ¿Cuál fue el pago medio en 2009?
select avg(total), year(fecha_pago) from pago where year(fecha_pago) = 2009 group by year(fecha_pago); 

-- 4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el
-- número de pedidos.
select count(*) as cantidad_pedidos, estado from pedido group by estado order by count(*) desc;

-- 5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.
select
	max(dp.precio_unidad) as maximo_precio,
	min(dp.precio_unidad) as minimo_precio
from
	detalle_pedido dp;

-- 6. Calcula el número de clientes que tiene la empresa.
select
	count(*) as cantidad_clientes
from
	cliente;

-- 7. ¿Cuántos clientes tiene la ciudad de Madrid?
select
	count(*) as cantidad_clientes, ciudad
from
	cliente
where
	ciudad = 'Madrid';

-- 8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
select
	count(*) as cantidad_clientes, ciudad
from
	cliente
where
	ciudad like 'M%'
group by ciudad;

-- 9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende
-- cada uno.
select
	CONCAT(e.nombre, ' ', e.apellido1, ' ', e.apellido2) as 'Nombre',
	count(c.nombre_cliente)
from
	empleado e
left join cliente c on
	e.codigo_empleado = c.codigo_empleado_rep_ventas
where
	c.nombre_cliente is not null
group by
	e.nombre,
	e.apellido1,
	e.apellido2
order by
	nombre;

-- 10. Calcula el número de clientes que no tiene asignado representante de ventas.
select 
	count(*) as cantidad_clientes_sin_representante_ventas
from
	cliente
where
	codigo_empleado_rep_ventas is null;

-- 11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado
-- deberá mostrar el nombre y los apellidos de cada cliente.
select
	c.nombre_cliente,
	min(p.fecha_pago) as primer_pago,
	case
		when COUNT(p.id_transaccion) = 1 then 'Tiene un solo pago'
		else MAX(p.fecha_pago)
	end as ultimo_pago
from 
	cliente c
left join
	pago p on
	c.codigo_cliente = p.codigo_cliente
where
	p.id_transaccion is not null
group by
	c.nombre_cliente ;

-- 12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.
-- 13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de
-- los pedidos.
select 
	sum(cantidad) as cantidad_productos_carrito,
	count(distinct dp.codigo_producto) as cantidad_productos_diferentes,
	dp.codigo_pedido 
from detalle_pedido dp 
group by codigo_pedido ;

-- 14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que
-- se han vendido de cada uno. El listado deberá estar ordenado por el número total de
-- unidades vendidas.
select 
	sum(cantidad) as unidades_vendidas, 
	codigo_producto
from
	detalle_pedido
group by
	codigo_producto
order by
	sum(cantidad) desc
limit 20;

-- 15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el
-- IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el
-- número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base
-- imponible, y el total la suma de los dos campos anteriores.
-- 217738.00	45724.9800	263462.9800 -- victoria
-- 217576.00	45690.9600	263266.9600 -- carlos
select 
	sum(dp.cantidad * p.precio_proveedor) as base_imponible,
	sum(dp.cantidad * p.precio_proveedor)*0.21 as iva_21,
	sum(dp.cantidad * p.precio_proveedor)*1.21 as total
from
	detalle_pedido dp 
left join
	producto p on
	dp.codigo_producto = p.codigo_producto ;