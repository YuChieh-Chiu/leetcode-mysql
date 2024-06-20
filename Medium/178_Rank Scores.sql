-- thought:
-- - use `ORDER BY ... DESC` to sort the column `score` in descending order (rule 1)
-- - use `GROUP BY` and `ROW_NUMBER()` to get the rank (rule 2&3)
-- - use `LEFT JOIN` to join two tables and get the needed columns `score` and `rank`
WITH rank_table AS (
    SELECT score, ROW_NUMBER() OVER (
        ORDER BY score DESC
    ) AS "rank"
    FROM Scores
    GROUP BY score
    ORDER BY score DESC
)

SELECT s.score, rt.rank
FROM Scores AS s
LEFT JOIN rank_table AS rt
ON s.score = rt.score
ORDER BY score DESC;
