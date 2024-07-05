-- thought:
-- - `SalesPerson` indicates the salesperson information
-- - `Company` indicates the company information
-- - `Orders` indicates the orders between salesperson and company
-- - so we can do the following steps:
--     (1) `LEFT JOIN` Orders with Company
--     (2) and use `WHERE` clause to filter orders related to "RED" company as os
--     (3) use `WHERE ... NOT IN subquery` clause to filter salesperson not in os

WITH os AS (
    SELECT o.sales_id
    FROM Orders AS o
    LEFT JOIN Company AS c
    ON o.com_id = c.com_id
    WHERE c.name = "RED"
)

SELECT DISTINCT s.name AS "name"
FROM SalesPerson as s
WHERE s.sales_id NOT IN (
    SELECT *
    FROM os
)
