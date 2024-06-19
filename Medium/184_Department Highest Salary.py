-- thought:
-- - Note that `Department name` is guaranteed not null
-- - (1) we should get the highest value in each group
        -- - use subquery in `from` clause AS `em`
-- - (2) we should left join two tables, `Employee` and `Department` AS `ed`
-- - (3) we should left join `em` with `ed` to get row with the highest salary of each group
-- - (4) we should only ouput table with `Department`, `Employee`, and `Salary`
SELECT ed.Department, ed.Employee, ed.Salary
FROM (
    SELECT e.departmentId, MAX(e.salary) AS "Salary"
    FROM Employee AS e
    GROUP BY e.departmentId
) AS em
LEFT JOIN (
    SELECT e.name AS "Employee", e.salary AS "Salary", e.departmentId, d.name AS "Department"
    FROM Employee AS e
    LEFT JOIN Department AS d
    ON e.departmentId = d.id
) AS ed
ON em.departmentId = ed.departmentId 
AND em.Salary = ed.Salary
