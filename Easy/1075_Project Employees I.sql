-- thought:
-- - we know the following:
--     - (project_id, employee_id) is a composite primary key, meaning each pair (project_id, employee_id) is unique.
--     - experience_years is NOT NULL, so we do not need to consider null values when calculating the average.
-- - our goal is to find the average experience_years for each project_id.
-- - therefore, we can follow these steps:
--     (1) use a `LEFT JOIN` to combine the two tables.
--     (2) use `GROUP BY project_id` and `AVG()` to calculate the average experience_years for each project_id.
--     (3) use `ROUND(,2)` to round the result to two decimal places.

WITH avg_years_by_project AS (
    SELECT p.project_id AS `project_id`, e.experience_years AS `experience_years`
    FROM Project AS p
    LEFT JOIN Employee AS e
    ON p.employee_id = e.employee_id
)

SELECT project_id, ROUND(AVG(experience_years),2) AS `average_years`
FROM avg_years_by_project
GROUP BY project_id;
