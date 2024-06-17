-- #############
-- ### TAREA ###
-- #############

-- Usar database
use dia3;


-- Devuelve un listado que muestre solamente los clientes
-- que no han realizado ningún pago.

SELECT cliente.*
FROM cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
WHERE pago.codigo_cliente IS NULL;

-- Devuelve un listado que muestre solamente los clientes
-- que no han realizado ningún pedido.

SELECT cliente.*
FROM cliente
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE pedido.codigo_cliente IS NULL;

-- Devuelve un listado que muestre los clientes que no han
-- realizado ningún pago y los que no han realizado ningún
-- pedido.

SELECT cliente.*
FROM cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE pago.codigo_cliente IS NULL OR pedido.codigo_cliente IS NULL;

-- Devuelve un listado que muestre solamente los empleados
-- que no tienen una oficina asociada.

SELECT empleado.*
FROM empleado
LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE oficina.codigo_oficina IS NULL;

-- Devuelve un listado que muestre solamente los empleados
-- que no tienen un cliente asociado.

SELECT empleado.*
FROM empleado
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE cliente.codigo_empleado_rep_ventas IS NULL;

-- Devuelve un listado que muestre solamente los empleados
-- que no tienen un cliente asociado junto con los datos de la
-- oficina donde trabajan.

SELECT empleado.*, oficina.*
FROM empleado
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE cliente.codigo_empleado_rep_ventas IS NULL;

-- Devuelve un listado que muestre los empleados que no
-- tienen una oficina asociada y los que no tienen un cliente
-- asociado.

SELECT empleado.*
FROM empleado
LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE oficina.codigo_oficina IS NULL OR cliente.codigo_empleado_rep_ventas IS NULL;

-- Devuelve un listado de los productos que nunca han
-- aparecido en un pedido.

SELECT producto.*
FROM producto
LEFT JOIN detalle_pedido ON producto.codigo_producto = detalle_pedido.codigo_producto
WHERE detalle_pedido.codigo_producto IS NULL;

-- Devuelve un listado de los productos que nunca han
-- aparecido en un pedido. El resultado debe mostrar el
-- nombre, la descripción y la imagen del producto.

SELECT producto.nombre, producto.descripcion, producto.imagen
FROM producto
LEFT JOIN detalle_pedido ON producto.codigo_producto = detalle_pedido.codigo_producto
WHERE detalle_pedido.codigo_producto IS NULL;

-- Devuelve las oficinas donde no trabajan ninguno de los
-- empleados que hayan sido los representantes de ventas de
-- algún cliente que haya realizado la compra de algún
-- producto de la gama Frutales.

SELECT oficina.*
FROM oficina
LEFT JOIN empleado ON oficina.codigo_oficina = empleado.codigo_oficina
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
LEFT JOIN detalle_pedido ON pedido.codigo_pedido = detalle_pedido.codigo_pedido
LEFT JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto
WHERE producto.gama = 'Frutales' AND cliente.codigo_cliente IS NULL;

-- Devuelve un listado con los clientes que han realizado
-- algún pedido pero no han realizado ningún pago.

SELECT cliente.*
FROM cliente
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
WHERE pedido.codigo_cliente IS NOT NULL AND pago.codigo_cliente IS NULL;

-- Devuelve un listado con los datos de los empleados que no
-- tienen clientes asociados y el nombre de su jefe asociado.

SELECT empleado.*, jefe.nombre AS nombre_jefe, jefe.apellido1 AS apellido1_jefe, jefe.apellido2 AS apellido2_jefe
FROM empleado
LEFT JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
LEFT JOIN empleado jefe ON empleado.codigo_jefe = jefe.codigo_empleado
WHERE cliente.codigo_empleado_rep_ventas IS NULL;

-- Desarrollado por Oliver López / 1097911715