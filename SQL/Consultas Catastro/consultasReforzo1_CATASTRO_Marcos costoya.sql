/*Catastro Refuerzo*/

use CATASTRO

--1--
select top 1 with ties CALLE + ', ' +convert (varchar,NUMERO)+ ' ' +convert (varchar,PLANTA)
+'º'+convert (varchar,PUERTA) as Direccion
from PISO
where METROSCONSTRUIDOS between 100 and 200
order by NUMHABITACIONES desc

--2--
select *
from PROPIETARIO
where (TELEFONO like '610______') or (TELEFONO like '565______')
-- left(telefono,3) in ('610','565')
order by  len (NOMBRE), nombre desc

--3--
select P.CALLE, P.NUMERO, p.planta,p.PUERTA,p.NUMHABITACIONES,
case P.NUMHABITACIONES
	when '1' then 'Ideal Parejas sin o con 1 hijo'
	when '2' then 'Ideal Parejas sin o con 1 hijo'
	when '3' then 'Ideal Parejas con dos hijos'
	ELSE 'Ideal Parejas con más de dos hijos'
end as Comentario
from PISO p inner join PROPIETARIO pr
	on p.DNIPROPIETARIO=pr.DNI
where (DNI like '%A' or DNI like '%B' or DNI like '%H')
-- right (dni,1) in ('A','B','H')

--4--
select APELLIDO1+' '+ isnull (APELLIDO2,'')+' ,'+NOMBRE+' '
+' ('+(LEFT (DNI,2)+'.'+SUBSTRING (dni,3,3)+'.'+SUBSTRING (dni,6,3)+'-'+RIGHT (DNI,1))+')' as 'Nombre Completo con DNI'
,ISNULL(LEFT (telefono,3)+'-'+SUBSTRING (telefono,4,2)+'-'+SUBSTRING (telefono,6,2)+'-'+RIGHT (telefono,2),'Sin Telefono') as Telefono
from PROPIETARIO
where SEXO='M'

--5--
select CALLE + ', ' +convert (varchar,NUMERO)+ ' ' +convert (varchar,PLANTA)
+'º'+convert (varchar,PUERTA) as Direccion, METROSCONSTRUIDOS, METROSUTILES,
METROSCONSTRUIDOS-METROSUTILES as diferencia
from PISO
where METROSCONSTRUIDOS-METROSUTILES<8
order by diferencia,CALLE desc,NUMERO desc

--6--
select TOP 1 WITH TIES CALLE + ', ' +convert (varchar,NUMERO)+ ' ' +convert (varchar,PLANTA)
+'º'+convert (varchar,PUERTA) as Direccion, METROSCONSTRUIDOS, METROSUTILES,
METROSCONSTRUIDOS-METROSUTILES as diferencia
from PISO 
where METROSCONSTRUIDOS-METROSUTILES<8
order by diferencia

--7--
select DISTINCT UPPER (APELLIDO1+' '+ isnull (APELLIDO2,'')+' ,'+NOMBRE) as Nombre_Completo,
ISNULL(LEFT (telefono,3)+'-'+SUBSTRING (telefono,4,2)+'.'+SUBSTRING (telefono,6,2)+'.'+RIGHT (telefono,2),'Desconocido') as Telefono
from PROPIETARIO p inner join HUECO h
	on p.DNI=h.DNIPROPIETARIO
where SEXO='M' and TIPO='bodega' and h.METROS>9
order by Nombre_Completo desc

--8--
select *
from VIVIENDA
where CHARINDEX (' ',CALLE)=0
order by case TIPOVIVIENDA
	when 'bloque' then METROSSOLAR end desc,
		 case TIPOVIVIENDA
	when 'casa' then LEN(nombrezona)end asc
