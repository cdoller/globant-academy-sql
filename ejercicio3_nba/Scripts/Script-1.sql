use nba;

-- 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
select
	nombre
from
	jugadores j
order by
	nombre asc;

-- 2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras,
-- ordenados por nombre alfabéticamente.
select
	nombre,
	Posicion ,
	peso
from
	jugadores j
where
	Posicion = "C"
	and Peso > 200
order by
	nombre asc;
	
-- 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
select
	nombre
from
	equipos e
order by
	nombre asc;
	
-- 4. Mostrar el nombre de los equipos del este (East).
select
	nombre
from
	equipos e
where
	Conferencia = "East";
	
-- 5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
select
	nombre,
	ciudad
from
	equipos e
where
	ciudad like "c%";
	
-- 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
select
	*
from
	jugadores j
order by
	Nombre_equipo ;
	
-- 7. Mostrar todos los jugadores del equipo “Spurs” ordenados por nombre.
select
	*
from
	jugadores j
where
	Nombre_equipo = "Spurs";
	
-- 8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
select
	j.nombre,
	e.Puntos_por_partido,
	e.temporada 
from
	jugadores j
inner join estadisticas e on
	j.codigo = e.jugador
where
	nombre = "Shavlik Randolph";
	
-- 9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
select
	j.nombre,
	e.Puntos_por_partido,
	e.temporada
from
	jugadores j
inner join estadisticas e on
	j.codigo = e.jugador
where
	nombre = "Pau Gasol"
	and e.temporada = "04/05";
	
-- 10. Mostrar el número de PROMEDIO puntos de cada jugador en toda su carrera.
select
	nombre,
	j.Nombre_equipo,
	j.codigo,
	round(avg(e.Puntos_por_partido), 2) as Promedio_PPP
from
	jugadores j
inner join estadisticas e on
	j.codigo = e.jugador
group by
	nombre, j.codigo, j.Nombre_equipo 
order by
	Promedio_PPP DESC;
	
-- 11. Mostrar el número de jugadores de cada equipo.
select
	count(nombre) as Cantidad_Jugadores,
	Nombre_equipo o
from
	jugadores j
group by
	Nombre_equipo
	
-- 12. Mostrar el jugador que más promedio de puntos por partido ha realizado en toda su carrera.
select
	round(avg(puntos_por_partido),2) as Promedio_PPP,
	j.Nombre
from
	estadisticas e
inner join jugadores j on
	e.jugador = j.codigo
group by
	e.jugador,
	j.Nombre 
order by Promedio_PPP desc 
limit 1;

-- 13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
select
	e.Nombre, e.Conferencia, e.Division
from
	equipos e
where
	Nombre = (
	select
		Nombre_equipo
	from
		jugadores j
	where
		altura = (
		select
			max(altura)
		from
			jugadores j));

-- 14. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor
-- diferencia de puntos.
select
	equipo_local,
	equipo_visitante,
	abs(p.puntos_local-p.puntos_visitante) as diferencia
from
	partidos p
where
	abs(p.puntos_local-p.puntos_visitante) = (
	select
		max(abs(puntos_local-puntos_visitante)) as diferencia_maxima
	from
		partidos p );
		
-- 15. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante,
-- equipo_ganador), en caso de empate sera null.
select
	codigo,
	equipo_local,
	equipo_visitante,
	case 
		when puntos_local > puntos_visitante then equipo_local
		when puntos_local < puntos_visitante then equipo_visitante
		else null
	end as equipo_ganador
from partidos;



/* POSICION:  2 / CLAVE : 48248
 * Posición: El candado A está ubicado en la posición calculada a partir del número obtenido en la/s
siguiente/s consulta/s: 
Teniendo el máximo de asistencias por partido, muestre cuantas veces se logró dicho máximo.
Este resultado nos dará la posición del candado (1, 2, 3 o 4)
Clave: La clave del candado A estará con formada por la/s siguientes consulta/s a la base de
datos:
Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posición sea
centro o esté comprendida en otras posiciones. // 
 */
select * from estadisticas e where asistencias_por_partido = (select max(asistencias_por_partido) from estadisticas e);

select sum(peso) from jugadores j inner join equipos e on j.Nombre_equipo = e.Nombre 
where e.Conferencia = 'East' and (j.Posicion = 'C' or j.Posicion in (select distinct posicion from jugadores j where posicion != "c"));


/* POSICION : 3 / CLAVE : 
 * Posición: El candado B está ubicado en la posición calculada a partir del número obtenido en la/s
siguiente/s consulta/s:
Muestre la cantidad de jugadores que poseen más asistencias por partidos, que el numero de
jugadores que tiene el equipo Heat.
Este resultado nos dará la posición del candado (1, 2, 3 o 4)
Clave: La clave del candado B estará con formada por la/s siguientes consulta/s a la base de
datos:
La clave será igual al conteo de partidos jugados durante las temporadas del año 1999.
 */

select
	COUNT(*) as total_resultados
from
	(
	select
		asistencias_por_partido,
		j.Nombre,
		j.codigo
	from
		estadisticas e
	inner join jugadores j on
		e.jugador = j.codigo
	where
		asistencias_por_partido > (
		select
			count(codigo)
		from
			jugadores j
		where
			Nombre_equipo = "Heat")
	group by
		j.codigo,
		j.Nombre,
		asistencias_por_partido
	order by
		asistencias_por_partido) as resultados;
	

select
	*
from
	jugadores j
where
	Nombre = 'Manu Ginobili'
	and Nombre_equipo = '';









	