-- thought:
-- - `LEFT JOIN` table itself 
    -- - use `LEFT JOIN` because `managerId` may be Null
-- - compare `employee_salary` & `manager_salary`
-- - columns filter and rename `AS "Employee"`

SELECT e1.name AS "Employee"
FROM Employee AS e1
LEFT JOIN Employee As e2
ON e1.managerId = e2.id
WHERE e1.salary > e2.salary;
