-- thought:
-- - Based on the problem descriptions, we understand that:
--     - `id` is the primary key for Employees, and `(id, unique_id)` is the primary key for EmployeeUNI, so we can merge the two tables on `id`.
-- - Our goal is to replace the employee's `id` with `unique_id`.
--     - Since `unique_id` can be NULL, a `LEFT JOIN` should be performed between Employees and EmployeeUNI.
-- - therefore, we can perform the following operation:
--     (1) `LEFT JOIN` Employees with EmployeeUNI.

SELECT u.unique_id, e.name
FROM Employees AS e
LEFT JOIN EmployeeUNI AS u
ON e.id = u.id;
