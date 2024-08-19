-- thought:
-- - from the problem description, we can infer the following:
--     - (stock_name, operation_day) forms the primary key; both fields should be NOT NULL.
--     - it is guaranteed that each 'Sell' operation for a stock has a corresponding 'Buy' operation on a previous day. Likewise, each 'Buy' operation for a stock has a corresponding 'Sell' operation on a later day. Thus, the operations must follow a `Buy -> Sell -> Buy -> Sell -> ...` sequence. 
-- - therefore, we can proceed with these steps:
--     1. `ORDER BY` operation_day.
--     2. use `price - LAG(price, 1)` with `PARTITION BY` to calculate the price difference between consecutive rows for each stock_name.
--     3. apply `RowNumber`, `PARTITION BY`, and `WHERE` to filter the even-numbered rows, capturing the price difference between the 'Sell' and 'Buy' operations for each stock_name.
--     4. `GROUP BY` stock_name and `SUM` the capital gains or losses for each stock.

WITH delta AS (
    SELECT *, 
        ROW_NUMBER() OVER(PARTITION BY stock_name ORDER BY operation_day) AS `row_num`,
        price - LAG(price, 1) OVER(PARTITION BY stock_name ORDER BY operation_day) AS `delta_price` 
    FROM Stocks
    ORDER BY operation_day
)

SELECT stock_name, SUM(delta_price) AS `capital_gain_loss`
FROM delta
WHERE row_num % 2 = 0
GROUP BY stock_name;
