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
where NOMBRE='Lucas' and APELLIDO1='L�pez' and apellido2='S�nchez'

update PROPIETARIO
set Fecha_nacimiento='25-02-1980'
where NOMBRE='Mar�a' and APELLIDO1='Rodr�guez' and apellido2='Ramos'

update PROPIETARIO
set Fecha_nacimiento='23-09-1990'
where NOMBRE='Mar�a' and APELLIDO1='Gal�n' and apellido2='S�nchez'

update PROPIETARIO
set Fecha_nacimiento='07-07-1985'
where NOMBRE='Malena' and APELLIDO1='Franco' and apellido2='Vali�o'

update PROPIETARIO
set Fecha_nacimiento='25-12-1990'
where NOMBRE='M�nica' and APELLIDO1='Rodr�guez' and apellido2='Tena'

update PROPIETARIO
set Fecha_nacimiento='25-12-1990'
where NOMBRE='Manolo' and APELLIDO1='Ramos' and apellido2='Gal�n'

update PROPIETARIO
set Fecha_nacimiento='12-01-1965'
where NOMBRE='Jorge Juan' and APELLIDO1='Arranz' and apellido2='P�rez'

update PROPIETARIO
set edad= YEAR (GETDATE()-Fecha_nacimiento-1)-1900
from PROPIETARIO p
where Fecha_nacimiento is not null

--2--
