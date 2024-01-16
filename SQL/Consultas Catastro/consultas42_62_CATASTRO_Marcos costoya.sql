/*Catastro Group by*/

use CATASTRO

--42--
select max (PLANTA) as maxima
from PISO p inner join PROPIETARIO pr
	on p.DNIPROPIETARIO=pr.DNI
where pr.NOMBRE like 'M%'

--43--
select z.NOMBREZONA,z.NUMPARQUES,CALLE,NUMERO,METROSSOLAR
from VIVIENDA v inner join ZONAURBANA z
	on v.NOMBREZONA=z.NOMBREZONA
where z.NUMPARQUES>1

--44--
select MAX(METROSSOLAR)as Solar_Grande
from VIVIENDA

--45--
select MAX(planta) as maxima
from PISO
where CALLE='damasco'

--46--
select MAX(metrosutiles) as maximo , Min(metrosutiles) as minimo
from PISO
where CALLE='Luca de tena' and NUMERO=22

--47--
select AVG (NUMPARQUES) as 'Media de Parques'
from ZONAURBANA

--48--
select COUNT(*) as 'Numero'
from CASAPARTICULAR c inner join vivienda v
	on c.CALLE=v.CALLE and c.NUMERO=v.NUMERO
where v.NOMBREZONA in ('Palomar','Atocha')

--49--
select AVG (metrosconstruidos) as Media
from CASAPARTICULAR

--50--
select COUNT(*) as Numero
from BLOQUEPISOS b inner join VIVIENDA v
	on b.CALLE=v.CALLE and b.NUMERO=v.NUMERO
where v.NOMBREZONA in ('Centro','Cuatrovientos') and METROSSOLAR>300

--51--
select COUNT(distinct DNIPROPIETARIO) as 'Numero de propietarios'
from CASAPARTICULAR c inner join PROPIETARIO p
	on c.DNIPROPIETARIO=p.DNI

--52--
select COUNT(distinct DNI) as 'Numero de hombres'
from HUECO h inner join PROPIETARIO p
	on h.DNIPROPIETARIO=p.DNI
	inner join VIVIENDA v
	on h.CALLE=v.CALLE and h.NUMERO=v.NUMERO
where p.SEXO='H' and v.NOMBREZONA in ('Palomar','Centro') and h.TIPO='Trastero'

--53--
select NOMBREZONA ,COUNT(*) as 'Numero de viviendas'
from VIVIENDA
group by NOMBREZONA

--54--
select v.NOMBREZONA ,COUNT(*) as 'Numero de bloques'
from BLOQUEPISOS b inner join VIVIENDA v
	on b.CALLE=v.CALLE and b.NUMERO=v.NUMERO
	inner join ZONAURBANA z
	on v.NOMBREZONA=z.NOMBREZONA
group by v.NOMBREZONA

--55--
select CALLE,NUMERO,COUNT(*) AS 'Numero pisos',max(PLANTA) AS 'Altura maxima'
from PISO 
group by CALLE,NUMERO

--56--
select b.CALLE,b.NUMERO
from BLOQUEPISOS b inner join PISO p
	on b.CALLE=p.CALLE and b.NUMERO=p.NUMERO
group by b.CALLE,b.NUMERO
having COUNT(NUMPISOS)>4

--57--
select MAX (p.METROSUTILES) as 'Maximo', MIN(p.METROSUTILES) as 'Minimo'
from PISO p inner join VIVIENDA v
	on p.CALLE=v.CALLE and p.NUMERO=v.NUMERO	
where v.NOMBREZONA='Centro' 

--58--
select CALLE,TIPO,COUNT(TIPO) as 'Numero tipos'
from HUECO
where PLANTA is not null
group by CALLE,TIPO

--59--
select COUNT(*) 'Bloques'
from BLOQUEPISOS b inner join VIVIENDA v
	on b.CALLE=v.CALLE and b.NUMERO=v.NUMERO
	inner join PISO p
	on b.CALLE=p.CALLE and b.NUMERO=p.NUMERO
where v.NOMBREZONA in ('Centro','Palomar') and p.NUMHABITACIONES>3 and
METROSUTILES between 100 and 180

--60--
select CALLE ,COUNT(*)as 'Numero'
from CASAPARTICULAR
where NUMPLANTAS<3
group by CALLE
having SUM(METROSCONSTRUIDOS)>250

--61--
select v.NOMBREZONA, COUNT(*) as pisos , z.DESCRIPCIÓN, z.NUMPARQUES
from PISO p inner join VIVIENDA v
	on p.CALLE=v.CALLE and p.NUMERO=v.NUMERO
	inner join ZONAURBANA z
	on v.NOMBREZONA=z.NOMBREZONA
where NUMHABITACIONES between 3 and 4 
group by v.NOMBREZONA ,z.DESCRIPCIÓN,z.NUMPARQUES
order by NUMPARQUES desc

--62--
select case sexo
	when 'H' then 'Hombres'
	when 'M' then 'Mujeres'
	end as Sexo
	, COUNT(distinct DNI) Propietarios
from PISO p inner join PROPIETARIO pr
	on p.DNIPROPIETARIO=pr.DNI
group by SEXO