-- thought:
-- - our goal is to filter users with valid emails.
--     - note that a valid email consists of a prefix part and a domain, such that:
--         1. The prefix part is a string that may contain letters (upper or lower case), digits, an underscore '_', a period '.', and/or a dash '-'. The prefix part must start with a letter.
--         2. The domain is '@leetcode.com'.
-- - The key point is to define a REGULAR EXPRESSION that matches the criteria of a valid email defined above.
-- - Therefore, we can follow these steps:
--     (1) Use `WHERE` and `REGEXP` to filter valid emails.
--     (2) Select all (`*`) rows that match the condition in (1).

SELECT *
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9._-]*@leetcode[.]com$';
