-- thought：
-- - we need to find the `quality` and `poor_query_percentage` of each `query_name`
--     # the table may have DUPLICATE rows
--     # we need to round the answer to 2 decimal places
--     # query with rating less than 3 is a poor query
--     # query_name may be NULL
-- - and we already get the definition of `quality` and `poor_query_percentage` as below：
--     - quality：the average of the ratio between query rating and its position.
--     - poor_query_percentage：the percentage of all queries with rating less than 3.
-- - therefore, we can follow these steps：
--     (1) remove duplicate rows using `DISTINCT`
--     (2) use `CASE WHEN ... THEN ... ELSE ... END AS ...` to check if the query is poor
--     (3) group by `query_name`
--     (4) use `ROUND(AVG(),2)` to get the quality
--     (5) use `ROUND(AVG()*100,2)` to get the poor_query_percentage

WITH clean_queries AS (
    SELECT DISTINCT *,
        CASE
            WHEN rating < 3 THEN 1
            ELSE 0
        END AS `poor`
    FROM Queries
    WHERE query_name IS NOT NULL
)

SELECT query_name,
    ROUND(AVG(rating / position),2) AS `quality`,
    ROUND(AVG(poor) * 100,2) AS `poor_query_percentage`
FROM clean_queries
GROUP BY query_name;
