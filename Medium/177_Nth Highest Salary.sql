CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
    -- thought (the thought here is the same as `176. Second Highest Salary`):
    -- - use `ORDER BY ... DESC` and get the unique value in `salary` using `GROUP BY`
        -- - Note that `DISTINCT` will only be effective when both the `salary and `row_number` columns have identical values
    -- - get the row count by ROW_NUMBER()
    -- - union all with `NULL`
    -- - get the first row (if there exists ne.row_number=N, the first row is real salary, if not exists, it would be `NULL`
        -- - Note that the column name is defined by `function name`, so we don't need to consider it
    WITH ne AS (
        SELECT salary, ROW_NUMBER() OVER (
            ORDER BY salary DESC
        ) AS "row_number" 
        FROM Employee
        GROUP BY salary
        ORDER BY salary DESC
    )
    SELECT salary AS "getNthHighestSalary"
    FROM ne
    WHERE ne.row_number = N
    UNION ALL (
        SELECT NULL AS "getNthHighestSalary"
    )
    LIMIT 1
  );
END
