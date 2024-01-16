/*Catastro 63-72*/

use CATASTRO

--63--
select CALLE,NUMERO,PLANTA,NUMHABITACIONES,p.PUERTA,METROSUTILES,pr.NOMBRE,
pr.APELLIDO1,pr.APELLIDO2
from PISO p inner join PROPIETARIO pr
	on p.DNIPROPIETARIO=pr.DNI
where METROSUTILES>(select AVG(METROSCONSTRUIDOS)
					from PISO
						 )

--64--
select avg(METROSSOLAR)as media
from VIVIENDA
where exists (select *
					from BLOQUEPISOS
					where NUMPISOS>5
						 )

select avg(METROSSOLAR)as media
from VIVIENDA v inner join (
							select CALLE,NUMERO,COUNT(*) as num
							from PISO
							group by CALLE,NUMERO
							having COUNT(*)>5) p
on p.CALLE=v.CALLE and p.NUMERO=v.NUMERO

select avg(METROSSOLAR)as media
from VIVIENDA v
where exists (select CALLE,NUMERO,COUNT(*) as num
				from PISO p
				where p.CALLE=v.CALLE and p.NUMERO=v.NUMERO
				group by CALLE,NUMERO
				having COUNT(*)>5
						 )

--65--
select NOMBREZONA,NUMPARQUES
from ZONAURBANA
where exists (select *
				from VIVIENDA
				where ZONAURBANA.NOMBREZONA=VIVIENDA.NOMBREZONA)

--66--
select z.NOMBREZONA,z.DESCRIPCIÓN,v.CALLE,v.NUMERO,v.METROSSOLAR
from ZONAURBANA z inner join VIVIENDA v
	on z.NOMBREZONA=v.NOMBREZONA
where TIPOVIVIENDA='casa'
union
select NOMBREZONA,DESCRIPCIÓN,'','',''
from ZONAURBANA
where NOMBREZONA not in (select distinct NOMBREZONA
							from VIVIENDA
							where TIPOVIVIENDA='casa'
)

select z.NOMBREZONA,z.DESCRIPCIÓN,v.CALLE,v.NUMERO,v.METROSSOLAR
from ZONAURBANA z left join VIVIENDA v
	on z.NOMBREZONA=v.NOMBREZONA
and TIPOVIVIENDA='casa'
				

--67--
select DNI,NOMBRE,APELLIDO1,
				(select COUNT(*)
				from PISO
				where DNI=DNIPROPIETARIO) as num_pisos,
				(select COUNT(*)
				from CASAPARTICULAR
				where DNI=DNIPROPIETARIO) as num_casas
from PROPIETARIO
where dni in (select distinct DNIPROPIETARIO
				from PISO
				union
				select distinct DNIPROPIETARIO
				from CASAPARTICULAR 
				)

--68--
select CALLE,NUMERO,PLANTA,PUERTA
from PISO p inner join PROPIETARIO pr
	on p.DNIPROPIETARIO=pr.DNI
where SEXO='M'
and NUMHABITACIONES=(
	select MAX(NUMHABITACIONES)
	from PISO p inner join PROPIETARIO pr
	on p.DNIPROPIETARIO=pr.DNI
	where SEXO='M')

--69--
select *
from CASAPARTICULAR
where PISCINA='N' and
METROSCONSTRUIDOS<( select AVG (METROSCONSTRUIDOS)
					from CASAPARTICULAR
)

--70--
select DNI,NOMBRE,APELLIDO1,APELLIDO2, COUNT (*)
from PROPIETARIO pr inner join PISO p
	on p.DNIPROPIETARIO=pr.DNI
where NUMHABITACIONES>1
group by DNI,NOMBRE,APELLIDO1,APELLIDO2
having COUNT (*)>1

--71--
select DNI,NOMBRE,APELLIDO1,APELLIDO2
from PROPIETARIO pr
where not exists (select *
				from PISO p
				where p.DNIPROPIETARIO=pr.DNI)

select DNI,NOMBRE,APELLIDO1,APELLIDO2
from PROPIETARIO 
where dni not in (select distinct DNIPROPIETARIO
				from PISO )

select DNI,NOMBRE,APELLIDO1,APELLIDO2
from PROPIETARIO pr left join PISO p
	on p.DNIPROPIETARIO=pr.DNI
where DNIPROPIETARIO is null

--72--
select DNI,NOMBRE,APELLIDO1,COUNT (*) as numPiso
from PROPIETARIO pr inner join PISO p
				on p.DNIPROPIETARIO=pr.DNI
where dni not in (select distinct DNIPROPIETARIO
				from CASAPARTICULAR)
group by DNI,NOMBRE,APELLIDO1
HAVING COUNT (*)>1