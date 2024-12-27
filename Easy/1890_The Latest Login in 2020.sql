-- Objective:
-- - Identify users who logged in during 2020 and determine their latest login timestamp.
-- Information:
-- - (user_id, time_stamp) serves as the primary key for the `Logins` table.
-- Steps:
-- (1) Use `WHERE ... AND ...` to filter rows with timestamps in 2020.
-- (2) Apply `GROUP BY user_id` with `MAX(time_stamp)` to find each user's latest login timestamp.

SELECT user_id, MAX(time_stamp) AS `last_stamp`
FROM (
    SELECT *
    FROM Logins
    WHERE time_stamp >= '2020-01-01 00:00:00'
    AND time_stamp < '2021-01-01 00:00:00'
) login_2020
GROUP BY user_id;
