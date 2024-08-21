-- thought:
-- - our goal is to calculate the total traveled distance for each user and then sort them by this distance in descending order. If two or more users have traveled the same distance, they should be sorted by their name in ascending order.
-- - note that if a user hasn't traveled, their traveled distance should be recorded as 0.
-- - therefore, we can follow these steps:
--     (1) use `GROUP BY` on user_id and `SUM` the distance to get the total traveled distance for each user.
--     (2) perform a `LEFT JOIN` on the Users table with the Rides table.
--     (3) use `CASE WHEN ... THEN ... ELSE ... END AS ...` to convert NULL traveled distances to 0.
--     (4) `ORDER BY` the total traveled distance in descending order, and `ORDER BY` the name in ascending order.

WITH total_distance AS (
    SELECT user_id, SUM(distance) AS `travelled_distance`
    FROM Rides
    GROUP BY user_id
)

SELECT u.name, 
    CASE
        WHEN t.travelled_distance IS NULL THEN 0
        ELSE t.travelled_distance
    END AS `travelled_distance`
FROM Users AS u
LEFT JOIN total_distance AS t
ON u.id = t.user_id
ORDER BY t.travelled_distance DESC, u.name ASC;
