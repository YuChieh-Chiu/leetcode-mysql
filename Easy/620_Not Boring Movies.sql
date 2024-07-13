-- thought:
-- - use `CASE WHEN ... THEN ... ELSE ... END AS `odd`` to get the odd-numbered ID
-- - use `WHERE description <> 'boring'` to get the not boring movie
-- - use `ORDER BY rating DESC` to sort rating in descending order

WITH oddNum AS (
    SELECT *,
        CASE
            WHEN id%2=0 THEN "even"
            ELSE "odd"
        END AS `odd`
    FROM Cinema
)

SELECT id, movie, description, rating
FROM oddNum
WHERE description <> "boring"
AND odd = "odd"
ORDER BY rating DESC;
