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

-- crear tabla grado
CREATE TABLE grado (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- crear tabla curso_escolar
CREATE TABLE curso_escolar (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    anyo_inicio YEAR(4) NOT NULL,
    anyo_fin YEAR(4) NOT NULL
);

-- crear tabla asignatura
create table asignatura(
id int auto_increment primary key,
nombre varchar(100) not null,
creditos FLOAT not null,
tipo enum('basica','optativa','obligatoria') not null,
curso TINYINT(3) not null,
cuatrimestre TINYINT(3) not null,
id_profesor int(10),
id_grado int(10) not null,
foreign key (id_profesor) references persona(id),
foreign key (id_grado) references grado(id)
);

--crear tabla alumno_se_matricula_asignatura
CREATE TABLE alumno_se_matricula_asignatura (
    id_alumno INT(10) NOT NULL,
    id_asignatura INT(10) NOT NULL,
    id_curso_escolar INT(10) NOT NULL,
    PRIMARY KEY (id_alumno, id_asignatura, id_curso_escolar),
    FOREIGN KEY (id_alumno) REFERENCES persona(id),
    FOREIGN KEY (id_asignatura) REFERENCES asignatura(id),
    FOREIGN KEY (id_curso_escolar) REFERENCES curso_escolar(id)
);
-- Desarrollado por Oliver López / I.D 1097911715
