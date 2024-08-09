-- thought:
-- - based on the problem description, we know that:
--     # there will be at least one customer every day.
--     # the combination of (customer_id, visited_on) is the primary key for the table, meaning there are no duplicates to filter.
-- - therefore, we can follow these steps:
--     (1) `GROUP BY` visited_on to get the total amount for each day.
--     (2) use `LAG(,n)` with n=1~6 to create a seven-day window (current day + 6 days prior).
--     (3) use `IS NOT NULL` to filter out rows where any of the previous 6 days is NULL.
--     (4) sum the amounts for each day within the seven-day window to get the total amount.
--     (5) use `ROUND(amount/7, 2)` to calculate the `average_amount` for the visited_on date, and `ORDER BY` visited_on in ascending order.

WITH daily_sum AS (
    SELECT visited_on, SUM(amount) AS `daily_amount`
    FROM Customer
    GROUP BY visited_on
), seven_days_window AS (
    SELECT *,
        LAG(daily_amount, 1) OVER(ORDER BY visited_on) AS `lag1`,
        LAG(daily_amount, 2) OVER(ORDER BY visited_on) AS `lag2`,
        LAG(daily_amount, 3) OVER(ORDER BY visited_on) AS `lag3`,
        LAG(daily_amount, 4) OVER(ORDER BY visited_on) AS `lag4`,
        LAG(daily_amount, 5) OVER(ORDER BY visited_on) AS `lag5`,
        LAG(daily_amount, 6) OVER(ORDER BY visited_on) AS `lag6`
    FROM daily_sum
)

SELECT visited_on,
    (daily_amount + lag1 + lag2 + lag3 + lag4 + lag5 + lag6) AS `amount`,
    ROUND((daily_amount + lag1 + lag2 + lag3 + lag4 + lag5 + lag6)/7, 2) AS `average_amount`
FROM seven_days_window
WHERE lag6 IS NOT NULL
ORDER BY visited_on;
