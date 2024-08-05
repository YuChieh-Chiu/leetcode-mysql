-- thought:
-- - as mentioned in the problem description, we know that:
--     # for each product_id, there will be no two overlapping periods, meaning the purchase_date in `UnitsSold` will fall within ONLY ONE period.
--     # `UnitsSold` may contain duplicate rows, so we need to filter duplicates before performing operations on the two tables.
-- - therefore, we can follow these steps:
--     (1) use `DISTINCT` to filter duplicate rows in `UnitsSold`.
--     (2) use `LEFT JOIN` to get all possible combinations between the two tables.
--     (3) use `CASE WHEN ... THEN ... ELSE ... END AS ...` to determine whether the purchase date is between the start date and end date.
--     (4) `GROUP BY` product_id.
--     (5) use `SUM(units * price * in_period) / SUM(units * in_period)` and `ROUND(..., 2)` to get average_price rounded to 2 decimal places.
--         Note that the units may be NULL, so we need to use `CASE WHEN ... THEN ... ELSE ... END AS ...` to determine if we need to transform null into 0

WITH unique_unitsSold AS (
    SELECT DISTINCT *
    FROM UnitsSold
), merged_tables AS (
    SELECT p.product_id, p.start_date, p.end_date, p.price, u.purchase_date, u.units,
        CASE 
            WHEN u.purchase_date >= p.start_date AND u.purchase_date <= p.end_date THEN 1
            ELSE 0
        END AS `in_period`
    FROM Prices AS p
    LEFT JOIN unique_unitsSold AS u
    ON p.product_id = u.product_id
)

SELECT product_id,
    CASE
        WHEN units IS NULL THEN 0
        ELSE ROUND(SUM(price*units*in_period) / SUM(units*in_period), 2) 
    END AS `average_price`
FROM merged_tables
GROUP BY product_id;
