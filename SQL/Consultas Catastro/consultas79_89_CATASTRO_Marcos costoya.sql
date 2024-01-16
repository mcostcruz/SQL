/*Catastro 79-89*/

use CATASTRO

--79--
select NOMBREZONA, ISNULL (OBSERVACIONES,'No hay observaciones') as Observaciones
from ZONAURBANA

--80--
select DNI,NOMBRE,APELLIDO1,APELLIDO2,NOMBREZONA,c.CALLE
from CASAPARTICULAR c inner join PROPIETARIO p
	on c.DNIPROPIETARIO=p.DNI
	inner join VIVIENDA v
	on v.CALLE=c.CALLE and v.NUMERO=c.NUMERO
order by RIGHT (NOMBREZONA,2),c.CALLE

--81--
select top 2 nombre,apellido1
from PROPIETARIO
order by NEWID()

--82--
select p.CALLE,p.NUMERO,PLANTA,PUERTA,NUMHABITACIONES,METROSUTILES,
NOMBRE,APELLIDO1,APELLIDO2,
case 
			when NUMHABITACIONES IN (1,2) then 'Apertamento'
			when NUMHABITACIONES IN (3,4) then 'Piso'
			when NUMHABITACIONES>4 then 'Pisazo'
			ELSE 'Desconocido'
			end as Tipo
from PISO p inner join VIVIENDA v
	on v.CALLE=p.CALLE and v.NUMERO=p.NUMERO
	inner join ZONAURBANA z
	on v.NOMBREZONA=z.NOMBREZONA
	inner join PROPIETARIO pr
	on DNI=DNIPROPIETARIO
where NUMPARQUES>1 and
v.NOMBREZONA in (select NOMBREZONA
				from VIVIENDA
				where TIPOVIVIENDA='casa')
				
--83--
select NOMBRE+' '+APELLIDO1+' '+'posee '+cast (COUNT(*)as varchar)+ 
' piso'+ 
case
	when COUNT(*)>1 then 's'
	else ''
	end
+' en la calle '+CALLE+' '+
'nº'+cast (NUMERO as varchar) as Propietarario
from PISO p inner join PROPIETARIO pr
	on DNI=DNIPROPIETARIO
group by NOMBRE,APELLIDO1,CALLE,NUMERO
union all
select NOMBRE+' '+APELLIDO1+' '+'posee una casa en la calle '+CALLE+' '+
'nº'+cast (NUMERO as varchar) as Propietarario
from CASAPARTICULAR c inner join PROPIETARIO pr
	on DNI=DNIPROPIETARIO

--84--
select * from
(select CALLE,NUMERO,PLANTA,PUERTA,NUMHABITACIONES,Piscina=null,METROSUTILES as Metros
from PISO
union
select c.CALLE,c.NUMERO,null,null,null,PISCINA,v.METROSSOLAR as metros
from CASAPARTICULAR c inner join VIVIENDA v
	on v.CALLE=c.CALLE and v.NUMERO=c.NUMERO) AS X
order by case
			when PLANTA IS null THEN Metros
			WHEN Piscina IS NULL THEN NUMHABITACIONES
end

--85--
select case 
when (select COUNT (*)
from PISO p inner join PROPIETARIO pr
	on DNIPROPIETARIO=dni
where SEXO='H')>
(select COUNT (*)
from PISO p inner join PROPIETARIO pr
	on DNIPROPIETARIO=dni
where SEXO='M') Then 'Los hombres tienes mas pisos'
when (select COUNT (*)
from PISO p inner join PROPIETARIO pr
	on DNIPROPIETARIO=dni
where SEXO='H')<
(select COUNT (*)
from PISO p inner join PROPIETARIO pr
	on DNIPROPIETARIO=dni
where SEXO='M') Then 'Las mujeres tienes mas pisos'
Else 'Tienen los dos el mismo numero'
End as Resultado

--86--
select NOMBRE+' '+APELLIDO1+' '+ISNULL(APELLIDO2,' ')as 'Propietario'
,'Piso' as 'Tipo Propiedad', COUNT(*)
from PISO p inner join PROPIETARIO pr
	on p.DNIPROPIETARIO=DNI
group by NOMBRE,APELLIDO1,APELLIDO2
union all
select NOMBRE+' '+APELLIDO1+' '+ISNULL(APELLIDO2,' ')as 'Propietario'
,'Vivienda unifamiliar' as 'Tipo Propiedad', COUNT(*)
from CASAPARTICULAR c  inner join PROPIETARIO pr
	on c.DNIPROPIETARIO=DNI
group by NOMBRE,APELLIDO1,APELLIDO2
union all
select NOMBRE+' '+APELLIDO1+' '+ISNULL(APELLIDO2,' ')as 'Propietario'
,TIPO as 'Tipo Propiedad', COUNT(*)
from HUECO h  inner join PROPIETARIO pr
	on h.DNIPROPIETARIO=DNI
group by NOMBRE,APELLIDO1,APELLIDO2,TIPO

--87--
select top 1 with ties COUNT (*) as numero
from (select DNIPROPIETARIO
		from CASAPARTICULAR
		union all
		select DNIPROPIETARIO
		from PISO
		union all
		select DNIPROPIETARIO
		from HUECO ) as x
where DNIPROPIETARIO is not null
group by DNIPROPIETARIO
order by COUNT (*)desc

--88--
select top 1 with ties DNI,NOMBRE+' '+APELLIDO1+' '+ISNULL(APELLIDO2,' ')as 'Nombre completo'
,COUNT (*) as numero
from (select DNIPROPIETARIO
		from CASAPARTICULAR
		union all
		select DNIPROPIETARIO
		from PISO
		union all
		select DNIPROPIETARIO
		from HUECO ) as x
		inner join PROPIETARIO p
		on DNIPROPIETARIO=DNI
group by DNI,NOMBRE,APELLIDO1,APELLIDO2
order by numero desc

--89--
use EmpresaNew

select AVG (Salario)
from EMPREGADOFIXO
where Salario not in (select MAX(Salario)
						from EMPREGADOFIXO
					union all
					select MIN(Salario)
						from EMPREGADOFIXO)