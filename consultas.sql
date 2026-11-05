use sakila;
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

select language_id as idioma_peliculas, avg(length) from film join language using (language_id) where length > 90 group by language_id ;
select length, language_id from film join language using (language_id) where length > 90 < 120;
SELECt
   language_id AS idioma_peliculas,
    AVG(length) AS duracion_media
FROM film
JOIN language USING (language_id)
GROUP BY language_id
HAVING AVG(length) BETWEEN 90 AND 120;
-- 23:  Para cada película, cuenta el número de alquileres que se han hecho de cualquiera de sus copias (usando inventario).

SELECT 
    film.title,
    film_id,
    COUNT(rental_duration) AS numero_alquileres
FROM
    film
        JOIN
    inventory USING (film_id)
GROUP BY film_id;

-- 24:  Para cada cliente, cuenta cuántos pagos ha realizado en 2005 (usando el año de payment_date).

SELECT 
    COUNT(payment_date) as pagos_realizados, customer_id, first_name, last_name
FROM
    customer
        JOIN
    payment USING (customer_id)
    where year(payment_date) = 2005
    group by customer_id,first_name,last_name
    ;

-- 25:  Para cada película, muestra el promedio de tarifa de alquiler (rental_rate) de las copias existentes (es un promedio redundante pero válido).

SELECT 
    film_id,film.title, AVG(rental_rate)
FROM
    film
        JOIN
    inventory USING (film_id)
GROUP BY film.title, film_id;



select * from film join inventory using (film_id);
-- 26:  Para cada actor, muestra la duración media (length) de sus películas.

select  actor_id, avg(length) from actor join film_actor using (actor_id) group by actor_id;
select film.title, actor_id, avg(length) from film join film_actor using (film_id)group by actor_id,film.title ;
-- 27:  Para cada ciudad, cuenta cuántos clientes hay (usando la relación cliente->address->city requiere 3 tablas; aquí contamos direcciones por ciudad).

SELECT 
    first_name, last_name, city_id, COUNT(customer_id)
FROM
    customer
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
GROUP BY city_id;

SELECT 
    city_id, 
    -- Si tienes la tabla city con el nombre de la ciudad, puedes incluir city.city aquí
    COUNT(customer_id) AS total_clientes
FROM 
    customer
JOIN 
    address USING (address_id)
JOIN 
    city USING (city_id)
GROUP BY 
    city_id;


select *   from customer join address using (address_id) join city using (city_id);
-- 28:  Para cada película, cuenta cuántos actores tiene asociados.

SELECT 
    film_id,
    title,
    COUNT(actor_id) AS total_actores
FROM 
    film
JOIN 
    film_actor USING (film_id)
GROUP BY 
    film_id, title;


-- 29:  Para cada categoría (por id), cuenta cuántas películas pertenecen a ella (sin nombre de categoría para mantener 2 tablas).


SELECT 
    category_id,
    COUNT(film_id) AS total_peliculas
FROM 
    film_category
GROUP BY 
    category_id;
-- 30:  Para cada tienda, cuenta cuántos alquileres totales se originan en su inventario.

SELECT 
    store_id,
    COUNT(rental_id) AS total_alquileres
FROM 
    inventory
JOIN 
    rental USING (inventory_id)
GROUP BY 
    store_id;

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
    having (count(film_id)) > 15;
    
    
    -- 32:  Para cada categoría (por nombre), cuenta cuántas películas hay en esa categoría.
    
    SELECT 
    title AS titulo, COUNT(film_id), category_id AS categoria
FROM
    film
        JOIN
    film_category USING (film_id)
GROUP BY title , category_id;
    select * from film join film_category using (film_id);
-- 33:  Para cada película, cuenta cuántos alquileres se han hecho de sus copias. cross
SELECT 
    title, store_id, count(rental_id)
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
group by title, store_id;

-- 34:  Para cada cliente, suma el importe pagado en 2005 y filtra clientes con total >= 150.

SELECT 
    customer.customer_id, first_name, last_name, COUNT(amount) as suma_total_pagado
FROM
    customer
        JOIN
    rental USING (customer_id)
        JOIN
    payment USING (rental_id)
WHERE
    YEAR(payment_date) = 2005
    group by customer.customer_id;

-- 35:  Para cada tienda, suma el importe cobrado por todos sus empleados.

SELECT 
    store_id, staff_id, COUNT(amount) AS importe_cobrado
FROM
    store
        JOIN
    staff USING (store_id)
        JOIN
    payment USING (staff_id)
GROUP BY store_id , staff_id;

-- 36:  Para cada ciudad, cuenta cuántos empleados residen ahí (staff -> address -> city).

SELECT 
    city_id, city, COUNT(staff_id) as empleados
FROM
    staff
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
GROUP BY city_id , city;

-- 37:  Para cada ciudad, cuenta cuántas tiendas existen (store -> address -> city).

SELECT 
    city, COUNT(store_id) AS tiendas_existentes
FROM
    store
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
GROUP BY city;
select * from store join address using (address_id) join city using (city_id);

-- 38:  Para cada actor, calcula la duración media de sus películas del año 2006.cross

SELECT 
    actor_id, first_name, last_name, AVG(length)
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
WHERE
    release_year = 2006
GROUP BY actor_id , first_name , last_name;

select * from actor join film_actor using (actor_id) join film using (film_id);
select film_id,release_year, YEAR(release_year) from film;

-- 39:  Para cada categoría, calcula la duración media y muestra solo las que superan 120.

SELECT 
    title, name, category.category_id, AVG(length)
FROM
    film
        JOIN
    film_category USING (film_id)
        JOIN
    category
GROUP BY title , category_id
HAVING (AVG(length)) > 120;


-- 40:  Para cada idioma, suma las tarifas de alquiler (rental_rate) de todas sus películas.

SELECT 
    language_id, SUM(rental_rate) AS tarifas_de_alquiler
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
GROUP BY language_id;

select  * from film join inventory using (film_id) join rental using (inventory_id) ;

-- 41:  Para cada cliente, cuenta cuántos alquileres realizó en fines de semana (SÁB-DO) usando DAYOFWEEK (1=Domingo).

SELECT 
    customer.customer_id,
    first_name,
    last_name,
    COUNT(rental_date)
FROM
    customer
        JOIN
    rental USING (customer_id)
        JOIN
    payment USING (rental_id)
    where dayofweek(rental_date) = 1 or dayofweek(rental_date) = 7
GROUP BY customer_id , first_name , last_name;

select *  from customer join rental using (customer_id) join payment using (rental_id)  
-- 42:  Para cada actor, muestra el total de títulos distintos en los que participa (equivale a COUNT DISTINCT, sin subconsulta).
-- 43:  Para cada ciudad, cuenta cuántos clientes residen ahí (customer -> address -> city).
-- 44:  Para cada categoría, muestra cuántos actores distintos participan en películas de esa categoría.
-- 45:  Para cada tienda, cuenta cuántas copias totales (inventario) tiene de películas en 2006.
-- 46:  Para cada cliente, suma el total pagado por alquileres cuyo empleado pertenece a la tienda 1.
-- 47:  Para cada película, cuenta cuántos actores tienen el apellido de longitud >= 5.
-- 48:  Para cada categoría, suma la duración total (length) de sus películas.
-- 49:  Para cada ciudad, suma los importes pagados por clientes que residen en esa ciudad.
-- 50:  Para cada idioma, cuenta cuántos actores distintos participan en películas de ese idioma.
-- 51:  Para cada tienda, cuenta cuántos clientes activos (active=1) tiene.
-- 52:  Para cada cliente, cuenta en cuántas categorías distintas ha alquilado (aprox. vía film_category; requiere 4 tablas, aquí contamos películas 2006 por inventario).
-- 53:  Para cada empleado, cuenta cuántos clientes diferentes le han pagado.
-- 54:  Para cada ciudad, cuenta cuántas películas del año 2006 han sido alquiladas por residentes en esa ciudad.
-- 55:  Para cada categoría, calcula el promedio de replacement_cost de sus películas.
-- 56:  Para cada tienda, suma los importes cobrados en 2006 (vía empleados de esa tienda).
-- 57:  Para cada actor, cuenta cuántas películas tienen título de más de 12 caracteres.
-- 58:  Para cada ciudad, calcula la suma de pagos de 2005 y filtra las ciudades con total >= 300.
-- 59:  Para cada categoría, cuenta cuántas películas tienen rating 'PG' o 'PG-13'.
-- 60:  Para cada cliente, calcula el total pagado en pagos procesados por el empleado 2.
-- ==============================================
-- SECCIÓN C) 20 CONSULTAS CON JOIN DE 4 TABLAS
-- ==============================================
-- 61:  Para cada ciudad, cuenta cuántos clientes hay y muestra solo ciudades con 10 o más clientes.
-- 62:  Para cada actor, cuenta cuántos alquileres totales suman todas sus películas.
-- 63:  Para cada categoría, suma los importes pagados derivados de películas de esa categoría.
-- 64:  Para cada ciudad, suma los importes pagados por clientes residentes en esa ciudad en 2005.
-- 65:  Para cada tienda, cuenta cuántos actores distintos aparecen en las películas de su inventario.
-- 66:  Para cada idioma, cuenta cuántos alquileres totales se han hecho de películas en ese idioma.
-- 67:  Para cada cliente, cuenta en cuántos meses distintos de 2005 realizó pagos (meses distintos).
-- 68:  Para cada categoría, calcula la duración media de las películas alquiladas (considerando solo películas alquiladas).
-- 69:  Para cada país, cuenta cuántos clientes hay (country -> city -> address -> customer).
-- 70:  Para cada país, suma los importes pagados por sus clientes.
-- 71:  Para cada tienda, cuenta cuántas categorías distintas existen en su inventario.
-- 72:  Para cada tienda, suma la recaudación por categoría (resultado agregado por tienda y categoría).
-- 73:  Para cada actor, cuenta en cuántas tiendas distintas se han alquilado sus películas.
-- 74:  Para cada categoría, cuenta cuántos clientes distintos han alquilado películas de esa categoría.
-- 75:  Para cada idioma, cuenta cuántos actores distintos participan en películas alquiladas en ese idioma.
-- 76:  Para cada país, cuenta cuántas tiendas hay (país->ciudad->address->store).
-- 77:  Para cada cliente, cuenta los alquileres en los que la devolución (return_date) fue el mismo día del alquiler.
-- 78:  Para cada tienda, cuenta cuántos clientes distintos realizaron pagos en 2005.
-- 79:  Para cada categoría, cuenta cuántas películas con título de longitud > 15 han sido alquiladas.
-- 80:  Para cada país, suma los pagos procesados por los empleados de las tiendas ubicadas en ese país.
-- ==============================================
-- SECCIÓN D) 20 CONSULTAS EXTRA (DIFICULTAD +), <=4 JOINS
-- ==============================================
-- 81:  Para cada cliente, muestra el total pagado con IVA teórico del 21% aplicado (total*1.21), redondeado a 2 decimales.
-- 82:  Para cada hora del día (0-23), cuenta cuántos alquileres se iniciaron en esa hora.
-- 83:  Para cada tienda, muestra la media de length de las películas alquiladas en 2005 y filtra las tiendas con media >= 100.
-- 84:  Para cada categoría, muestra la media de replacement_cost de las películas alquiladas un domingo.
-- 85:  Para cada empleado, muestra el importe total por pagos realizados entre las 00:00 y 06:00 (inclusive 00:00, exclusivo 06:00).
-- 86:  Para cada actor, cuenta cuántas de sus películas tienen un título que contiene la palabra 'LOVE' (mayúsculas).
-- 87:  Para cada idioma, muestra el total de pagos de alquileres de películas en ese idioma.
-- 88:  Para cada cliente, cuenta en cuántos días distintos de 2005 realizó algún alquiler.
-- 89:  Para cada categoría, calcula la longitud media de títulos (número de caracteres) de sus películas alquiladas.
-- 90:  Para cada tienda, cuenta cuántos clientes distintos alquilaron en el primer trimestre de 2006 (enero-marzo).
-- 91:  Para cada país, cuenta cuántas categorías diferentes han sido alquiladas por clientes residentes en ese país.
-- 92:  Para cada cliente, muestra el importe medio de sus pagos redondeado a 2 decimales, solo si ha hecho al menos 10 pagos.
-- 93:  Para cada categoría, muestra el número de películas con replacement_cost > 20 que hayan sido alquiladas al menos una vez.
-- 94:  Para cada tienda, suma los importes pagados en fines de semana.
-- 95:  Para cada actor, cuenta cuántas películas suyas fueron alquiladas por al menos 5 clientes distintos (se cuenta alquileres y luego se filtra por HAVING).
-- 96:  Para cada idioma, muestra el número de películas cuyo título empieza por la letra 'A' y que han sido alquiladas.
-- 97:  Para cada país, suma el importe total de pagos realizados por clientes residentes y filtra países con total >= 1000.
-- 98:  Para cada cliente, cuenta cuántos días han pasado entre su primer y su último alquiler en 2005 (diferencia de fechas), mostrando solo clientes con >= 5 alquileres en 2005.
--     (Se evita subconsulta calculando sobre el conjunto agrupado por cliente y usando MIN/MAX de rental_date en 2005).
-- 99:  Para cada tienda, muestra la media de importes cobrados por transacción en el año 2006, con dos decimales.
-- 100:  Para cada categoría, calcula la media de duración (length) de películas alquiladas en 2006 y ordénalas descendentemente por d