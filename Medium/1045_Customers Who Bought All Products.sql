-- thought:
-- - we know that there may be duplicate rows in `Customer`, but `customer_id` will not be NULL.
-- - assuming all `product_key` values in `Customer` exist in `Product`, we can infer that after removing duplicates, only the `customer_id` that appears as many times as the number of rows in `Product` indicates that the customer has purchased all products.
-- - therefore, we can follow these steps:
--     (1) use `DISTINCT` to remove duplicates from `Customer`.
--     (2) use `GROUP BY` to group by `customer_id`.
--     (3) use `HAVING` and `COUNT()` to find `customer_id` values that have purchased all products.

WITH unique_customer AS (
    SELECT DISTINCT *
    FROM Customer
)

SELECT customer_id
FROM unique_customer
GROUP BY customer_id
HAVING COUNT(product_key) = (
    SELECT COUNT(*) AS "all"
    FROM Product
);
