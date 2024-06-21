-- thought:
-- - note that `id` should be sort in ascending order and `id` may have a `hole`
-- - use `LAG(col_name, offset)` to get the value in previous n row and add two rows to show `value - LAG(col_name, 1)` and `value - LAG(col_name, 2)`
-- - do the above execution on both `id` and `num`
-- - filter the rows where `value - LAG(col_name, 1)` and `value - LAG(col_name, 2)` for `id` and `num` both equals to zero
-- - Note that we should just get `DISTINCT` num

WITH lag_logs AS (
    SELECT num, 
        id - 1 - LAG(id, 1) OVER(ORDER BY id) AS "id_lag1",
        id - 2 - LAG(id, 2) OVER(ORDER BY id) AS "id_lag2",
        num - LAG(num, 1) OVER(ORDER BY id) AS "num_lag1",
        num - LAG(num, 2) OVER(ORDER BY id) AS "num_lag2"
    FROM Logs
)

SELECT DISTINCT ll.num AS "ConsecutiveNums"
FROM lag_logs AS ll
WHERE ll.id_lag1 = 0
AND ll.id_lag2 = 0
AND ll.num_lag1 = 0
AND ll.num_lag2 = 0;
