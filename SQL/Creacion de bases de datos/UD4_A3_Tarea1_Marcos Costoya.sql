/*Tarea 1*/
--1--
create database BD_TiposUsuario1

USE BD_TiposUsuario1
sp_addtype TipoCodigo,'char(8)','NOT NULL'
sp_addtype TipoNUM,'smallint','NOT NULL'
sp_addtype TipoTelefono,'char(13)','NULL'
sp_addtype TipoNombreCorto,'varchar(15)','NOT NULL'

SELECT domain_name, data_type, character_maximum_length
FROM information_schema.domains
ORDER BY domain_name

--2--
sp_droptype TipoCodigo
sp_droptype TipoNUM

SELECT domain_name, data_type, character_maximum_length
FROM information_schema.domains
ORDER BY domain_name