-- ########################################
-- ### DIA # 5 - CLAVES Y RESTRICCIONES ###
-- ########################################

CREATE DATABASE dia5;
use dia5;

-- REFUERZO EN  CLAVES Y RESTRICCIONES
CREATE TABLE triangle (
  sidea DOUBLE,
  sideb DOUBLE,
  sidec DOUBLE AS (SQRT(sidea * sidea + sideb * sideb)) Comment 'Calcula la raiz cuadrada de la multiplicacion de los lados a y b' -- PEMDAS
);
-- drop table triangle;
select * from triangle;

insert into triangle (sidea,sideb) values (1,2),(2,3),(4,5);

-- REVISIÓN DE COMENTARIOS DE UNA COLUMNA CREADA
SELECT
    COLUMN_COMMENT
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'dia5' AND
    TABLE_NAME = 'triangle' AND
    COLUMN_NAME = 'sidec';
    

-- REPASO JOINS DE DIA 3
use dia3;

-- Obtén un listado con el nombre de cada cliente y el 
-- nombre y apellido de su representante de ventas.
select c.nombre_cliente, e.nombre,e.apellido1,e.apellido2
from cliente c inner join empleado e
on e.codigo_empleado = c.codigo_empleado_rep_ventas;

-- Muestra el nombre de los clientes que hayan realizado 
-- pagos junto con el nombre de sus representantes de ventas.
select c.nombre_cliente, e.nombre,e.apellido1,e.apellido2
from cliente c
inner join pago p on c.codigo_cliente = p.codigo_cliente
inner join empleado e 
on c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- Devuelve el nombre de los clientes que han hecho pagos y el 
-- nombre de sus representantes junto con la ciudad de la 
-- oficina a la que pertenece el representante.
select c.nombre_cliente, e.nombre,e.apellido1,e.apellido2,o.ciudad
from cliente c
inner join pago p on c.codigo_cliente = p.codigo_cliente
inner join empleado e 
on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o on e.codigo_oficina = o.codigo_oficina;

-- Devuelve el nombre de los clientes que no hayan hecho 
-- pagos y el nombre de sus representantes junto con la ciudad 
-- de la oficina a la que pertenece el representante.
select c.nombre_cliente, e.nombre,e.apellido1,e.apellido2,o.ciudad
from cliente c
inner join pago p on c.codigo_cliente = p.codigo_cliente
inner join empleado e 
on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o on e.codigo_oficina = o.codigo_oficina
where p.codigo_cliente is null
;

-- Lista la dirección de las 
-- oficinas que tengan clientes en Fuenlabrada.
select distinct mozo.linea_direccion1, mozo.linea_direccion2
from cliente c
inner join empleado e 
on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina mozo on e.codigo_oficina =mozo.codigo_oficina
where c.ciudad = 'Fuenlabrada';

-- Devuelve un listado que muestre el nombre de cada empleados, 
-- el nombre de su jefe y el nombre del jefe de sus jefe.
select empleado.nombre as NombreEmpleado,
jefe.nombre as NombreJefe
,jefe2.nombre as NombreJefe2
from empleado
inner join empleado jefe 
on empleado.codigo_jefe = jefe.codigo_empleado
inner join empleado jefe2 on jefe.codigo_jefe = jefe2.codigo_empleado;

-- Devuelve un listado con los datos de los empleados que no 
-- tienen clientes asociados y el nombre de su jefe asociado.
select concat(e.nombre,' ',e.apellido1,' ',e.apellido2) as 'Empleado',
e.email,e.puesto,concat(j.nombre,' ',j.apellido1,' ',j.apellido2) as 'Jefe'
from empleado e
left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
inner join empleado j on e.codigo_jefe = j.codigo_empleado
where c.codigo_empleado_rep_ventas is null;

-- Desarrollado por Oliver López / 1097911715