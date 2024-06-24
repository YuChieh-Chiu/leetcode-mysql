-- thought:
-- - we need to calculate the `cancellation rate` of UNBANNED uses and drivers
-- - and we know `client_id` and `driver_id` is the FK to the `user_id`
-- - so, we need to follow the steps:
--     (1) use `WHERE` to filter users UNBANNED (banned = No)
--     (2) use SUBQUERY in `WHERE` clause to filter `client_id` and `driver_id` BOTH in `users`
--     (3) use `AND` to select the trips BETWEEN `2013-10-01` to `2013-10-03` too
--     (4) use `CASE WHEN ... THEN ... ELSE ... END AS col_name` to turn the value in `status` to (0,1) so that we can do calculation
--     (5) use `GROUP BY request_at` and calculate ROUND(AVG(col_name), 2) to get the cancellation rate
--     (6) use `AS` to get the correct column names

WITH unbanned_users AS (
    SELECT users_id
    FROM Users
    WHERE banned = "No"
), unbanned_trips AS (
    SELECT 
        t.request_at,
        t.client_id,
        t.driver_id,
        CASE
            WHEN t.status = "completed" THEN 0
            ELSE 1
        END AS "status_bool"
    FROM Trips AS t
    WHERE t.client_id IN (
        SELECT *
        FROM unbanned_users
    )
    AND t.driver_id IN (
        SELECT *
        FROM unbanned_users
    )
    AND t.request_at >= "2013-10-01"
    AND t.request_at <= "2013-10-03"
)

SELECT u.request_at AS "Day",
    ROUND(AVG(u.status_bool), 2) AS "Cancellation Rate"
FROM unbanned_trips AS u
GROUP BY u.request_at;
