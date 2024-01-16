/*Transacciones Tarea 1 Catastro*/

use CATASTRO

--1--
set implicit_transactions on
Begin try
insert into VIVIENDA (calle,numero,tipovivienda,codigopostal,nombrezona)
values ('Ponzano','44','Casa','23701','Centro');

insert into CASAPARTICULAR (calle,numero,NUMPLANTAS,DNIPROPIETARIO)
values ('Ponzano','44','2',(select DNI
							from PROPIETARIO
							where NOMBRE like 'Malena' and APELLIDO1='Franco' 
							and APELLIDO2='Valiño'))
Commit
end try
begin catch
	rollback
	print 'ERROR'
end catch

set implicit_transactions off

--2--
set implicit_transactions on
Begin try
insert into PROPIETARIO
values ('32444423M','Clementina','Ares','Garcia','M',null);

update HUECO
set DNIPROPIETARIO=(select DNI
					from PROPIETARIO
					where NOMBRE='Clementina' and apellido1='Ares'and
					apellido2='Garcia')
where calle like 'zurbarán' and NUMERO=101 and TIPO like 'garaje'
and DNIPROPIETARIO is null
Commit
end try
begin catch
	rollback
	print 'ERROR'
end catch

select * from HUECO

set implicit_transactions off
--3--
use EmpresaNew

select *
from LUGAR

insert into lugar
values (
(select MAX(ID)+1
from LUGAR),
(select NumDepartamento
from DEPARTAMENTO
where NomeDepartamento='Técnico'),
'Villagarcia'
)

--4--
update EMPREGADO
set sexo='M', Nome='Monica'
where Nome='Paulo' and Apelido1='Máximo' and Apelido2='Guerra';

select * 
from EMPREGADO
where Nome='Monica' and Apelido1='Máximo' and Apelido2='Guerra'