-- Lab 3.1 Multiple Joins --

-- In this lab, you will be using the Sakila database of movie rentals.
use sakila;

-- 1 Write a query to display for each store its store ID, city, and country.
select s.store_id, c.city, co.country
from store as s
join address as a
on s.address_id = a.address_id
join city as c
on a.city_id = c.city_id
join country as co
on c.country_id = co.country_id;

-- 2 Write a query to display how much business, in dollars, each store brought in.
select s.store_id, sum(p.amount) as transaction_volume
from store as s
join customer as c
on s.store_id = c.store_id
join payment as p
on c.customer_id = p.customer_id
group by s.store_id;

-- 3 What is the average running time of films by category?
select c.name, round(avg(f.length), 2) as average_running_time
from category as c
join film_category as fc
on c.category_id = fc.category_id
join film as f
on fc.film_id = f.film_id
group by c.category_id;

-- 4 Which film categories are longest?
select c.name, round(avg(f.length), 2) as average_running_time
from category as c
join film_category as fc
on c.category_id = fc.category_id
join film as f
on fc.film_id = f.film_id
group by c.category_id
order by average_running_time desc
limit 5;

-- 5 Display the most frequently rented movies in descending order.
select f.title, count(r.rental_id) as rentals
from rental as r
join inventory as i
on r.inventory_id = i.inventory_id
join film as f
on i.film_id = f.film_id
group by f.title
order by rentals desc
limit 10;

-- 6 List the top five genres in gross revenue in descending order.
select c.name, sum(p.amount) as gross_revenue
from payment as p
join rental as r
on p.rental_id = r.rental_id
join inventory as i
on r.inventory_id = i.inventory_id
join film_category as fc
on i.film_id = fc.film_id
join category as c
on fc.category_id = c.category_id
group by c.name
order by gross_revenue desc
limit 5;

-- 7 Is "Academy Dinosaur" available for rent from Store 1?
select s.store_id, count(f.film_id) nr_of_available_films, f.title
from store as s
join inventory as i
on s.store_id = i.store_id
join film as f
on i.film_id = f.film_id
where s.store_id = '1' and f.title = 'Academy Dinosaur';
#yes, the film is available 4 times in store 1