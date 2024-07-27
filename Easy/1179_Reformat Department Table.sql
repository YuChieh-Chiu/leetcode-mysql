-- thought:
-- - our goal is to transform the original table's revenue and month into a one-hot encoding format (as shown in Example 1's output).
-- - therefore, we can follow these steps:
--     (1) sse `GROUP BY` to group by each id.
--     (2) use `SUM(CASE WHEN ... THEN ... ELSE ... END) AS ...` to check if there is a Revenue value for January and record it as the `Jan_Revenue` column.
--          # IMPORTANT: remember to use `SUM()` (an AGGREGATE function) here to prevent the GROUP BY clause from not working as expected when there are multiple rows for the same id
--     (3) repeat step (2) for calculating Revenue values for each month from January to December.

SELECT id,
    SUM(CASE 
        WHEN month="Jan" THEN revenue
        ELSE null
    END) AS `Jan_Revenue`,
    SUM(CASE 
        WHEN month="Feb" THEN revenue
        ELSE null
    END) AS `Feb_Revenue`,
    SUM(CASE 
        WHEN month="Mar" THEN revenue
        ELSE null
    END) AS `Mar_Revenue`,
    SUM(CASE 
        WHEN month="Apr" THEN revenue
        ELSE null
    END) AS `Apr_Revenue`,
    SUM(CASE 
        WHEN month="May" THEN revenue
        ELSE null
    END) AS `May_Revenue`,
    SUM(CASE 
        WHEN month="Jun" THEN revenue
        ELSE null
    END) AS `Jun_Revenue`,
    SUM(CASE 
        WHEN month="Jul" THEN revenue
        ELSE null
    END) AS `Jul_Revenue`,
    SUM(CASE 
        WHEN month="Aug" THEN revenue
        ELSE null
    END) AS `Aug_Revenue`,
    SUM(CASE 
        WHEN month="Sep" THEN revenue
        ELSE null
    END) AS `Sep_Revenue`,
    SUM(CASE 
        WHEN month="Oct" THEN revenue
        ELSE null
    END) AS `Oct_Revenue`,
    SUM(CASE 
        WHEN month="Nov" THEN revenue
        ELSE null
    END) AS `Nov_Revenue`,
    SUM(CASE 
        WHEN month="Dec" THEN revenue
        ELSE null
    END) AS `Dec_Revenue`
FROM Department
GROUP BY id;
