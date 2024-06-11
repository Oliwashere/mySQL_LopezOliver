-- ########################################
-- ###### DIA 2 - COMANDOS GENERALES ######
-- ########################################

-- comando genereal para revisión de basese de datos creadas 
show databases;

-- crear base de datos
create database dia2;

-- utilizar BBDD dia2
use dia2;

-- crear tabla departamento
create table departamento (
id int auto_increment primary key,
nombre varchar(50) not null
);

-- crear tabla persona
create table persona (
id int auto_increment primary key,
nif varchar(9),
nombre varchar(25) not null,
apellido1 varchar(50) not null,
apellido2 varchar(50),
ciudad varchar(25) not null,
direccion varchar(25) not null,
telefono varchar(9),
fecha_nacimiento DATE not null,
sexo enum('H','M') not null,
tipo enum('profesor','alumno') not null
);

-- crear tabla profesor
create table profesor(
id_profesor int primary key,
id_departamento int not null,
foreign key (id_profesor) references persona(id),
foreign key (id_departamento) references departamento(id)
);

-- Desarrollado por Oliver López / I.D 1097911715