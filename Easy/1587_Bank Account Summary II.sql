-- thought:
-- - from the description of the `Users` table, we know that each account and name is unique.
-- - our goal is to find the name and balance of users whose balance is higher than 10,000.
--   - the balance of an account is equal to the sum of all transaction amounts involving that account.
-- - therefore, we can follow these steps:
--   (1) merge the two tables using a `LEFT JOIN`.
--   (2) `GROUP BY` account and `SUM()` all transaction amounts for each account.
--   (3) use `HAVING` to filter accounts with a `SUM()` greater than 10,000.

WITH acc_trans AS (
    SELECT u.account, u.name, t.amount
    FROM Users AS u
    LEFT JOIN Transactions AS t
    ON u.account = t.account
)

SELECT name, SUM(amount) AS `balance`
FROM acc_trans
GROUP BY name
HAVING SUM(amount) > 10000;
