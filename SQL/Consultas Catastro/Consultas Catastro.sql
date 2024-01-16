/*Consultas Catastro*/
use CATASTRO
--1--
select NOMBREZONA,DESCRIPCIÓN,OBSERVACIONES 
from ZONAURBANA

--2--
select CALLE,NUMERO,NUMPLANTAS
from CASAPARTICULAR

--3--
select CALLE,NUMERO,METROSCONSTRUIDOS
from CASAPARTICULAR
where PISCINA='S'

--4--
select CALLE,NUMERO,METROSSOLAR
from VIVIENDA
where TIPOVIVIENDA='Casa'

--5--
select *
from PISO
Where NUMHABITACIONES='3'

--6--
select CALLE,NUMERO,METROSSOLAR
from VIVIENDA
where TIPOVIVIENDA='Casa' and 
METROSSOLAR between 190 and 300

--7--
select *
from BLOQUEPISOS
where NUMPISOS>'15'
order by CALLE,NUMERO

--8--
select CALLE,NUMERO,METROSSOLAR
from VIVIENDA
where TIPOVIVIENDA='Casa' and 
NOMBREZONA='Centro'

--9--
select DNI,NOMBRE,APELLIDO1,APELLIDO2
from PROPIETARIO
where APELLIDO1='López'
order by APELLIDO1,APELLIDO2,NOMBRE

--10--
select CALLE,NUMERO,METROSSOLAR
from VIVIENDA
where TIPOVIVIENDA='Bloque' and (NOMBREZONA='Centro' or 
NOMBREZONA='Palomar') and METROSSOLAR>450

--11--
select *
from HUECO
where TIPO='Garaje' and DNIPROPIETARIO is null
order by CALLE,NUMERO,ID_HUECO

--12--
select NOMBREZONA,DESCRIPCIÓN
from ZONAURBANA
where NUMPARQUES>1
order by NUMPARQUES desc, NOMBREZONA asc

--13--
select *
from ZONAURBANA
where OBSERVACIONES like '%'

--14--
select DNI,NOMBRE,APELLIDO1,APELLIDO2
from PROPIETARIO
where NOMBRE like '___'
order by NOMBRE,APELLIDO1,APELLIDO2

--15--
select CALLE,NUMERO,PLANTA,PUERTA,
METROSCONSTRUIDOS,METROSUTILES,METROSCONSTRUIDOS-METROSUTILES as "metros"
from PISO
order by  metros desc

--16--
select CALLE,NUMERO,PLANTA,PUERTA,
NUMHABITACIONES
from PISO
where NUMHABITACIONES in (1,3,5,6)

--17--
select CALLE,NUMERO,PLANTA,PUERTA,
NUMHABITACIONES,METROSCONSTRUIDOS,
METROSUTILES,
METROSCONSTRUIDOS-METROSUTILES 
as "Diferencia"
from PISO
where NUMHABITACIONES in (1,3,5,6)
and METROSCONSTRUIDOS-METROSUTILES>10

--18--
select NOMBREZONA,NUMPARQUES
from ZONAURBANA
where NUMPARQUES<3 
and OBSERVACIONES is null

--19--
select *
from PISO
where NUMHABITACIONES=2 
and CALLE like 'L%' 
and METROSUTILES<100

--20--
select distinct NOMBREZONA
from VIVIENDA
order by NOMBREZONA desc

--21--
select top 25 percent with ties *
from PISO
order by NUMHABITACIONES

--22--
select CODIGO,CALLE,NUMERO,PLANTA,PUERTA,ID_HUECO,TIPO,METROS,OBSERVACIONES,
ISNULL (DNIPROPIETARIO,'Desconocido') as Propietario
from HUECO
where TIPO='Garaje' and METROS>=14

--23--
select NOMBRE,APELLIDO1,APELLIDO2
from PROPIETARIO
where NOMBRE not like '[abcde]%' and
	APELLIDO1 like '____%'
order by SEXO,NOMBRE,APELLIDO1,APELLIDO2

--24--
select *
from VIVIENDA
where METROSSOLAR like '2%' 
and (CALLE='Damasco' or CALLE='General Mola')

--25--
select NOMBRE,APELLIDO1,SEXO,SEXO+LEFT(nombre,3)+RIGHT(apellido1,2) as Identificador
from PROPIETARIO

--26--
select TIPO
from HUECO
where CALLE='Sol' or CALLE='Luca de Tena'

--27--
select top 5 with ties *
from HUECO
order by METROS desc

--28--
select
REVERSE (nombre) as Invertido
from PROPIETARIO
where SEXO='M'

--29--
select CODIGO,CALLE,NUMERO,PLANTA,PUERTA,ID_HUECO,TIPO,DNIPROPIETARIO,OBSERVACIONES,
ceiling (METROS) as Metros
from HUECO
where TIPO='Garaje' or TIPO='Trastero'

--30--
select TIPO
from HUECO


--31--
select NOMBRE,APELLIDO1,APELLIDO2,
case
	when SEXO='H' then 'Masculino'
	when SEXO='M' then 'Femenino'
end as Sexo
from PROPIETARIO