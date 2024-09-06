-- thought:
-- - our goal is to identify the `customer_id`s who haven't made any transactions and count the number of times they made such visits.
-- - this means we need to achieve the following conditions after merging the two tables:
--     1. the `transaction_id` should be NULL, indicating that the customer hasn't made any transactions.
--     2. count the number of occurrences where `transaction_id` is NULL.
-- - therefore, we can follow these steps:
--     1. `LEFT JOIN` the two tables.
--     2. filter rows `WHERE` transaction_id is NULL.
--     3. `GROUP BY` customer_id and `COUNT()` the number of times they visited without making any transactions.

WITH visit_trans AS (
    SELECT v.visit_id, v.customer_id, t.transaction_id, t.amount
    FROM Visits AS v
    LEFT JOIN Transactions AS t
    ON v.visit_id = t.visit_id
    WHERE t.transaction_id IS NULL
)

SELECT customer_id, COUNT(customer_id) AS `count_no_trans`
FROM visit_trans
GROUP BY customer_id;
