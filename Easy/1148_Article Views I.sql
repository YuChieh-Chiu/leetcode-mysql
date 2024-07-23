-- thought:
-- - knowing that the same author_id and viewer_id represent the same person, our goal is to find people who have viewed their own articles at least once.
-- - therefore, we can follow these steps:
--     (1) use `WHERE` to filter rows where author_id equals viewer_id.
--     (2) use `DISTINCT` to remove duplicate rows, keeping only unique author_ids.
--     (3) use `ORDER BY` to sort the ids in ascending order.

SELECT DISTINCT author_id AS `id`
FROM Views
WHERE author_id = viewer_id
ORDER BY author_id;
