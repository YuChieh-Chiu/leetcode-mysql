-- thought:
-- - our goal is to find the daily active users from 2019-06-28 to 2019-07-27.
--     - an active user is defined as a user who has at least one activity record on that day.
-- - therefore, we can follow these steps:
--     (1) use `WHERE` to filter the rows where the date falls between 2019-06-28 and 2019-07-27.
--     (2) use `DISTINCT` to remove duplicate user_ids.
--     (3) use `GROUP BY` and `COUNT()` to calculate the daily active users.

WITH past_30 AS (
    SELECT DISTINCT user_id, activity_date
    FROM Activity
    WHERE activity_date >= "2019-06-28"
    AND activity_date <= "2019-07-27"
)

SELECT activity_date AS "day", COUNT(user_id) AS "active_users"
FROM past_30
GROUP BY activity_date;
