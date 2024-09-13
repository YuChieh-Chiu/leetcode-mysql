-- Objective:
-- - Our goal is to calculate the percentage of users registered in each contest, rounded to two decimal places. We need to order the results by percentage in descending order and then by `contest_id` in ascending order.
-- Information:
-- - Based on the problem description, we can infer the following:
--   (1) The total number of users can be obtained from the `Users` table.
--   (2) Since (contest_id, user_id) is the primary key for the `Register` table, each row is unique, allowing us to directly count the number of users per `contest_id`.
-- Steps:
-- 1. Use `COUNT()` to get the total number of users from the `Users` table.
-- 2. Use `GROUP BY contest_id` and `COUNT()` to determine the number of users registered for each contest.
-- 3. Divide the number of users from step (2) by the total number of users from step (1) to calculate the percentage. Then, `ORDER BY` this percentage in descending order, followed by `contest_id` in ascending order.

WITH users_per_contest AS (
    SELECT contest_id, COUNT(*) AS `contest_users`,
        (
            SELECT COUNT(*)
            FROM Users
        ) AS `total`
    FROM Register
    GROUP BY contest_id
)

SELECT contest_id, ROUND((contest_users / total)*100, 2) AS `percentage`
FROM users_per_contest
ORDER BY percentage DESC, contest_id ASC;
