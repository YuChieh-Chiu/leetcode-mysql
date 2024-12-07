-- Objective:
-- - Restructure the Products table so that each row represents a product's price in a specific store, in the format (product_id, store, price).
-- Information:
-- - Each row in the original Products table contains prices for three stores: store1, store2, and store3.
-- - If a product is not available in a store, the corresponding column will have a null value.
-- Steps:
-- (1) Extract the information for store1 by creating rows with (product_id, 'store1', price). 
--     - Use `WHERE store1 IS NOT NULL` to exclude rows where the price in store1 is null.
-- (2) Repeat the process for store2 and store3 to extract their respective data.
-- (3) Use `UNION` to combine the results from all three stores into the final table.

(
    SELECT product_id, 'store1' AS store, store1 AS price
    FROM Products
    WHERE store1 IS NOT NULL
)
UNION
(
    SELECT product_id, 'store2' AS store, store2 AS price
    FROM Products
    WHERE store2 IS NOT NULL
)
UNION
(
    SELECT product_id, 'store3' AS store, store3 AS price
    FROM Products
    WHERE store3 IS NOT NULL
);
