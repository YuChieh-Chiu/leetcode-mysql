-- thought:
-- - our goal is to find `product_id`s that appear "only" between 2019-01-01 and 2019-03-31.
-- - in other words, we need to identify `product_id`s that appear "during 2019-01-01 to 2019-03-31 but not at any other time".
-- - therefore, we can follow these steps:
--     (1) use `WHERE` to filter `product_id`s with `sale_date` between 2019-01-01 and 2019-03-31.
--     (2) use `WHERE` to filter `product_id`s with `sale_date` not between 2019-01-01 and 2019-03-31.
--     (3) use `LEFT JOIN` with `right_table.fk IS NULL` to perform a difference operation to find `product_id`s that appear "between 2019-01-01 and 2019-03-31 but not at any other time".
--     (4) join the result of step (3) with the `Product` table to get `product_id`s that appear "only" between 2019-01-01 and 2019-03-31.
--     (5) use `DISTINCT` to eliminate duplicate rows and obtain the final answer.

WITH q1 AS (
    SELECT product_id, sale_date
    FROM Sales
    WHERE sale_date >= "2019-01-01"
    AND sale_date <= "2019-03-31"
), q_other AS (
    SELECT product_id, sale_date
    FROM Sales
    WHERE sale_date < "2019-01-01"
    OR sale_date > "2019-03-31"
), q_minus AS (
    SELECT q1.product_id
    FROM q1
    LEFT JOIN q_other 
    ON q1.product_id = q_other.product_id
    WHERE q_other.product_id IS NULL
)

SELECT DISTINCT p.product_id AS "product_id", p.product_name AS "product_name"
FROM Product AS p
RIGHT JOIN q_minus AS q
ON p.product_id = q.product_id;
