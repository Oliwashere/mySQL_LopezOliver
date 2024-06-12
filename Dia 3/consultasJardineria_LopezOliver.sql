-- ###############################
-- ###### DIA 3 - CONSULTAS ######
-- ###############################

-- utilizar BBDD dia3
use dia3;

-- Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
SELECT codigo_oficina, ciudad FROM oficina;

-- Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT ciudad, telefono FROM oficina WHERE pais = 'España';

-- Devuelve un listado con los distintos estados por los que puede pasar un pedido.
SELECT DISTINCT estado FROM pedido;

-- Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_entrega > fecha_esperada;

-- Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
SELECT nombre, apellido1, puesto FROM empleado WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

-- Devuelve un listado de todos los pedidos que fueron en 2009.
SELECT * FROM pedido WHERE YEAR(fecha_pedido) = 2009;

-- Devuelve un listado de todos los pedidos que han sido en el mes de enero de cualquier año.
SELECT * FROM pedido WHERE MONTH(fecha_pedido) = 1;

-- Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
SELECT * FROM pago WHERE YEAR(fecha_pago) = 2008 AND forma_pago = 'Paypal' ORDER BY total DESC;

-- Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
SELECT DISTINCT forma_pago FROM pago;
