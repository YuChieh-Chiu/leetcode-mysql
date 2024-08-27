-- thought:
-- - according to the problem description, we note that:
--     1. It may contain duplicates.
-- - our goal is to find the number of different products sold and their names for each date.
-- - note that:
--     1. We need to ensure that each product is unique first, as we only require the number of DIFFERENT products sold.
--     2. the product names sold on each date should be sorted lexicographically.
--     3. the result table should be sorted by sell_date in ascending order.
-- - therefore, we can follow these steps:
--     (1) Use `DISTINCT` on the (sell_date, product) combination.
--     (2) `GROUP BY` sell_date and use `GROUP_CONCAT()` on product names.
--         - Remember to `ORDER BY` product name `ASC`.
--     (3) `COUNT()` the number of products for each date.
--     (4) `ORDER BY` sell_date `ASC`.

WITH uni_act AS (
    SELECT DISTINCT *
    FROM Activities
)

SELECT sell_date, COUNT(product) AS `num_sold`, GROUP_CONCAT(product ORDER BY product ASC SEPARATOR ',') AS `products`
FROM uni_act
GROUP BY sell_date
ORDER BY sell_date ASC;
