-- thought:
-- - our goal is to find `actor_id, director_id` pairs that have collaborated more than three times.
-- - therefore, we can follow these steps:
--     (1) use `GROUP BY` to group by the `actor_id, director_id` pairs.
--     (2) use `HAVING COUNT(timestamp) >= 3` to check if the number of collaborations is greater than or equal to three.

SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(timestamp) >= 3;
