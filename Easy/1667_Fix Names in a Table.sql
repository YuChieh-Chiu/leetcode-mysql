-- Objective:
-- - Our goal is to normalize the names, ensuring that only the first character is uppercase and the rest are lowercase, and return the table ordered by `user_id` ascendingly.
-- Information:
-- - Based on the problem description, the information for the `Users` table is as follows:
--     - The names consist of only lowercase and uppercase characters.
-- Steps:
-- (1) Use `UPPER()` with `SUBSTRING()` to convert the first character to uppercase.
-- (2) Use `LOWER()` with `SUBSTRING()` to transform the remaining characters to lowercase.
-- (3) Use `CONCAT()` to concatenate the result of steps (1) and (2).
-- (4) Sort the results by `user_id` in ascending order.

SELECT user_id,
    CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2))) AS `name`
FROM Users
ORDER BY user_id;
