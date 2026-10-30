-- ==============================================
-- SECCIÓN A) 30 CONSULTAS CON JOIN DE 2 TABLAS
-- ==============================================
-- 1:  Para cada actor, muestra el número total de películas en las que aparece; es decir, cuenta cuántas filas de film_actor corresponden a cada actor.
SELECT 
actor_id, count(distinct film_id) as numero_de_peliculas
FROM
    actor
    join film_actor using (actor_id)
    group by actor_id;


-- 2:  Lista solo los actores que participan en 20 o más películas (umbral alto) con su conteo.

SELECT 
actor_id, count(distinct film_id) as numero_de_peliculas
FROM
    actor
    join film_actor using (actor_id)
    group by actor_id
    having count(distinct film_id) > 20;

-- 3:  Para cada idioma, indica cuántas películas están catalogadas en ese idioma.

SELECT 
    language.name AS idioma
FROM
    language
GROUP BY language
HAVING COUNT(languages);

-- 4:  Muestra el promedio de duración (length) de las películas por idioma y filtra aquellos idiomas con duración media estrictamente mayor a 110 minutos.

SELECT 
    AVG(film.length) as duracion , language_id, name
FROM
    language
        JOIN
    film USING (language_id)
GROUP BY language_id
HAVING AVG(length) > 110;

-- 5:  Para cada película, muestra cuántas copias hay en el inventario.

SELECT 
    title AS titulo,
    COUNT(inventory.film_id) AS numero_de_peliculas
FROM
    film
        JOIN
    inventory USING (film_id)
GROUP BY inventory.film_id;

-- 6:  Lista solo las películas que tienen al menos 5 copias en inventario.

SELECT 
    title AS nombre,
    COUNT(inventory.film_id) AS numero_de_pelicula
FROM
    inventory
        JOIN
    film USING (film_id)
GROUP BY title
HAVING COUNT(inventory.film_id) > 5;

-- 7:  Para cada artículo de inventario, cuenta cuántos alquileres se han realizado.

SELECT 
    inventory_id, COUNT(rental_id)
FROM
    inventory
        JOIN
    rental USING (inventory_id)
GROUP BY inventory_id;

-- 8:  Para cada cliente, muestra cuántos alquileres ha realizado en total.

SELECT 
    CONCAT(first_name, '', last_name) AS nombre,
    customer_id,
    COUNT(rental_id) AS alquiler
FROM
    customer
        JOIN
    rental USING (customer_id)
GROUP BY customer_id;

-- 9:  Lista los clientes con 30 o más alquileres acumulados.

SELECT 
    customer_id AS id_cliente, COUNT(rental_id) AS alquileres
FROM
    customer
        JOIN
    rental USING (customer_id)
GROUP BY customer_id
HAVING COUNT(rental_id) > 30;

-- 10:  Para cada cliente, muestra el total de pagos (suma en euros/dólares) que ha realizado.

SELECT 
    customer_id AS id_cliente, SUM(amount) as total_pagos
FROM
    customer
        JOIN
    payment USING (customer_id)
group BY customer_id
order by sum(amount);

-- 11:  Muestra los clientes cuyo importe total pagado es al menos 200.

SELECT 
customer.customer_id AS id_cliente, COUNT(amount) AS total_pagado
FROM
    payment
        JOIN
    customer USING (customer_id)
GROUP BY customer.customer_id
having total_pagado < 200;

-- 12:  Para cada empleado (staff), muestra el número de pagos que ha procesado.

SELECT 
    staff_id, COUNT(payment_id) AS numero_de_pagos
FROM
    payment
GROUP BY staff_id;

-- 13:  Para cada empleado, muestra el importe total procesado.

select staff_id, count(amount) as total_procesado from payment group by staff_id;

-- 14:  Para cada tienda, cuenta cuántos artículos de inventario tiene.

select store_id,count(*) as articulos_de_inventario  from store
join inventory using (store_id)
group by store_id;

-- 15:  Para cada tienda, cuenta cuántos clientes tiene asignados.

SELECT 
    store_id, COUNT(customer_id) as clientes 
FROM
    store
        JOIN
    customer USING (store_id)
GROUP BY store_id;

-- 16:  Para cada tienda, cuenta cuántos empleados (staff) tiene asignados.

SELECT 
    store_id, COUNT(staff_id) AS numero_de_staff
FROM
    store
        JOIN
    staff USING (store_id)
GROUP BY store_id;

-- 17:  Para cada dirección (address), cuenta cuántas tiendas hay ubicadas ahí (debería ser 0/1 en datos estándar).

SELECT 
    address_id AS direccion, COUNT(store_id) AS tienda
FROM
    store
        JOIN
    address USING (address_id)
GROUP BY store_id;

SELECT 
    address_id
FROM
    address
GROUP BY address_id
ORDER BY address_id ASC;

-- 18:  Para cada dirección, cuenta cuántos empleados residen en esa dirección.

SELECT 
    address_id, COUNT(staff_id) AS empleados
FROM
    address
        JOIN
    staff USING (address_id)
GROUP BY address_id;

-- 19:  Para cada dirección, cuenta cuántos clientes residen ahí.

SELECT 
    address_id, COUNT(customer_id) AS clientes
FROM
    address
        JOIN
    customer USING (address_id)
GROUP BY customer_id;

-- 20:  Para cada ciudad, cuenta cuántas direcciones hay registradas.

SELECT 
    city_id, COUNT(address_id) AS direcciones_registradas
FROM
    address
        JOIN
    customer USING (address_id)
GROUP BY city_id;

-- 21:  Para cada país, cuenta cuántas ciudades existen.

SELECT 
    country_id, COUNT(city_id) AS ciudades
FROM
    address
        JOIN
    city USING (city_id)
GROUP BY country_id;

-- 22:  Para cada idioma, calcula la duración media de películas y muestra solo los idiomas con media entre 90 y 120 inclusive.



-- 23:  Para cada película, cuenta el número de alquileres que se han hecho de cualquiera de sus copias (usando inventario).
-- 24:  Para cada cliente, cuenta cuántos pagos ha realizado en 2005 (usando el año de payment_date).
-- 25:  Para cada película, muestra el promedio de tarifa de alquiler (rental_rate) de las copias existentes (es un promedio redundante pero válido).
-- 26:  Para cada actor, muestra la duración media (length) de sus películas.
-- 27:  Para cada ciudad, cuenta cuántos clientes hay (usando la relación cliente->address->city requiere 3 tablas; aquí contamos direcciones por ciudad).
-- 28:  Para cada película, cuenta cuántos actores tiene asociados.
-- 29:  Para cada categoría (por id), cuenta cuántas películas pertenecen a ella (sin nombre de categoría para mantener 2 tablas).
-- 30:  Para cada tienda, cuenta cuántos alquileres totales se originan en su inventario.
-- ==============================================
-- SECCIÓN B) 30 CONSULTAS CON JOIN DE 3 TABLAS
-- ==============================================
-- 31:  Para cada actor, cuenta cuántas películas tiene y muestra solo los que superan 15 películas.

SELECT 
    first_name,
    '',
    last_name,
    COUNT(film_id) AS numero_de_peliculas
FROM
    film
        JOIN
    film_actor USING (film_id)
        JOIN
    actor USING (actor_id)
    group by first_name,last_name
    having (count(film_id)) > 15