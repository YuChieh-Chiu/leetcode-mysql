-- thought:
-- - "visit_date is the column with unique values for this table" means `id` may duplicate
-- - we can do the following steps:
--         (1) use `ORDER BY visit_date` to sort the visit_date in ascending order
--         (2) use `id - LAG(id, 2)` to get the difference `id` in row i and `id` in row i-2
--         (3) also use `id - LEAD(id, 2)` to get the difference `id` in row i and `id` in row i+2 again to avoid the null value problem at the first two rows
--         (4) use `CASE WHEN ... THEN ... ELSE ... END AS ...` for (2) & (3) to check whether the records with three or more rows with consecutive id's exist or not
--         (5) use `WHERE` clause to filter people >= 100
-- - now we get the table with with rows that people >= 100, but we still miss ONE condition:
--         - the `second to last` row or the `second row may be ignored because the `lag_2` and the `lead_2` of it may both be "fail"
--         - so we need to create one more column to filter these rows and keep them in the answer
--         - we can use `CASE WHEN ... THEN ... ELSE ... END AS "middle"` with condition `(the last row or the next row of lag_2 = "pass") AND (the last row or the next row of lead_2 = "pass")
-- - finally, we select the column we need `WHERE lag_2 OR lead_2 OR middle = "pass`

WITH chang AS (
    SELECT *,
        CASE 
            WHEN id - LAG(id, 2) OVER(ORDER BY visit_date) = 2 THEN "pass"
            ElSE "fail"
        END AS "lag_2",
        CASE 
            WHEN LEAD(id, 2) OVER(ORDER BY visit_date) - id = 2 THEN "pass"
            ELSE "fail"
        END AS "lead_2"
    FROM Stadium
    WHERE people >= 100
    ORDER BY visit_date
)

SELECT o.id, o.visit_date, o.people
FROM (
    SELECT *,
        CASE
            WHEN (LAG(lag_2, 1) OVER(ORDER BY visit_date) = "pass" OR LEAD(lag_2, 1) OVER(ORDER BY visit_date) = "pass") 
                AND (LAG(lead_2, 1) OVER(ORDER BY visit_date) = "pass" OR LEAD(lead_2, 1) OVER(ORDER BY visit_date) = "pass")
            THEN "pass"
            ELSE "fail"
        END AS "middle"
    FROM chang
) AS o
WHERE o.lag_2 = "pass"
OR o.lead_2 = "pass"
OR o.middle = "pass";
