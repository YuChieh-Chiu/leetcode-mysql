-- Objective:
-- - Our goal is to identify tweets with invalid content.
-- Information:
-- - Based on the problem description, the information for the `Tweets` table is as follows:
--     - A tweet is considered invalid if its content exceeds 15 characters.
-- Steps:
-- (1) Use `WHERE` and `LENGTH()` to filter rows where the content length exceeds 15 characters.
-- (2) Only `SELECT` tweet_id as the result column.

SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;
