-- thought:
-- - use `ORDER BY ... DESC` and get the unique value in `salary` using `GROUP BY`
    -- - Note that `DISTINCT` will only be effective when both the `salary and `row_number` columns have identical values
-- - get the row count by ROW_NUMBER()
-- - union all with `NULL`
-- - get the first row (if there exists ne.row_number=2, the first row is real salary, if not exists, it would be NULL)
WITH ne AS (
    SELECT salary, ROW_NUMBER() OVER (
        ORDER BY salary DESC
    ) AS "row_number" 
    FROM Employee
    GROUP BY salary
    ORDER BY salary DESC
)

SELECT salary AS "SecondHighestSalary"
FROM ne
WHERE ne.row_number = 2
UNION ALL (
    SELECT NULL AS "SecondHighestSalary"
)
LIMIT 1;
