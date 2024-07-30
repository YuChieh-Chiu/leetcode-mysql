-- thought：
-- - our goal is to find the last person who can board the bus
-- - there is some information about people in queue and boarding limit：
--     (1) people in queue should board in ascending order of `turn`
--     (2) the bus weight limit is `1000` kilograms
-- - therefore, we can follow these steps：
--     (1) use `ORDER BY` to sort the table by `turn` in ascending order
--     (2) use `SUM() OVER(ORDER BY ...)` to calculate the cumulative weights for each row
--     (3) use `WHERE` and `ORDER BY ... DESC` and `LIMIT 1` to get the LAST person who can fit in the bus

WITH cumulative AS (
    SELECT person_name,
        SUM(weight) OVER(ORDER BY turn) AS `cum_weight`
    FROM Queue
    ORDER BY turn
)

SELECT person_name
FROM cumulative
WHERE cum_weight <= 1000
ORDER BY cum_weight DESC
LIMIT 1;
