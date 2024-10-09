-- Objective:
-- - Determine the number of followers for each user_id.
-- Information:
-- - From the problem description, the `Followers` table contains the following columns:
--     - (user_id, follower_id) is the primary key, so no deduplication is required.
-- Steps:
-- (1) Use `GROUP BY` on user_id and `COUNT()` to get the number of followers for each user_id.
-- (2) Sort the result by `user_id` in ascending order.

SELECT user_id, COUNT(follower_id) AS `followers_count`
FROM Followers
GROUP BY user_id
ORDER BY user_id ASC;
