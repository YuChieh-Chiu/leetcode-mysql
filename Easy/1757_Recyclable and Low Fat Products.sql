-- Objective:
-- - Find the IDs of products that are both low fat and recyclable.
-- Information:
-- - `product_id` is the primary key and contains unique values.
-- - `low_fats` is an ENUM column with values `Y` and `N`.
-- - `recyclable` is also an ENUM column with values `Y` and `N`.
-- Steps:
-- (1) Use `WHERE` and `AND` to filter product IDs that are both low fat and recyclable.

SELECT product_id
FROM Products
WHERE low_fats = 'Y'
AND recyclable = 'Y';
