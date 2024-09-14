-- Objective:
-- - Our goal is to calculate the average processing time for each machine.
-- Information:
-- - Based on the problem description, the workflow to achieve this is as follows:
--     - First, calculate the processing time for each process running on the machine identified by `machine_id`.
--     - Then, compute the average processing time for all processes on each machine.
--     - Finally, return the average processing time for each `machine_id`.
-- Steps:
-- (1) Use `(timestamp - LAG(timestamp, 1) OVER(PARTITION BY machine_id, process_id ORDER BY timestamp))` to calculate the processing time (end - start) for each `process_id` on each `machine_id`.
-- (2) Use a `WHERE` clause with `IS NOT NULL` to filter out null values.
-- (3) Use `GROUP BY machine_id` and apply `ROUND(AVG(), 3)` to calculate the average processing time, rounding to three decimal places.
-- (4) Return a table with `machine_id` and `processing_time`.

WITH time_per_machine_process AS (
    SELECT machine_id, process_id,
        (timestamp - LAG(timestamp, 1) OVER(PARTITION BY machine_id, process_id ORDER BY timestamp)) AS `per_time`
    FROM Activity
)

SELECT machine_id, 
    ROUND(AVG(per_time), 3) AS `processing_time`
FROM time_per_machine_process
WHERE per_time IS NOT NULL
GROUP BY machine_id
