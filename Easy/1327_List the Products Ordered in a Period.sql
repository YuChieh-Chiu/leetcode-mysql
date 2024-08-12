-- thought:
-- - our goal is to get the names of products that had at least 100 units ordered in February 2020 and their corresponding quantities.
-- - therefore, we can follow these steps:
--     (1) use `WHERE` to filter order_date between 2020-02-01 and 2020-03-01 (not included).
--     (2) `GROUP BY` product_id and use `SUM()` to calculate the total units in February 2020.
--     (3) use `HAVING` to filter products where the `SUM(units)` is >= 100.
--     (4) use a `RIGHT JOIN` with the Products table to retrieve the product_name in the output table.

WITH order_by_id AS (
    SELECT product_id, SUM(unit) AS `unit`
    FROM Orders
    WHERE order_date >= '2020-02-01'
    AND order_date < '2020-03-01'
    GROUP BY product_id
    HAVING SUM(unit) >= 100
)

SELECT p.product_name, o.unit
FROM Products AS p
RIGHT JOIN order_by_id AS o
ON p.product_id = o.product_id;
