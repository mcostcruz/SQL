/*Consultas Catastro*/
use CATASTRO

--21--
select top 25 percent with ties *
from PISO
order by NUMHABITACIONES desc

--22--
select CODIGO,CALLE,NUMERO,PLANTA,PUERTA,ID_HUECO,TIPO,METROS,OBSERVACIONES,
ISNULL (cast (DNIPROPIETARIO as varchar),'Desconocido') as Propietario
from HUECO
where TIPO='Garaje' and METROS>=14

--23--
select sexo,NOMBRE+' '+APELLIDO1+' '+ 
isnull (APELLIDO2,' ' ) as Nombre_Completo
from PROPIETARIO
where NOMBRE not like '[abcde]%' and
	APELLIDO1 like '____%'
order by SEXO,NOMBRE,APELLIDO1,APELLIDO2

--24--
select *
from VIVIENDA
where METROSSOLAR like '2%'
--left(METROSSOLAR,1)=2
and CALLE in ('Damasco','General Mola')

--25--
select NOMBRE,APELLIDO1,SEXO,SEXO+LEFT(nombre,3)+RIGHT(apellido1,2) as Identificador
from PROPIETARIO

--26--
select distinct TIPO
from HUECO
where CALLE='Sol' or CALLE='Luca de Tena'

--27--
select top 5 with ties *
from HUECO
order by METROS

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
SELECT UPPER(SUBSTRING(TIPO, 1, 1))+LOWER(SUBSTRING(TIPO, 2, 20)) AS TIPO
FROM HUECO


--31--
select NOMBRE+' '+APELLIDO1+' '+ 
isnull (APELLIDO2,' ' ) as Nombre_Completo,
case
	when SEXO='H' then 'Masculino'
	when SEXO='M' then 'Femenino'
end as Sexo
from PROPIETARIO