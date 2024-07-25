-- thought:
-- - our goal is to find the number of orders each buyer_id made in 2019.
--     - note that:
--         1. we need to record even those with 0 orders.
--         2. although both buyer_id and seller_id are foreign keys referencing the Users table, we only need to use buyer_id here.
-- - therefore, we can follow these steps:
--     (1) use `WHERE` and `LIKE` to filter out records from the Orders table where the date starts with 2019.
--     (2) use `GROUP BY` and `COUNT()` to get the number of orders for each buyer_id.
--     (3) use `LEFT JOIN` to merge the Users and Orders tables, ensuring all user_ids are included.
--     (4) use `CASE WHEN ... THEN ... ELSE ... END AS ...` to handle cases where the order count is NULL.

WITH buyer_2019 AS (
    SELECT buyer_id, COUNT(order_date) AS `orders_in_2019`
    FROM Orders
    WHERE order_date LIKE "2019%"
    GROUP BY buyer_id
)

SELECT u.user_id AS `buyer_id`, u.join_date, 
    CASE 
        WHEN b.orders_in_2019 IS NULL THEN 0
        ELSE b.orders_in_2019
    END AS `orders_in_2019`
FROM Users AS u
LEFT JOIN buyer_2019 AS b
ON u.user_id = b.buyer_id;
