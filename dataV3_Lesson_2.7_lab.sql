-- Lab | SQL Join (Part I)
-- In this lab, you will be using the Sakila database of movie rentals.

-- Instructions
-- 1 How many films are there for each of the categories in the category table. Use appropriate 
-- join to write this query.

USE SAKILA;

SELECT *
FROM sakila.film;

SELECT *
FROM sakila.film_category;

SELECT c.category_id, COUNT(title) as title_total
FROM sakila.film_category as c
JOIN sakila.film as f
ON f.film_id = c.film_id
GROUP BY c.category_id
ORDER BY c.category_id ASC;

-- 2 Display the total amount rung up by each staff member in August of 2005.

SELECT *
FROM sakila.payment;
SELECT *
FROM sakila.staff;

SELECT staff_id, SUM(amount) AS 'rung_up_amount', DATE_FORMAT(payment_date, '%M %Y') AS 'month_and_year'
FROM payment
WHERE EXTRACT(YEAR FROM payment_date) = 2005
AND EXTRACT(MONTH FROM payment_date) = 8
GROUP BY staff_id;

-- 3 Which actor has appeared in the most films?
SELECT* FROM sakila.actor;
SELECT* FROM sakila.film_actor; 

SELECT ac.actor_id, ac.first_name, ac.last_name, COUNT(fa.actor_id) AS 'film_count'
FROM sakila.actor AS ac
JOIN sakila.film_actor AS fa
ON ac.actor_id = fa.actor_id
GROUP BY ac.actor_id, ac.first_name, ac.last_name
ORDER BY film_count DESC
LIMIT 1;

-- 4. Most active customer (the customer that has rented the most number of films)

SELECT* FROM sakila.customer;
SELECT*FROM sakila.rental;

SELECT first_name, last_name, COUNT(rental_id) AS 'customer that has rented the most number of films'
FROM sakila.customer AS c
JOIN sakila.rental AS r
ON c.customer_id = r.customer_id
GROUP BY first_name, last_name
ORDER BY 'customer that has rented the most number of films' DESC
LIMIT 1;

-- 5.Display the first and last names, as well as the address, of each staff member.

SELECT* FROM sakila.staff;
SELECT* FROM sakila.address;

SELECT st.first_name, st.last_name, ad.address
FROM sakila.staff AS st
JOIN sakila.address AS ad
ON st.address_id = ad.address_id
GROUP BY st.first_name, st.last_name, ad.address
ORDER BY 'staff_adress_first_and_last_name' DESC;

-- 6. List each film and the number of actors who are listed for that film.
SELECT* FROM sakila.film;
SELECT* FROM sakila.film_actor;

SELECT f.film_id, title, COUNT(DISTINCT actor_id) AS 'List_of_actors_for_each_film'
FROM sakila.film AS f
JOIN sakila.film_actor AS fa
ON f.film_id = fa.film_id
GROUP BY f.title, fa.film_id
ORDER BY 'List_of_actors_for_each_film';

-- 7 Using the tables payment and customer and the JOIN command, 
-- list the total paid by each customer. List the customers alphabetically by last name.

SELECT* FROM sakila.payment;
SELECT* FROM sakila.customer;

SELECT c.last_name, SUM(p.amount) AS 'total_amount_paid'
FROM sakila.payment AS p
JOIN sakila.customer AS c
ON p.customer_id = c.customer_id
GROUP BY c.last_name
ORDER BY c.last_name;

-- 8. List the titles of films per category.

SELECT* FROM sakila.film;
SELECT* FROM sakila.film_category;

SELECT c.name AS category, GROUP_CONCAT(f.title) AS film_titles
FROM sakila.film_category AS fc
JOIN sakila.category AS c ON fc.category_id = c.category_id
JOIN sakila.film AS f ON fc.film_id = f.film_id
GROUP BY c.name;


