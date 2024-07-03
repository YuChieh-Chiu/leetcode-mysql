-- thought:
-- - note that the `managerId` column follows the RULE below
--     (1) if managerId is null, then the employee does not have a manager
--     (2) no employee will be the manager of themself
-- - we can do the steps as below
--     (1) use `GROUP BY managerId` and `HAVING COUNT() >= 5` to get the number of each managerId and then filter out managerIds that appear at least five times
--     (2) use `WHERE` clause to filter ids in the result of (1)
--     (3) `SELECT` name only

SELECT name
FROM Employee
WHERE id IN (
    SELECT managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(managerId) >= 5
);
