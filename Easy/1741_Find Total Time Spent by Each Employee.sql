-- Objective:
-- - To calculate the total time in minutes spent by each employee on each day.
-- Information:
-- - Within one day, an employee can enter and leave more than once.
-- - It is guaranteed that no two events for the same employee on the same day overlap in time.
-- - in_time < out_time
-- Steps:
-- (1) Subtract out_time from in_time to calculate the time spent for each row.
-- (2) `GROUP BY` each emp_id and event_day to get the `SUM` of all time spent.

SELECT e.event_day AS `day`, e.emp_id, SUM(e.time_spent) AS `total_time`
FROM (
    SELECT *,
        (out_time - in_time) AS `time_spent`
    FROM Employees
) AS e
GROUP BY e.event_day, e.emp_id;
