-- thought:
-- - we need to `LEFT JOIN` two tables employee and department
-- - we should do the following steps to get the top3 unique salary in each department:
--     (1) `DISTINCT` department name and salary
--     (2) use `PARTITION BY` department name to sort and get top3 in group
--     (3) `ORDER BY` salary in `DESC` order
--     (4) get the `top3` unique salary in each department by `row_number <= 3`
-- - `LEFT JOIN` back top3 dataframe with employee dataframe to get the employee name
-- - use `AS` to name columns to get correct column names

WITH top3 AS (
    SELECT DISTINCT d.id AS "id", d.name AS "Department", e.salary AS "Salary"
    FROM Employee AS e
    LEFT JOIN Department AS d
    ON e.departmentId = d.id
    ORDER BY e.salary DESC
)

SELECT t.Department, e.name AS "Employee", t.Salary
FROM (
    SELECT *, 
        ROW_NUMBER() OVER(PARTITION BY t.Department ORDER BY t.Salary DESC) AS "row_number"
    FROM top3 AS t
) AS t
LEFT JOIN Employee AS e
ON t.id = e.departmentId
AND t.Salary = e.salary
WHERE t.row_number <= 3;
