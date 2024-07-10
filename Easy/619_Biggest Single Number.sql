-- thought:
-- - use `GROUP BY` and `COUNT()` to calculate how many times each `num` appears
-- - use `HAVING` to filter out `num` that appear only once time
-- - use `UNION` & `SELECT null` to deal with the case with no single number
-- - use `ORDER BY num DESC` to sort `num` with null
-- - use `LIMIT 1` to get the first `num`

SELECT num
FROM MyNumbers
GROUP BY num
HAVING COUNT(num) = 1
UNION
SELECT null AS `num`
FROM MyNumbers
ORDER BY num DESC
LIMIT 1;
