-- thought:
-- - use `GROUP BY` to `COUNT` number of each email
-- - use `HAVING` to get the number != 1
-- - show `email` column

SELECT email AS "Email"
FROM Person
GROUP BY email
HAVING COUNT(email) <> 1;
