-- Objective:
-- - Find the ids and names of all managers, along with the number of employees directly reporting to them and the average age of their reports, rounded to the nearest integer
-- - Return the result sorted by `employee_id`
-- Information:
-- - An employee is considered a manager only if they have at least one other employee reporting to them
-- Steps:
-- (1) Since there are NULL values in the `reports_to` column, we need to use `WHERE` to filter them out
-- (2) Since the `reports_to` column indicates managers, we should `GROUP BY` it
-- (3) Use `COUNT()` on `employee_id` to get the number of employees who directly report to each manager
--     - Note that `employee_id` is unique in the Employees table, so no deduplication is necessary
-- (4) Use `ROUND(AVG(), 0)` to calculate the average age of employees reporting directly to each manager
-- (5) `LEFT JOIN` the generated table with the Employees table on the `reports_to` and `employee_id` columns to retrieve the managers' names
-- (6) Use `ORDER BY` to sort the result by employee_id in ascending order 

WITH managers AS (
    SELECT reports_to, 
        COUNT(employee_id) AS `reports_count`,
        ROUND(AVG(age),0) AS `average_age`
    FROM Employees
    WHERE reports_to IS NOT NULL
    GROUP BY reports_to
)

SELECT m.reports_to AS `employee_id`,
    e.name, m.reports_count, m.average_age
FROM managers AS m
LEFT JOIN Employees AS e
ON m.reports_to = e.employee_id
ORDER BY m.reports_to ASC;
