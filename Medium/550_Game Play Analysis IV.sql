-- thought:
-- - we only need to know the following things:
    -- a. when is the first login date of each player
    -- b. player logged in again after the first login date or not
-- - so we do the following steps:
    -- (1) `SELECT DISTINCT` player_id and event_date
    -- (2) record the players once have CONSECUTIVE login or not by using `CASE WHEN ... THEN ... ELSE ... END AS ...`
    -- (3) use `ROW_NUMBER()` to identify the first login date
    -- (4) use `WHERE` clause to get the first login date
    -- (5) use `ROUND(AVG(), 2)` to calculate the fraction of consecutive login after the first login date and round the number to digit 2

WITH pk AS (
    SELECT DISTINCT player_id, event_date
    FROM Activity
)

SELECT ROUND(AVG(r.consecutie_check), 2) AS "fraction"
FROM (
    SELECT player_id,
        event_date,
        CASE WHEN DATEDIFF(LEAD(event_date, 1) OVER(PARTITION BY player_id ORDER BY event_date), event_date) = 1 THEN 1
            ELSE 0
        END AS "consecutie_check",
        ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) AS "row_num"
    FROM pk
) AS r
WHERE r.row_num = 1;
