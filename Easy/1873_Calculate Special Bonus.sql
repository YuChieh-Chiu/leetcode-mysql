-- Objective:
-- - Calculate the bonus for each employee based on the conditions below and return the results ordered by employee_id.
-- Conditions:
-- - The bonus will be 100% of the employee's salary if all the following conditions are met:
--     (1) employee_id is an odd number
--     (2) the name does not start with 'M'
-- - If the conditions are not met, the bonus will be 0.
-- Steps:
-- (1) Use `CASE WHEN ... THEN ... ELSE ... END` to implement the logic for calculating the bonus.
-- (2) Use `ORDER BY employee_id` to sort the result table in ascending order.

SELECT employee_id,
    CASE 
        WHEN (employee_id % 2 = 1) AND (name NOT LIKE 'M%') THEN salary
        ELSE 0
    END AS `bonus`
FROM Employees
ORDER BY employee_id;
