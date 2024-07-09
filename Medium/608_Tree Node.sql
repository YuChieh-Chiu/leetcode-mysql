-- thought:
-- - We can determine the rules as follows:
--     (1) If `p_id` is null, then `id` is a Root.
--     (2) If `id` is present in `p_id` and its `p_id` is not null, then `id` is an Inner node.
--     (3) If `id` is not present in `p_id`, then `id` is a Leaf.
-- - Therefore, we can follow these steps:
--     (1) Use `WHERE p_id IS NULL` to filter the Root node.
--     (2) Use the `WHERE` clause and a subquery to filter `id` values present in `p_id` but not Roots, which are Inner nodes.
--     (3) Use the `WHERE` clause and a subquery to filter `id` values not present in `p_id` and not Roots, which are Leaf nodes.
--     (4) UNION the results of the above three queries.

WITH type_root AS (
    SELECT id, "Root" AS `type`
    FROM Tree
    WHERE p_id IS null
),
type_inner AS (
    SELECT DISTINCT p_id AS `id`, "Inner" AS `type`
    FROM Tree
    WHERE p_id NOT IN (
        SELECT id
        FROM type_root
    )
),
type_leaf AS (
    SELECT id, "Leaf" AS `type`
    FROM Tree
    WHERE id NOT IN (
        SELECT DISTINCT p_id
        FROM Tree
        WHERE p_id IS NOT null
    )
    AND p_id IS NOT null
)

SELECT *
FROM type_root
UNION 
SELECT *
FROM type_inner
UNION 
SELECT *
FROM type_leaf;
