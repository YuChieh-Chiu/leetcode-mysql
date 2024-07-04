-- thought:
-- - according to the description, we need to:
--     (1) filter who are not located in the same city as any other policyholder
--     (2) filter have the same `tiv_2015` value as one or more other policyholders
--     (3) get the sum of `tiv_2016`
-- - we can do the following steps:
--     (1) `COUNT() OVER(PARTITION BY tiv_2015)` to get the times each tiv_2015 appears
--     (2) `GROUP BY lat, lon` and `SELECT COUNT()` to get the times each (lat, lon) appears
--     (3) `SELECT ROUND(SUM(ans.tiv_2016), 2)` on `WHERE (1)>1 AND (2)=1`

WITH same_tiv_2015 AS (
    SELECT *, COUNT(tiv_2016) OVER(PARTITION BY tiv_2015) AS "pid_cnt"
    FROM Insurance
)

SELECT ROUND(SUM(ans.tiv_2016), 2) AS "tiv_2016"
FROM (
    SELECT tiv_2016, pid_cnt, COUNT(tiv_2015) AS "loc_cnt"
    FROM same_tiv_2015
    GROUP BY lat, lon
) AS ans
WHERE ans.pid_cnt > 1
AND ans.loc_cnt = 1;
