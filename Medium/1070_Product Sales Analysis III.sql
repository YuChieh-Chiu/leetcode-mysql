-- thought:
-- - our goal is to obtain the `year`, `quantity`, and `price` for each `product_id` for every sale in the first year.
-- - note: There might be multiple records of `product_id` being sold in the first year.
-- - therefore, we can follow these steps:
--     (1) note: All the required fields are in the `Sales` table, no need to join with other tables.
--     (2) use `MIN(col) OVER (PARTITION BY col2)` to get the first year for each `product_id`.
--     (3) use `WHERE (col1, col2) IN subquery` to retrieve the rows for each `product_id` in the first year.

WITH min_year_by_product AS (
    SELECT product_id, MIN(year) OVER(PARTITION BY product_id) AS `min_year`
    FROM Sales
)

SELECT product_id, year AS `first_year`, quantity, price
FROM Sales
WHERE (product_id, year) IN (
    SELECT *
    FROM min_year_by_product
);
