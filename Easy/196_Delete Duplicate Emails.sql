-- thought:
-- - First, note that we should use `DELETE` statement
-- - Second, note that we can just do operation on `Person` table
-- - So, do the following steps:
    -- - use `GROUP BY` and `MIN(id)` to pin the email with the smallest `id`
    -- - and use `WHERE` to delete the other duplicated emails and keep the smallest one
    -- - NOTE. we CANNOT select and upate/delete the same table in one SQL query, so we should use `INTERMEDIATE TABLE` subquery to avoid the error

DELETE FROM Person
WHERE id NOT IN (
    SELECT p.minId
    FROM (
        SELECT MIN(id) AS "minId", email
        FROM Person
        GROUP BY email
    ) AS p
);
