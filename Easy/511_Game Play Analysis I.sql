-- thought:
-- - we only need to know `first login date` of each player
-- - the only columns we concerned are `player_id` and `event_date`
-- - use `MIN() OVER(PARTITION BY ... ORDER BY ...)` to get the smallest `event_date` of each `player_id`
-- - `SELECT` the columns we need and rename the columns `AS` output column names
    -- - Note that `player_id` may have more than one smallest `event_date`, use `DISTINCT` to get one of them

SELECT DISTINCT player_id,
    MIN(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS "first_login"
FROM Activity;
