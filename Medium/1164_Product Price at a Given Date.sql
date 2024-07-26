-- thought:
-- - our goal is to find the prices of each product on 2019-08-16, which can be broken down into two parts:
--     (1) for products with price changes on or before 2019-08-16, take the latest price as of that date.
--     (2) for products with no price changes on or before 2019-08-16, set their price to 10.
-- - therefore, we can follow these steps:
--     (1) use `WHERE` to filter the rows up to and including 2019-08-16.
--     (2) use `GROUP BY` with `MAX()`, and a `LEFT JOIN` to select the latest price for each product_id on or before 2019-08-16.
--     (3) use `LEFT JOIN` with `IS NULL` to find product_ids not included in step (2) and set their price to 10.
--     (4) use `UNION` to combine the results of steps (2) and (3) to get the final answer.

WITH before_date AS (
    SELECT product_id, MAX(change_date) AS "max_change_date"
    FROM Products
    WHERE change_date <= "2019-08-16"
    GROUP BY product_id
), has_changed AS (
    SELECT p.product_id, p.new_price AS `price`
    FROM Products AS p
    LEFT JOIN before_date AS b
    ON p.product_id = b.product_id
    WHERE p.change_date = b.max_change_date
), no_records AS (
    SELECT p.product_id, 10 AS `price`
    FROM Products AS p
    LEFT JOIN has_changed AS h
    ON p.product_id = h.product_id
    WHERE h.price IS NULL
)

SELECT *
FROM has_changed
UNION
SELECT *
FROM no_records;
