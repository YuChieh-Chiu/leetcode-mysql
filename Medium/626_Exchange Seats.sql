-- thought:
-- - our goal is to swap the student names of `id=i` and `id=i+1` with the following constraints:
--     (1) if `id=n+1` does not exist, the student name of `id=n` should not be swapped.
--     (2) the result should be sorted in ascending order by `id`.
-- - therefore, we can follow these steps:
--     (1) use `ORDER BY id` to sort by `id` in ascending order.
--     (2) use `FLOOR((id+1)/2)` to group `id` into pairs of `i` and `i+1`.
--     (3) use `LAG()` to swap the student name of `i+1` with the student name of `i`.
--     (4) use `LEAD()` to swap the student name of `i` with the student name of `i+1`.
--     (5) finally, determine the appropriate value for each row based on the following scenarios:
--         - if (3) is NULL and (4) is not NULL -> return (4).
--         - if (3) is not NULL and (4) is NULL -> return (3).
--         - if both (3) and (4) are NULL -> return `student`.
--         - Note: There will be no cases where both (3) and (4) have values.

WITH swap AS (
    SELECT *,
        FLOOR((id+1)/2) AS "group_id"
    FROM Seat
    ORDER BY id
)

SELECT o.id,
    CASE
        WHEN (o.swap_lag IS NULL) AND (o.swap_lead IS NOT NULL) THEN o.swap_lead
        WHEN (o.swap_lead IS NULL) AND (o.swap_lag IS NOT NULL) THEN o.swap_lag
        ELSE o.student
    END AS `student`
FROM (
    SELECT *,
        LAG(student, 1) OVER(PARTITION BY group_id) AS "swap_lag",
        LEAD(student, 1) OVER(PARTITION BY group_id) AS "swap_lead"
    FROM swap
) AS o;
