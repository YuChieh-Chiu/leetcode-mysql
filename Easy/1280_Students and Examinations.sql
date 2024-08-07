-- thought:
-- - our goal is to combine multiple tables and determine how often each student attended each exam.
-- - note the problem descriptions:
--     # "each student takes every course from the Subjects table" implies that we need all possible combinations of `Students` and `Subjects`.
--     # "find the number of times each student attended each exam" means that even zero attendance should be recorded in the result table.
-- - therefore, we can follow these steps:
--     (1) handle the possible `null` value in student_name column with `CASE WHEN ... THEN ... ELSE ... END AS ...`
--     (2) use a `CROSS JOIN` between Students and Subjects to generate all possible combinations.
--     (3) perform a `LEFT JOIN` of Examinations with Students.
--     (4) `GROUP BY` student_id and subject_name to calculate the attendance count for each student and exam using `COUNT()`.
--     (5) use a `LEFT JOIN` and `IS NULL` to identify subjects that students did not attend, assigning a count of zero to the `attended_exams` column.
--     (6) `UNION` the results from steps (3) and (4), then `ORDER BY` student_id and subject_name to obtain the final result table
--             # remember to transform the null value in (1) back to `null`

WITH Students AS (
    SELECT student_id,
        CASE
            WHEN student_name IS NULL THEN "missed"
            ELSE student_name
        END AS `student_name`
    FROM Students
), all_possible AS (
    SELECT *
    FROM Students
    CROSS JOIN Subjects
), attend AS (
    SELECT e.student_id, s.student_name, e.subject_name, 
        COUNT(e.subject_name) AS `attended_exams`
    FROM Examinations AS e
    LEFT JOIN Students AS s
    ON e.student_id = s.student_id
    GROUP BY e.student_id, s.student_name, e.subject_name
), not_attend AS (
    SELECT ap.student_id, ap.student_name, ap.subject_name,
        0 AS `attended_exams`
    FROM all_possible AS ap
    LEFT JOIN attend AS a
    ON ap.student_id = a.student_id
    AND ap.student_name = a.student_name
    AND ap.subject_name = a.subject_name
    WHERE a.student_id IS NULL
    AND a.student_name IS NULL
    AND a.subject_name IS NULL
)

SELECT student_id,
    CASE
        WHEN student_name = "missed" THEN NULL
        ELSE student_name
    END AS `student_name`,
    subject_name,
    attended_exams
FROM attend
UNION
SELECT student_id,
    CASE
        WHEN student_name = "missed" THEN NULL
        ELSE student_name
    END AS `student_name`,
    subject_name,
    attended_exams
FROM not_attend
ORDER BY student_id, subject_name;
