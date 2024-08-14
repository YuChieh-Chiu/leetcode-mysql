-- thought:
-- - our goal is to find the following two values:
--     1. the name of the user who has rated the greatest number of movies.
--     2. the movie title with the highest average rating in February 2020.
--     - in case of a tie, return the lexicographically smaller user name or movie title.
-- - to achieve this, we need to merge the `MovieRating` table with the `Users` and `Movies` tables, calculate the number of ratings per user and the average rating per movie, then sort the results and select the required values.
-- - the steps are as follows:
--     (1) use `COUNT()` with `GROUP BY` to find the number of ratings for each user_id.
--     (2) use `ORDER BY ... DESC` and `LIMIT 1` to find the user with the greatest number of ratings.
--     (3) use `AVG()` with `GROUP BY` and `WHERE ... AND ...` to calculate the average rating for each movie_id in February 2020.
--     (4) use `ORDER BY ... DESC` and `LIMIT 1` to find the movie with the highest average rating.
--     (5) `LEFT JOIN` the result of step (1) with the `Users` table.
--     (6) Use `WHERE ... = (sub_query)` to filter users with the greatest number of ratings.
--     (7) `ORDER BY` the user name and use `LIMIT 1` to select the lexicographically smallest name.
--     (8) `LEFT JOIN` the result of step (3) with the `Movies` table.
--     (9) use `WHERE ... = (sub_query)` to filter movies with the highest average rating.
--     (10) `ORDER BY` the movie title and use `LIMIT 1` to select the lexicographically smallest title.
--     (11) `UNION ALL` the results of steps (7) and (10) to obtain the final answer.

WITH greatest_times_of_rating AS (
    SELECT user_id, COUNT(rating) AS `times`
    FROM MovieRating
    GROUP BY user_id
    ORDER BY `times` DESC
    LIMIT 1
), highest_avg_rating AS (
    SELECT movie_id, AVG(rating) AS `avg_rating`
    FROM MovieRating
    WHERE created_at >= '2020-02-01'
      AND created_at < '2020-03-01'
    GROUP BY movie_id
    ORDER BY `avg_rating` DESC
    LIMIT 1
), top_user AS (
    SELECT u.name AS `results`
    FROM (
        SELECT user_id, COUNT(rating) AS `times`
        FROM MovieRating
        GROUP BY user_id
    ) AS mr
    LEFT JOIN Users AS u
    ON mr.user_id = u.user_id
    WHERE mr.times = (
        SELECT times 
        FROM greatest_times_of_rating
    )
    ORDER BY u.name
    LIMIT 1
), top_movie AS (
    SELECT m.title AS `results`
    FROM (
        SELECT movie_id, AVG(rating) AS `avg_rating`
        FROM MovieRating
        WHERE created_at >= '2020-02-01'
        AND created_at < '2020-03-01'
        GROUP BY movie_id
    ) AS mr
    LEFT JOIN Movies AS m
    ON mr.movie_id = m.movie_id
    WHERE mr.avg_rating = (
        SELECT avg_rating 
        FROM highest_avg_rating
    )
    ORDER BY m.title
    LIMIT 1
)

SELECT *
FROM top_user
UNION ALL
SELECT *
FROM top_movie;
