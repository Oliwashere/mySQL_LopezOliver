-- ####################################################
-- ###### DIA 3 - GESTION DE DATOS E INSERCIONES ######
-- ####################################################

-- crear base de datos
create database dia3;

-- utilizar BBDD dia3
use dia3;

-- crear tabla gama_producto
create table gama_producto(
gama VARCHAR(50) primary key,
descripcion_texto TEXT,
descripcion_html TEXT,
imagen VARCHAR(256)
);

-- crear tabla producto
create table producto(
codigo_producto VARCHAR(15) primary key,
nombre VARCHAR(70) not null,
gama VARCHAR(50) not null,
dimensiones VARCHAR(25),
proveedor VARCHAR(50),
descripcion TEXT,
cantidad_en_stock SMALLINT(6) not null,
precio_venta DECIMAL (15,2) not null,
precio_proveedor DECIMAL (15,2),
foreign key (gama) references gama_producto(gama)
);

-- crear tabla detalle_pedido
create table detalle_pedido(
codigo_pedido INT(11),
codigo_producto VARCHAR(15),
cantidad INT(11) not null,
precio_unidad DECIMAL(15,2),
numero_linea SMALLINT(6),
foreign key (codigo_pedido) references pedido(codigo_pedido),
foreign key (codigo_producto) references producto(codigo_producto)
);

-- crear tabla pedido
create table pedido(
codigo_pedido INT(11) primary key,
fecha_pedido DATE not null,
fecha_esperada DATE Not null,
fecha_entrega DATE,
estado VARCHAR(15) not null,
comentarios TEXT,
codigo_cliente INT(11) not null,
foreign key (codigo_cliente) references cliente(codigo_cliente)
);

-- crear tabla cliente
create table cliente(
codigo_cliente INT(11) primary key,
nombre_cliente VARCHAR(50) not null,
nombre_contacto VARCHAR(30),
apellido_contacto VARCHAR(30),
telefono VARCHAR(15) not null,
fax VARCHAR(15) not null,
linea_direccion1 VARCHAR(50) not null,
linea_direccion2 VARCHAR(50),
ciudad VARCHAR(50) not null,
region VARCHAR(50),
pais VARCHAR(50),
codigo_postal VARCHAR(10),
codigo_empleado_rep_ventas INT(11),
limite_credito DECIMAL(15,2),
foreign key (codigo_empleado_rep_ventas) references empleado(codigo_empleado)
);

-- crear tabla pago
create table pago(
codigo_cliente INT(11),
forma_pago VARCHAR(40) not null,
id_transaccion VARCHAR(50) primary key,
fecha_pago DATE not null,
total DECIMAL(15,2) not null,
foreign key (codigo_cliente) references cliente(codigo_cliente)
);

-- crear tabla empleado
create table empleado(
codigo_empleado INT(11) primary key,
nombre VARCHAR(50) not null,
apellido1 VARCHAR(50) not null,
apellido2 VARCHAR(50),
extension VARCHAR(10) not null,
email VARCHAR(100) not null,
codigo_oficina VARCHAR(10) not null,
codigo_jefe INT(11),
puesto VARCHAR(50),
foreign key (codigo_oficina) references oficina(codigo_oficina),
foreign key (codigo_jefe) references empleado(codigo_empleado)
);

-- crear tabla oficina
create table oficina(
codigo_oficina VARCHAR(10) primary key,
ciudad VARCHAR(30) not null,
pais VARCHAR(50) not null,
region VARCHAR(50),
codigo_postal VARCHAR(10) not null,
telefono VARCHAR(20) not null,
linea_direccion1 VARCHAR(50) not null,
linea_direccion2 VARCHAR(50)
);

-- Desarrollado por Oliver López / 1097911715