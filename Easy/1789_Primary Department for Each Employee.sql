-- Objective:
-- - List all employees with their primary department.
-- Information:
-- - Employees can belong to multiple departments.
-- - If an employee belongs to multiple departments, they will have a primary department where the `primary_flag` is equal to `Y`.
-- - If an employee belongs to only one department, the `primary_flag` column for them will be set to `N`.
-- Steps:
-- (1) Use `PARTITION BY` with `COUNT` to get the department count for each `employee_id`.
-- (2) Filter employees who belong to multiple departments by using `WHERE` with `primary_flag = 'Y'` and a department count greater than 1.
-- (3) For employees who belong to only one department, filter by using `WHERE` to find those with a department count equal to 1.
-- (4) Combine the results of steps (2) and (3) using `UNION`.

WITH add_col AS (
    SELECT *,
        COUNT(*) OVER(PARTITION BY employee_id) AS `dept_cnt`
    FROM Employee
)

(
    SELECT employee_id, department_id
    FROM add_col
    WHERE dept_cnt > 1
    AND primary_flag = 'Y'
)
UNION
(
    SELECT employee_id, department_id
    FROM add_col
    WHERE dept_cnt = 1
);
