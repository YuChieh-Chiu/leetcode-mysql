-- thought:
-- - our goal is to find the number of transactions, number of successful transactions, total transaction amount, and total successful transaction amount for each month and each country.
--     - we need to extract some additional information:
--         (1) extract the transaction month from trans_date.
--         (2) convert the state to a 1, 0 format to facilitate counting the number and total amount.
-- - therefore, we can follow these steps:
--     (1) use `LEFT()` to get the year and month from trans_date.
--     (2) use `CASE WHEN ... THEN ... ELSE ... END AS ...` to convert state to a 1, 0 format.
--     (3) use `GROUP BY` to group the data by month and country.
--     (4) use `COUNT()` to count the number of transactions.
--     (5) use `SUM()` to calculate the number of successful transactions, total transaction amount, and total successful transaction amount.

WITH trans AS (
    SELECT country,
        CASE
            WHEN state = "approved" THEN 1
            ELSE 0
        END AS `state_bool`,
        amount,
        LEFT(trans_date, 7) AS `month`
    FROM Transactions
)

SELECT month,
    country,
    COUNT(state_bool) AS `trans_count`,
    SUM(state_bool) AS `approved_count`,
    SUM(amount) AS `trans_total_amount`,
    SUM(amount * state_bool) AS `approved_total_amount`
FROM trans
GROUP BY country, month;
