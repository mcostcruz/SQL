/*Transacciones Tarea 3 */

use CATASTRO

--1--
select *
from PROPIETARIO

alter table propietario
add Fecha_Nacimiento smalldatetime

alter table propietario
add edad tinyint

update PROPIETARIO
set Fecha_nacimiento='12-03-1965'
where NOMBRE='Lucas' and APELLIDO1='López' and apellido2='Sánchez'

update PROPIETARIO
set Fecha_nacimiento='25-02-1980'
where NOMBRE='María' and APELLIDO1='Rodríguez' and apellido2='Ramos'

update PROPIETARIO
set Fecha_nacimiento='23-09-1990'
where NOMBRE='María' and APELLIDO1='Galán' and apellido2='Sánchez'

update PROPIETARIO
set Fecha_nacimiento='07-07-1985'
where NOMBRE='Malena' and APELLIDO1='Franco' and apellido2='Valiño'

update PROPIETARIO
set Fecha_nacimiento='25-12-1990'
where NOMBRE='Mónica' and APELLIDO1='Rodríguez' and apellido2='Tena'

update PROPIETARIO
set Fecha_nacimiento='25-12-1990'
where NOMBRE='Manolo' and APELLIDO1='Ramos' and apellido2='Galán'

update PROPIETARIO
set Fecha_nacimiento='12-01-1965'
where NOMBRE='Jorge Juan' and APELLIDO1='Arranz' and apellido2='Pérez'

update PROPIETARIO
set edad= YEAR (GETDATE()-Fecha_nacimiento-1)-1900
from PROPIETARIO p
where Fecha_nacimiento is not null

--2--
