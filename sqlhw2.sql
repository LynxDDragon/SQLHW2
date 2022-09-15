-- 1) List all customers who live in Texas (use Joins)
select first_name, last_name, address.district
from address
join customer
on address.address_id = customer.address_id 
group by first_name, last_name, address.district 
having district = 'Texas'


-- 2) Get all payments above $6.99 with the Customer's Full Name
select first_name, last_name, payment.amount 
from customer
join payment
on payment.customer_id = customer.customer_id 
group by payment.amount, customer.customer_id 
having payment.amount > 6.99


-- 3)Show all customers names who have made payments over $175 (use subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
    );
-- 4) List all customers that live in Nepal (use the city table)
   
select first_name, last_name
from customer
join address
on customer.address_id = address.address_id 
join city 
on address.city_id = city.city_id 
group by first_name, last_name, city.city_id 
having city.country_id = 66

-- 5) Which staff member had the most transactions?

SELECT staff_id, COUNT(rental_id)
FROM rental
GROUP BY staff_id 
ORDER BY count DESC
LIMIT 1;

-- 6) How many movies of each rating are there?
select distinct rating, count(film_id)
from film
group by rating
order by count desc



-- 7) Show all customers who have made a single payment above $6.99
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer.customer_id 
    FROM customer 
    JOIN payment 
    ON payment.customer_id = customer.customer_id
    GROUP BY customer.customer_id, payment.amount
    HAVING COUNT(payment_id) = 1 AND amount > 6.99
);

-- 8) How many free rentals did our stores give away?
select count(rental_id)
from payment
where amount = 0
