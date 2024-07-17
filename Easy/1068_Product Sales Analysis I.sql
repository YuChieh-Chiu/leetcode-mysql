-- thought:
-- - note the following information we have:
--     - (sales_id, year) is a pair of primary key.
--     - we want the result to include `product_name`, `year`, and `price` for each `sale_id`.
-- - therefore, we can follow these steps:
--     (1) use a `LEFT JOIN` to combine the two tables.
--     (2) use `GROUP BY` to group by `sale_id`.
--     (3) select the required columns directly (since (sales_id, year) is a pair of primary key, there will be no duplicates).

SELECT p.product_name AS `product_name`, s.year AS `year`, s.price AS `price`
FROM Sales AS s
LEFT JOIN Product AS p
ON s.product_id = p.product_id
GROUP BY s.sale_id;
