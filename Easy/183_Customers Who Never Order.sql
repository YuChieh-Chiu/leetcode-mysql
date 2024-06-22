-- thought:
-- - `id` in `Customers` table = `customerId` in `Orders` table
-- - `LEFT JOIN` two tables and filter whose orderId is Null
-- - get customers name

-- [METHOD 1]
SELECT c.name AS "Customers"
FROM Customers AS c
LEFT JOIN Orders AS o
ON c.id = o.customerId
WHERE o.id IS NULL;


-- thought:
-- - we want to get the customers in `Customers` that are `NOT IN` `Orders`
-- - so we can use `EXCEPT` to get the above result
-- - and then use the above result in `WHERE` clause to get the final answer

-- [METHOD 2]
SELECT c.name AS "Customers"
FROM Customers AS c
WHERE c.id IN (
    SELECT c.id
    FROM Customers AS c
    EXCEPT
    SELECT o.customerId
    FROM Orders AS o
);
