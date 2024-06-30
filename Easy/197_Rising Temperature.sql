-- thought:
-- - use `ORDER BY` to sort the table by `recordDate`
-- - use `LAG()` & `DATEDIFF()` to calculate the delta date between row and last row
-- - use `LAG()` to calculate the delta temperature between row and last row
-- - use `WHERE` to filter the rows fullfill the following conditions 
--     - the value in `date_diff` column == 1 (delta date == 1)
--     - the value in `temp_diff` column > 0 (temperature is higher)

WITH rising AS (
    SELECT id, 
        DATEDIFF(recordDate, LAG(recordDate, 1) OVER(ORDER BY recordDate)) AS "date_diff",
        temperature - LAG(temperature) OVER(ORDER BY recordDate) AS "temp_diff"
    FROM Weather
)

SELECT id
FROM rising
WHERE date_diff = 1
AND temp_diff > 0;
