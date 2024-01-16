/*Actualizacion BD Catastro*/

use CATASTRO

--1--
select p.CALLE,p.NUMERO,PLANTA,PUERTA,NUMHABITACIONES,DNIPROPIETARIO,NOMBREZONA
into PISOS_M
from PISO p inner join PROPIETARIO pr
	on p.DNIPROPIETARIO=pr.DNI
	inner join VIVIENDA v
	on p.CALLE=v.CALLE and p.NUMERO=v.NUMERO
where SEXO='M' and pr.NOMBRE like 'M%'

select *
from PISOS_M

--2--
select *
from CASAPARTICULAR

select *
from VIVIENDA

insert into VIVIENDA (calle,numero,tipovivienda,codigopostal,nombrezona)
values ('Ponzano','44','Casa','23701','Centro');
insert into CASAPARTICULAR (calle,numero,NUMPLANTAS,DNIPROPIETARIO)
values ('Ponzano','44','2',(select DNI
							from PROPIETARIO
							where NOMBRE like 'Malena' and APELLIDO1='Franco' 
							and APELLIDO2='Valiño'))

insert into CASAPARTICULAR (calle,numero,NUMPLANTAS,DNIPROPIETARIO)
select 'Ponzano',44,2,DNI
from PROPIETARIO
where NOMBRE like 'Malena' and APELLIDO1='Franco' 
and APELLIDO2='Valiño'

--3--
update CASAPARTICULAR
set PISCINA='S',
METROSCONSTRUIDOS=METROSCONSTRUIDOS+20
where CALLE='Damasco' and NUMERO=6

--4--
select *
from HUECO

update HUECO
set OBSERVACIONES=isnull (OBSERVACIONES,'')+'Tiene enchufe'
where TIPO='bodega' and CALLE='Zurbarán' and NUMERO=101

--5--
select sexo,COUNT(distinct DNI) as numero
from PROPIETARIO pr inner join PISO p
	on DNI=DNIPROPIETARIO
where not exists (select *
					from CASAPARTICULAR
					where DNI=DNIPROPIETARIO)
group by SEXO

--6--
select Nombre+' '+Apellido1+' '+ISNULL(Apellido2,' ')as 'Nome Completo'
from PROPIETARIO p inner join HUECO h
	on DNI=DNIPROPIETARIO
	inner join VIVIENDA v
	on h.CALLE=v.CALLE and h.NUMERO=v.NUMERO
where TIPO in ('garage','trastero') and NOMBREZONA in ('Palomar','Centro') and
not exists (select *
					from CASAPARTICULAR c inner join VIVIENDA v
						on c.CALLE=v.CALLE and c.NUMERO=v.NUMERO
					where DNI=DNIPROPIETARIO)
and not exists (select *
					from PISO p inner join VIVIENDA v
						on p.CALLE=v.CALLE and p.NUMERO=v.NUMERO
					where DNI=DNIPROPIETARIO)