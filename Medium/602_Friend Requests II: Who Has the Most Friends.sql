-- thought:
-- - Note that
--     - "(requester_id, accepter_id) is the primary key" means that every single combination between requester_id & accepter_id is UNIQUE
--     - no matter the `id` is in the requester_id field or in the accepter_id field, the person has ONE friend
--     - the answer that people with most friends may not ONLY ONE row
-- - so we can do the steps below:
--     (1) use `UNION ALL` to connect `SELECT requester_id AS "id"` and `SELECT accepter_id AS "id"`
--     (2) use `GROUP BY id` to get the `COUNT()` of each id
--     (3) use `WHERE` clause to get the id with most friends

WITH all_ids AS (
    SELECT requester_id AS "id"
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS "id"
    FROM RequestAccepted
), id_num AS (
    SELECT id, COUNT(id) AS "num"
    FROM all_ids
    GROUP BY id
)

SELECT *
FROM id_num
WHERE id_num.num = (
    SELECT MAX(num)
    FROM id_num
);
