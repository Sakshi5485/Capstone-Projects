use sakila;

---------------------------------------------------------------------------------------------------------------------------------------------
# TASK - 1
# Display the full name of actors availabe in database.

select * from actor;
select concat(first_name,"_", last_name) as Full_name from actor;

---------------------------------------------------------------------------------------------------------------------------------------------

# TASK - 2
# Management wants to knoe if there are any names of actors appearing frequently.

-- i) Display the number of times each first name appears in the Database.

select first_name,count(first_name) as first_name_cnt from actor group by first_name;

-- ii) What is the count of actors that have unique first name in the Database? Display the first names of all these actors.

select first_name, count(first_name) as name_count from actor group by first_name having count(first_name) = 1;

-------------------------------------------------------------------------------------------------------------------------------------------

# TASK - 3
# The management is interested to analyze the similarity in the last names of the actors.

-- i) Display the number of times each last name appears in the Database.

select last_name, count(last_name) as last_name_cnt from actor group by last_name;

-- ii) Display the all unique last names in the database.

select last_name, count(last_name) as name_count from actor group by last_name having count(last_name) = 1;

---------------------------------------------------------------------------------------------------------------------------------------------

# TASK - 4
# The management wants to analyze the movies based on their rating to determine if they are suitable for kids or osome parantel assiatance 
# is requried. Perform the following tasks to perform the required analysis.

-- i) Display the list of records for the movies with the Rating "R".
-- (The movies with the rating "R" are not suitable for audience under 17 years of age)

select * from film;

select * from film where rating = "R";

-- ii) Display the list of records for the movies that are not rated "R".

select * from film where rating != "R";

-- iii) Display the list of records for the movies that are suitable for audience below 13 years of age.

select * from film where rating = "PG-13";

--------------------------------------------------------------------------------------------------------------------------------------------

# TASK - 5

# The board members want to understand the replacement cost of the movie copy(disc-DVD/Blue Ray). The replacement cost refers to 
# the amount charge to customer if the movie disc is no returned or is returned in a damage state.

-- i) Display the list of records for the movies where replacement cost is up to $11.

select * from film where replacement_cost <= 11;

-- ii) Display the list of records for the movies where the replacement cost is between $11 and $20.

select * from film where replacement_cost between 11 and 20;

-- iii) Display the list of records for the all movies in desending order of their replacement costs.

select * from film order by replacement_cost desc;

---------------------------------------------------------------------------------------------------------------------------------------------

# TASK - 6
# Display the top 3 movies with the greatest number of actors.

select * from film;
select * from film_actor;

select film.title, count(film_actor.actor_id) as actor_count from film join 
film_actor on film.film_id = film_actor.film_id 
group by film.title order by actor_count desc limit 3;

----------------------------------------------------------------------------------------------------------------------------------------------

# TASK - 7
#  "Music of Queen" and "Kris Kristofferson" have seen an unlikely resurgence. As an unintended consequence, films starting with the letters
# "K" and "Q" have also soared in popularity. Display the titles of the movies starting with the letters "K" and "Q".

select title from film where title like "K%" or title like "Q%"; 

---------------------------------------------------------------------------------------------------------------------------------------------

# TASK - 8
# The film "Agent Truman" has been greate success. Display the name of all actors who appeared in this film.

select * from actor;
select * from film;

select concat(actor.first_name,"_", actor.last_name) as actor_name from actor join
film_actor on actor.actor_id = film_actor.actor_id join
film on film.film_id = film_actor.film_id 
where film.title = "Agent Truman";

----------------------------------------------------------------------------------------------------------------------------------------------

# TASK - 9
# Sales have been lagging among young families, so the management wants to promote family movies. Identify all the movies categorized 
# as family films.

select * from film;
select * from film_category;
select * from category;

select film.film_id, film.title, category.name from film join
film_category on film.film_id = film_category.film_id join
category on category.category_id = film_category.category_id
where category.name = "family";

--------------------------------------------------------------------------------------------------------------------------------------------

# TASK - 10
# The management wants to observe the rental and rental frequencies (Number of times the movie disc is rented)

-- i) Display the maximum, minimum and average renatal rates of the movies based on their ratings the output must be sorted in descending 
-- order of the average rental rates.

select * from film;

select rating, min(rental_rate), max(rental_rate), avg(rental_rate) from film group by rating order by avg(rental_rate);

-- ii) Display the movies in descending order of their rental frequencies, so the management can maintain more copies of those movies.

select * from film;
select * from inventory;
select * from rental;

select film.title, count(rental.rental_id) as rental_frequency from film join
inventory on inventory.film_id = film.film_id join
rental on rental.inventory_id = inventory.inventory_id group by film.title order by rental_frequency desc;

--------------------------------------------------------------------------------------------------------------------------------------------

# TASK - 11
# In how many film categories, the difference between the average film replacement cost ((disc- DVD/Blue Ray) and the average film 
# rental rate is greater than $15 ?

-- Display the list of all the film categories identified above, along with the corresponding average film replacement cost and 
-- average film rental rate.

select * from film;
select * from category;

select category.name, avg(film.replacement_cost) as avg_replacement_cost,avg(film.rental_rate) as avg_rental_rate, 
(avg(film.replacement_cost) - avg(film.rental_rate)) as difference from film
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
group by category.name
having difference > 15;

---------------------------------------------------------------------------------------------------------------------------------------------

# TASK - 12
# Display the film categories in which the number of movies is greater than 70.

select * from film;
select * from category;
select * from film_category;

select category.name, count(film.title) as number_of_movies from category 
join film_category on category.category_id = film_category.category_id
join film on film.film_id = film_category.film_id
group by category.name having number_of_movies > 70;

-------------------------------------------------------------------------------------------------------------------------------------------
