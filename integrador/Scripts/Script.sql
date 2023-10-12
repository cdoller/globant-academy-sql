-- integrador
use nba;

-- CANDADO A ----------------------------------------------------------------------------------
-- Posición: 
-- Teniendo el máximo de asistencias por partido, muestre cuantas veces se logró dicho máximo.
select
	count(*) as cuenta,
	max(Asistencias_por_partido) 
from
	estadisticas e2 
group by Asistencias_por_partido 
order by Asistencias_por_partido  desc
limit 1;

-- Clave: 
-- Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posición sea
-- centro o esté comprendida en otras posiciones.
select
	sum(peso)
from
	jugadores j
left join equipos e on
	j.Nombre_equipo = e.Nombre
where
	e.Conferencia = 'East' and (j.Posicion = 'C' or j.posicion in ('C-F','F-C'));
	
	
-- CANDADO B ----------------------------------------------------------------------------------
-- Posición: 
-- Muestre la cantidad de jugadores que poseen más asistencias por partidos, que el numero de
-- jugadores que tiene el equipo Heat.
select
	count(e.asistencias_por_partido)
from
	estadisticas e
where
	e.Asistencias_por_partido > (
	select
		count(*)
	from
		jugadores j
	where
		Nombre_equipo = 'Heat');

-- Clave:
-- La clave será igual al conteo de partidos jugados durante las temporadas del año 1999.
select count(*) from partidos p where temporada like ("%99%");

-- CANDADO C ----------------------------------------------------------------------------------
-- Posición: 
-- La posición del código será igual a la cantidad de jugadores que proceden de Michigan y forman
-- parte de equipos de la conferencia oeste.
-- Al resultado obtenido lo dividiremos por la cantidad de jugadores cuyo peso es mayor o igual a
-- 195, y a eso le vamos a sumar 0.9945.
select
	(count(*) / (select count(*) from jugadores j where j.Peso >= 195)) + 0.9945
from
	jugadores j
left join equipos e on
	j.Nombre_equipo = e.Nombre
where
	j.Procedencia like ('%michigan%') and e.Conferencia = 'West';

-- Clave: 
-- Para obtener el siguiente código deberás redondear hacia abajo el resultado que se devuelve de
-- sumar: el promedio de puntos por partido, el conteo de asistencias por partido, y la suma de
-- tapones por partido. Además, este resultado debe ser, donde la división sea central.
select
	floor(avg(e.Puntos_por_partido) + count(e.asistencias_por_partido) + sum(e.Tapones_por_partido)) as suma_total,
	avg(e.Puntos_por_partido),
	count(e.asistencias_por_partido),
	sum(e.Tapones_por_partido)
from
	estadisticas e
left join jugadores j on e.jugador = j.codigo
left join equipos e2 on j.Nombre_equipo = e2.Nombre 
where e2.Division = 'Central';

-- CANDADO D ----------------------------------------------------------------------------------
-- Posición: 
-- Muestre los tapones por partido del jugador Corey Maggette durante la temporada 00/01. Este
-- resultado debe ser redondeado. Nota: el resultado debe estar redondeado
select
	round(e.tapones_por_partido)
from
	estadisticas e
left join jugadores j on
	e.jugador = j.codigo
where
	j.Nombre = 'Corey Maggette'
	and e.temporada = '00/01';

-- Clave: 
-- Para obtener el siguiente código deberás redondear hacia abajo, la suma de puntos por partido
-- de todos los jugadores de procedencia argentina.
select
	floor(sum(e.Puntos_por_partido))
from
	estadisticas e
left join jugadores j on
	e.jugador = j.codigo
where
	j.Procedencia = 'Argentina' ;