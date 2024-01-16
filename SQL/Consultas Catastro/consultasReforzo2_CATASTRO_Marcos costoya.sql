/*Refuerzo Catastro 2*/

use CATASTRO

--1--
select distinct z.NOMBREZONA,z.DESCRIPCIÓN
from ZONAURBANA z inner join VIVIENDA v
	on z.NOMBREZONA=v.NOMBREZONA
	inner join BLOQUEPISOS b
	on b.CALLE=v.CALLE and v.NUMERO=b.NUMERO
where b.ASCENSOR='N'

--2--
select z.NOMBREZONA,z.DESCRIPCIÓN, COUNT (*) as bloques
from ZONAURBANA z inner join VIVIENDA v
	on z.NOMBREZONA=v.NOMBREZONA
	inner join BLOQUEPISOS b
	on b.CALLE=v.CALLE and v.NUMERO=b.NUMERO
where b.ASCENSOR='N'
group by z.NOMBREZONA,z.DESCRIPCIÓN
union
select z.NOMBREZONA,z.DESCRIPCIÓN,0
from ZONAURBANA z
where NOMBREZONA NOT IN (select distinct V.NOMBREZONA
							from VIVIENDA v
							inner join BLOQUEPISOS b
							on b.CALLE=v.CALLE and v.NUMERO=b.NUMERO
							where b.ASCENSOR='N')

--3--
select NOMBREZONA, COUNT (*) AS piscinas
from VIVIENDA v inner join CASAPARTICULAR c
	on c.CALLE=v.CALLE and v.NUMERO=c.NUMERO
where PISCINA='S'
group by NOMBREZONA
having COUNT (piscina)>2

--4--
select DNI,NOMBRE+' '+APELLIDO1+' '+ isnull (APELLIDO2,' ' ) as Nombre_Completo
from PROPIETARIO pr inner join piso p
	on pr.DNI = p.DNIPROPIETARIO
	inner join VIVIENDA v
	on p.CALLE=v.CALLE and p.NUMERO=v.NUMERO
where SEXO='H' and dni not in (select  distinct DNIPROPIETARIO
					from PROPIETARIO pr inner join piso p
					on pr.DNI = p.DNIPROPIETARIO
					)
	and ((TIPOVIVIENDA='Garaje' and NOMBREZONA='Centro')
	or(TIPOVIVIENDA='Trastero' and NOMBREZONA='Palomar'))

--bien--
select DNI,NOMBRE+' '+APELLIDO1+' '+ isnull (APELLIDO2,' ' ) as Nombre_Completo
from PROPIETARIO
where SEXO='H' and dni not in (select distinct DNIPROPIETARIO from piso)
 and DNI in (select distinct DNIPROPIETARIO
				from HUECO h inner join VIVIENDA v
				on h.CALLE=v.CALLE and h.NUMERO=v.NUMERO
				where (TIPOVIVIENDA='Garaje' and NOMBREZONA='Centro')
	or(TIPOVIVIENDA='Trastero' and NOMBREZONA='Palomar'))

--5--
select NOMBRE+' '+APELLIDO1+' '+ isnull (APELLIDO2,' ' ) as Nombre_Completo
from PROPIETARIO p inner join CASAPARTICULAR c
	on p.DNI = c.DNIPROPIETARIO
where SEXO='M' and PISCINA='S'
intersect
select NOMBRE+' '+APELLIDO1+' '+ isnull (APELLIDO2,' ' ) as Nombre_Completo
from  PROPIETARIO inner join piso 
	on PROPIETARIO.DNI=PISO.DNIPROPIETARIO
	inner join BLOQUEPISOS b
	on piso.CALLE=b.CALLE and piso.NUMERO=b.NUMERO
where SEXO='M' and ASCENSOR='S'

--6--
select distinct dni,NOMBRE+' '+APELLIDO1+' '+ isnull (APELLIDO2,' ' ) as Nombre_Completo,
case
	when DNIPROPIETARIO is not null then 'POSEE AL MENOS UNA CASA PARTICULAR'
	when DNIPROPIETARIO is null then 'NO POSSE NINGUNA CASA PARTICULAR'
	ELSE ''
	END as casa
from PROPIETARIO p left join CASAPARTICULAR c
	on p.DNI = c.DNIPROPIETARIO
where SEXO='H'
--7--
select distinct dni,NOMBRE+' '+APELLIDO1+' '+ isnull (APELLIDO2,' ' ) as Nombre_Completo,
case
	when c.DNIPROPIETARIO is not null then 'POSEE AL MENOS UNA CASA PARTICULAR'
	when c.DNIPROPIETARIO is null then 'NO POSSE NINGUNA CASA PARTICULAR'
	ELSE ''
	END as casa,
case
	when p.DNIPROPIETARIO is not null then 'POSEE AL MENOS UN PISO'
	when p.DNIPROPIETARIO is null then 'NO POSSE NINGUN PISO'
	ELSE ''
	END as Pisos
from PROPIETARIO pr left join CASAPARTICULAR c
	on pr.DNI = c.DNIPROPIETARIO
	left join PISO P
	on pr.DNI = P.DNIPROPIETARIO
where SEXO='H'
	

--8--

--9--
select p.CALLE,p.NUMERO,METROSSOLAR,SUM(METROSCONSTRUIDOS) as construidos
,SUM(METROSUTILES) as utiles
from PISO p inner join VIVIENDA v
	on p.CALLE=v.CALLE and v.NUMERO=p.NUMERO
group by p.CALLE,p.NUMERO,METROSSOLAR
order by construidos desc ,utiles desc

--10--
select p.CALLE,p.NUMERO,METROSSOLAR,SUM(METROSCONSTRUIDOS) as construidos
,SUM(METROSUTILES) as utiles,COUNT (*) as pisos, COUNT (distinct DNIPROPIETARIO)as propietario
from PISO p inner join VIVIENDA v
	on p.CALLE=v.CALLE and v.NUMERO=p.NUMERO
group by p.CALLE,p.NUMERO,METROSSOLAR
order by pisos desc,propietario

--11--
select top 1 with ties NOMBRE+' '+APELLIDO1+' '+ isnull (APELLIDO2,' ' ) as Nombre_Completo,
sum (METROS) as total
from PROPIETARIO p inner join HUECO h
	on P.DNI=h.DNIPROPIETARIO
where TIPO in ('Trastero','Bodega')
Group by dni,NOMBRE,APELLIDO1,APELLIDO2
order by total desc


--12--
select DNI, ISNULL (SUM(METROSCONSTRUIDOS),0) as total
from propietario P left join
							(select DNIPROPIETARIO, METROSCONSTRUIDOS
							from PISO 
							union all
							select DNIPROPIETARIO, METROSCONSTRUIDOS
							from CASAPARTICULAR) as x
ON DNI=DNIPROPIETARIO
group by DNI