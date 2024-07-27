-- thought:
-- - our goal is to perform the following steps:
--     (1) identify the first order for each customer_id
--         - note: The problem statement specifies that there is only one first order.
--     (2) determine whether each customer_id's first order is immediate or scheduled.
--     (3) calculate the proportion of first orders that are immediate and round it to two decimal places.
-- - therefore, we can follow these steps:
--     (1) use `GROUP BY` along with `MIN()` to get the first order for each customer_id.
--     (2) use `LEFT JOIN` to get the customer_pref_delivery_date on the first date for each customer_id.
--     (3) use `CASE WHEN ... THEN ... ELSE ... END AS ...` to determine if each customer_id's first order is immediate (1) or scheduled (0).
--     (4) use `AVG()` and `ROUND()` to calculate the proportion of first orders that are immediate and round it to two decimal places.

WITH first_order AS (
    SELECT customer_id, MIN(order_date) AS `first_order`
    FROM Delivery
    GROUP BY customer_id
    ORDER BY delivery_id
), first_order_and_delivery AS (
    SELECT f.customer_id, f.first_order, d.customer_pref_delivery_date
    FROM Delivery AS d
    RIGHT JOIN first_order AS f
    ON d.customer_id = f.customer_id
    AND d.order_date = f.first_order
), ratio AS (
    SELECT 
        CASE
            WHEN first_order = customer_pref_delivery_date THEN 1
            ELSE 0
        END AS `types`
    FROM first_order_and_delivery
)

SELECT ROUND(AVG(types)*100,2) AS `immediate_percentage`
FROM ratio;
