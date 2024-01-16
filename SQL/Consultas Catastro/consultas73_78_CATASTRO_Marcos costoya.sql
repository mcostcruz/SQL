/*Catastro 73-78*/

use CATASTRO

--73--
select top 1 with ties NOMBRE,APELLIDO1,APELLIDO2, COUNT(*) as pisos
from PROPIETARIO pr inner join PISO p
	on pr.DNI = p.DNIPROPIETARIO
	inner join VIVIENDA v
	on p.CALLE=v.CALLE and v.NUMERO=p.NUMERO
where NUMHABITACIONES>2 and NOMBREZONA not like 'centro'
group by NOMBRE,APELLIDO1,APELLIDO2
order by pisos desc

--74--
select CALLE,NUMERO,MAX(METROSUTILES)as metros,
MAX(NUMHABITACIONES) as habitaciones
from PISO
group by CALLE,NUMERO
having COUNT (*)>3

--75--
select pr.DNI,pr.NOMBRE,pr.APELLIDO1,pr.APELLIDO2,x.calle,x.numero
from PROPIETARIO pr left join (
			select distinct pr.DNI,NOMBRE,APELLIDO1,APELLIDO2,calle,numero
			from PROPIETARIO pr INNER join PISO p
				on pr.DNI=p.DNIPROPIETARIO
			union all
			select distinct pr.DNI,NOMBRE,APELLIDO1,APELLIDO2,calle,numero
			from PROPIETARIO pr INNER join CASAPARTICULAR c
				on pr.DNI=c.DNIPROPIETARIO) as X
	on pr.DNI=x.DNI
	order by APELLIDO1, NOMBRE

select distinct pr.DNI,NOMBRE,APELLIDO1,APELLIDO2,calle,numero
from PROPIETARIO pr INNER join PISO p
	on pr.DNI=p.DNIPROPIETARIO
union all
select distinct pr.DNI,NOMBRE,APELLIDO1,APELLIDO2,calle,numero
from PROPIETARIO pr INNER join CASAPARTICULAR c
	on pr.DNI=c.DNIPROPIETARIO
UNION
select distinct DNI,NOMBRE,APELLIDO1,APELLIDO2,null,null
from PROPIETARIO
where DNI not in (select distinct dnipropietario
					from PISO
				UNION
				select distinct dnipropietario
					from CASAPARTICULAR)

--76--
select NOMBRE,APELLIDO1,APELLIDO2
from PROPIETARIO pr inner join HUECO h
	on pr.DNI=h.DNIPROPIETARIO
where METROS=(select MIN(METROS)
			from HUECO
			where TIPO='Bodega')

select top 1 with ties NOMBRE,APELLIDO1,APELLIDO2
from PROPIETARIO pr inner join HUECO h
	on pr.DNI=h.DNIPROPIETARIO
where TIPO='Bodega'
order by METROS

--77--
select DNI,NOMBRE,APELLIDO1,APELLIDO2,CALLE,NUMERO,TIPO,METROS
from PROPIETARIO pr inner join HUECO h
	on pr.DNI=h.DNIPROPIETARIO
where SEXO='M'and ((h.tipo='TRASTERO' and metros>10)
or(h.tipo='GARAJE' and metros<13))

select DNI,NOMBRE,APELLIDO1,APELLIDO2,CALLE,NUMERO,TIPO,METROS
from PROPIETARIO pr left join (select *
								from HUECO 	
								where (tipo='TRASTERO' and metros>10)
								or(tipo='GARAJE' and metros<13)) as x
	on	pr.DNI=x.DNIPROPIETARIO
where SEXO='M'

--78--
select top 1 NOMBREZONA, SUM(num) as total
from VIVIENDA v inner join (
							select CALLE,NUMERO, COUNT(*) as NUM,'Piso' as tipo
							from PISO
							group by CALLE,NUMERO
							UNION ALL
							select CALLE,NUMERO, COUNT(*) as NUM,'hueco' as tipo
							from HUECO
							group by CALLE,NUMERO
							UNION ALL
							select CALLE,NUMERO, 1,'casa' as tipo
							from CASAPARTICULAR) as c
	on v.CALLE=c.CALLE and v.NUMERO=c.NUMERO
group by NOMBREZONA
order by total desc
