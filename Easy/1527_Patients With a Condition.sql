-- thought:
-- - our goal is to filter patients who have Type I Diabetes.
-- - according to the problem description, the `condition` field contains 0 or more codes separated by spaces. Any code indicating Type I Diabetes starts with the `DIAB1` prefix.
-- - there are two scenarios indicating a patient with Type I Diabetes:
--   1. A code starting with the `DIAB1` prefix at the beginning of the field.
--   2. A code with the `DIAB1` prefix appearing after a space, indicating it is not at the beginning of the field.
-- - to achieve this, we can follow these steps:
--   (1) use the `WHERE` clause with `REGEXP` and `OR` to filter all conditions that match the two scenarios above.
--   (2) select all rows (*) that meet the filter criteria.

SELECT *
FROM Patients
WHERE conditions REGEXP "^DIAB1.+"
OR conditions REGEXP ".+[:space:]DIAB1.+";
