

BEGIN;

INSERT INTO film (title, description, release_year, language_id,
                  rental_duration, rental_rate, length, rating, last_update)
SELECT 'Inception',
       'A thief who steals corporate secrets through dream-sharing technology '
       'is given the task of planting an idea into the mind of a C.E.O.',
       2010,
       (SELECT language_id FROM language WHERE lower(name) = 'english'),
       7, 4.99, 148, 'PG-13'::mpaa_rating, CURRENT_DATE
WHERE NOT EXISTS (SELECT 1 FROM film WHERE title = 'Inception' AND release_year = 2010);

INSERT INTO film (title, description, release_year, language_id,
                  rental_duration, rental_rate, length, rating, last_update)
SELECT 'The Dark Knight',
       'When the Joker wreaks havoc on Gotham, Batman must accept '
       'the greatest psychological and physical test of his ability to fight injustice.',
       2008,
       (SELECT language_id FROM language WHERE lower(name) = 'english'),
       14, 9.99, 152, 'PG-13'::mpaa_rating, CURRENT_DATE
WHERE NOT EXISTS (SELECT 1 FROM film WHERE title = 'The Dark Knight' AND release_year = 2008);

INSERT INTO film (title, description, release_year, language_id,
                  rental_duration, rental_rate, length, rating, last_update)
SELECT 'Interstellar',
       'A team of explorers travel through a wormhole in space '
       'in an attempt to ensure humanity''s survival.',
       2014,
       (SELECT language_id FROM language WHERE lower(name) = 'english'),
       21, 19.99, 169, 'PG-13'::mpaa_rating, CURRENT_DATE
WHERE NOT EXISTS (SELECT 1 FROM film WHERE title = 'Interstellar' AND release_year = 2014);


INSERT INTO actor (first_name, last_name, last_update)
SELECT 'Leonardo', 'DiCaprio', CURRENT_DATE
WHERE NOT EXISTS (SELECT 1 FROM actor WHERE first_name = 'Leonardo' AND last_name = 'DiCaprio');

INSERT INTO actor (first_name, last_name, last_update)
SELECT 'Joseph', 'Gordon-Levitt', CURRENT_DATE
WHERE NOT EXISTS (SELECT 1 FROM actor WHERE first_name = 'Joseph' AND last_name = 'Gordon-Levitt');

INSERT INTO actor (first_name, last_name, last_update)
SELECT 'Christian', 'Bale', CURRENT_DATE
WHERE NOT EXISTS (SELECT 1 FROM actor WHERE first_name = 'Christian' AND last_name = 'Bale');

INSERT INTO actor (first_name, last_name, last_update)
SELECT 'Heath', 'Ledger', CURRENT_DATE
WHERE NOT EXISTS (SELECT 1 FROM actor WHERE first_name = 'Heath' AND last_name = 'Ledger');

INSERT INTO actor (first_name, last_name, last_update)
SELECT 'Matthew', 'McConaughey', CURRENT_DATE
WHERE NOT EXISTS (SELECT 1 FROM actor WHERE first_name = 'Matthew' AND last_name = 'McConaughey');

INSERT INTO actor (first_name, last_name, last_update)
SELECT 'Anne', 'Hathaway', CURRENT_DATE
WHERE NOT EXISTS (SELECT 1 FROM actor WHERE first_name = 'Anne' AND last_name = 'Hathaway');

INSERT INTO actor (first_name, last_name, last_update)
SELECT 'Jessica', 'Chastain', CURRENT_DATE
WHERE NOT EXISTS (SELECT 1 FROM actor WHERE first_name = 'Jessica' AND last_name = 'Chastain');

-- film_actor has a composite PK (actor_id, film_id) so ON CONFLICT DO NOTHING
-- basically just says "if this pair already exists, skip it, don't throw an error"
INSERT INTO film_actor (actor_id, film_id, last_update)
SELECT
    (SELECT actor_id FROM actor WHERE first_name = 'Leonardo' AND last_name = 'DiCaprio'),
    (SELECT film_id FROM film WHERE title = 'Inception' AND release_year = 2010),
    CURRENT_DATE
ON CONFLICT DO NOTHING;

INSERT INTO film_actor (actor_id, film_id, last_update)
SELECT
    (SELECT actor_id FROM actor WHERE first_name = 'Joseph' AND last_name = 'Gordon-Levitt'),
    (SELECT film_id FROM film WHERE title = 'Inception' AND release_year = 2010),
    CURRENT_DATE
ON CONFLICT DO NOTHING;

INSERT INTO film_actor (actor_id, film_id, last_update)
SELECT
    (SELECT actor_id FROM actor WHERE first_name = 'Christian' AND last_name = 'Bale'),
    (SELECT film_id FROM film WHERE title = 'The Dark Knight' AND release_year = 2008),
    CURRENT_DATE
ON CONFLICT DO NOTHING;

INSERT INTO film_actor (actor_id, film_id, last_update)
SELECT
    (SELECT actor_id FROM actor WHERE first_name = 'Heath' AND last_name = 'Ledger'),
    (SELECT film_id FROM film WHERE title = 'The Dark Knight' AND release_year = 2008),
    CURRENT_DATE
ON CONFLICT DO NOTHING;

INSERT INTO film_actor (actor_id, film_id, last_update)
SELECT
    (SELECT actor_id FROM actor WHERE first_name = 'Matthew' AND last_name = 'McConaughey'),
    (SELECT film_id FROM film WHERE title = 'Interstellar' AND release_year = 2014),
    CURRENT_DATE
ON CONFLICT DO NOTHING;

INSERT INTO film_actor (actor_id, film_id, last_update)
SELECT
    (SELECT actor_id FROM actor WHERE first_name = 'Anne' AND last_name = 'Hathaway'),
    (SELECT film_id FROM film WHERE title = 'Interstellar' AND release_year = 2014),
    CURRENT_DATE
ON CONFLICT DO NOTHING;

INSERT INTO film_actor (actor_id, film_id, last_update)
SELECT
    (SELECT actor_id FROM actor WHERE first_name = 'Jessica' AND last_name = 'Chastain'),
    (SELECT film_id FROM film WHERE title = 'Interstellar' AND release_year = 2014),
    CURRENT_DATE
ON CONFLICT DO NOTHING;


INSERT INTO inventory (film_id, store_id, last_update)
SELECT
    (SELECT film_id FROM film WHERE title = 'Inception' AND release_year = 2010),
    (SELECT store_id FROM store ORDER BY store_id LIMIT 1),
    CURRENT_DATE
WHERE NOT EXISTS (
    SELECT 1 FROM inventory
    WHERE film_id  = (SELECT film_id FROM film WHERE title = 'Inception' AND release_year = 2010)
      AND store_id = (SELECT store_id FROM store ORDER BY store_id LIMIT 1)
);

INSERT INTO inventory (film_id, store_id, last_update)
SELECT
    (SELECT film_id FROM film WHERE title = 'The Dark Knight' AND release_year = 2008),
    (SELECT store_id FROM store ORDER BY store_id LIMIT 1),
    CURRENT_DATE
WHERE NOT EXISTS (
    SELECT 1 FROM inventory
    WHERE film_id  = (SELECT film_id FROM film WHERE title = 'The Dark Knight' AND release_year = 2008)
      AND store_id = (SELECT store_id FROM store ORDER BY store_id LIMIT 1)
);

INSERT INTO inventory (film_id, store_id, last_update)
SELECT
    (SELECT film_id FROM film WHERE title = 'Interstellar' AND release_year = 2014),
    (SELECT store_id FROM store ORDER BY store_id LIMIT 1),
    CURRENT_DATE
WHERE NOT EXISTS (
    SELECT 1 FROM inventory
    WHERE film_id  = (SELECT film_id FROM film WHERE title = 'Interstellar' AND release_year = 2014)
      AND store_id = (SELECT store_id FROM store ORDER BY store_id LIMIT 1)
);


-- picking the customer with the most rentals/payments who has at least 43 of each
UPDATE customer
SET first_name  = 'AKHAD',
    last_name   = 'TEMIR',
    email       = 'atemir23@apec.edu.kz',
    address_id  = (SELECT address_id FROM address ORDER BY address_id LIMIT 1),
    last_update = CURRENT_DATE
WHERE customer_id = (
    SELECT c.customer_id
    FROM customer c
    JOIN rental  r ON c.customer_id = r.customer_id
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
    HAVING COUNT(DISTINCT r.rental_id)  >= 43
       AND COUNT(DISTINCT p.payment_id) >= 43
    ORDER BY COUNT(DISTINCT r.rental_id) DESC
    LIMIT 1
);


SELECT * FROM payment
WHERE customer_id = (
    SELECT customer_id FROM customer
    WHERE first_name = 'YOUR_FIRST_NAME' AND last_name = 'YOUR_LAST_NAME'
);

DELETE FROM payment
WHERE customer_id = (
    SELECT customer_id FROM customer
    WHERE first_name = 'YOUR_FIRST_NAME' AND last_name = 'YOUR_LAST_NAME'
);

SELECT * FROM rental
WHERE customer_id = (
    SELECT customer_id FROM customer
    WHERE first_name = 'YOUR_FIRST_NAME' AND last_name = 'YOUR_LAST_NAME'
);

DELETE FROM rental
WHERE customer_id = (
    SELECT customer_id FROM customer
    WHERE first_name = 'YOUR_FIRST_NAME' AND last_name = 'YOUR_LAST_NAME'
);


-- using RETURNING here to grab the rental_id right away and pass it into payment
WITH new_rental AS (
    INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
    VALUES (
        '2017-01-15 10:00:00'::timestamp,
        (SELECT i.inventory_id FROM inventory i
         WHERE i.film_id  = (SELECT film_id FROM film WHERE title = 'Inception' AND release_year = 2010)
           AND i.store_id = (SELECT store_id FROM store ORDER BY store_id LIMIT 1)
         ORDER BY i.inventory_id LIMIT 1),
        (SELECT customer_id FROM customer
         WHERE first_name = 'YOUR_FIRST_NAME' AND last_name = 'YOUR_LAST_NAME'),
        '2017-01-15 10:00:00'::timestamp
            + (SELECT rental_duration FROM film WHERE title = 'Inception' AND release_year = 2010)
            * INTERVAL '1 day',
        (SELECT staff_id FROM staff ORDER BY staff_id LIMIT 1),
        CURRENT_DATE
    )
    RETURNING rental_id
)
INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
SELECT
    (SELECT customer_id FROM customer WHERE first_name = 'YOUR_FIRST_NAME' AND last_name = 'YOUR_LAST_NAME'),
    (SELECT staff_id FROM staff ORDER BY staff_id LIMIT 1),
    rental_id,
    (SELECT rental_rate FROM film WHERE title = 'Inception' AND release_year = 2010),
    '2017-01-15 10:00:00'::timestamp
FROM new_rental;

WITH new_rental AS (
    INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
    VALUES (
        '2017-02-10 14:00:00'::timestamp,
        (SELECT i.inventory_id FROM inventory i
         WHERE i.film_id  = (SELECT film_id FROM film WHERE title = 'The Dark Knight' AND release_year = 2008)
           AND i.store_id = (SELECT store_id FROM store ORDER BY store_id LIMIT 1)
         ORDER BY i.inventory_id LIMIT 1),
        (SELECT customer_id FROM customer
         WHERE first_name = 'YOUR_FIRST_NAME' AND last_name = 'YOUR_LAST_NAME'),
        '2017-02-10 14:00:00'::timestamp
            + (SELECT rental_duration FROM film WHERE title = 'The Dark Knight' AND release_year = 2008)
            * INTERVAL '1 day',
        (SELECT staff_id FROM staff ORDER BY staff_id LIMIT 1),
        CURRENT_DATE
    )
    RETURNING rental_id
)
INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
SELECT
    (SELECT customer_id FROM customer WHERE first_name = 'YOUR_FIRST_NAME' AND last_name = 'YOUR_LAST_NAME'),
    (SELECT staff_id FROM staff ORDER BY staff_id LIMIT 1),
    rental_id,
    (SELECT rental_rate FROM film WHERE title = 'The Dark Knight' AND release_year = 2008),
    '2017-02-10 14:00:00'::timestamp
FROM new_rental;

WITH new_rental AS (
    INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
    VALUES (
        '2017-03-20 09:00:00'::timestamp,
        (SELECT i.inventory_id FROM inventory i
         WHERE i.film_id  = (SELECT film_id FROM film WHERE title = 'Interstellar' AND release_year = 2014)
           AND i.store_id = (SELECT store_id FROM store ORDER BY store_id LIMIT 1)
         ORDER BY i.inventory_id LIMIT 1),
        (SELECT customer_id FROM customer
         WHERE first_name = 'YOUR_FIRST_NAME' AND last_name = 'YOUR_LAST_NAME'),
        '2017-03-20 09:00:00'::timestamp
            + (SELECT rental_duration FROM film WHERE title = 'Interstellar' AND release_year = 2014)
            * INTERVAL '1 day',
        (SELECT staff_id FROM staff ORDER BY staff_id LIMIT 1),
        CURRENT_DATE
    )
    RETURNING rental_id
)
INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
SELECT
    (SELECT customer_id FROM customer WHERE first_name = 'YOUR_FIRST_NAME' AND last_name = 'YOUR_LAST_NAME'),
    (SELECT staff_id FROM staff ORDER BY staff_id LIMIT 1),
    rental_id,
    (SELECT rental_rate FROM film WHERE title = 'Interstellar' AND release_year = 2014),
    '2017-03-20 09:00:00'::timestamp
FROM new_rental;


COMMIT;