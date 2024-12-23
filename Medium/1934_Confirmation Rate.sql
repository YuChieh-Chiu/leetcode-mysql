-- Objective:
-- - Calculate the confirmation rate of each user and return the table in any order.
--     - The confirmation rate is calculated as the number of 'confirmed' messages divided by the total number of requested confirmation messages.
--     - If a user did not request any confirmation messages, their confirmation rate should be 0.
--     - The confirmation rate should be rounded to two decimal places.
-- Information:
-- - In the `Signups` table:
--     - user_id is the primary key and is unique.
-- - In the `Confirmations` table:
--     - (user_id, time_stamp) is the primary key and is unique.
--     - user_id is a foreign key referencing the `Signups` table.
-- Steps:
-- (1) Use a LEFT JOIN to retrieve all users.
-- (2) Filter users with actions using WHERE action IS NOT NULL.
-- (3) GROUP BY user_id to calculate the confirmation rate.
-- (4) Use CASE WHEN ... THEN ... END with COUNT() to compute the confirmation rate.
-- (5) Round the confirmation rate to two decimal places using ROUND(, 2).
-- (6) Filter out users with no actions using WHERE action IS NULL.
-- (7) Assign a value of 0 to the confirmation_rate column for such users.
-- (8) Use UNION to combine both tables to produce the final result.

WITH combine AS (
    SELECT s.user_id, c.action
    FROM Signups AS s
    LEFT JOIN Confirmations AS c
    ON s.user_id = c.user_id
)

(
    SELECT user_id,
        ROUND(COUNT(CASE WHEN action = 'confirmed' THEN 1 END) / COUNT(*), 2) AS `confirmation_rate`
    FROM combine
    WHERE action IS NOT NULL
    GROUP BY user_id
)
UNION
(
    SELECT user_id,
        0.00 AS `confirmation_rate`
    FROM combine
    WHERE action IS NULL
    GROUP BY user_id
);
