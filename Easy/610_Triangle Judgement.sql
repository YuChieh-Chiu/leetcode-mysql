-- thought:
-- - definition of a triangle: The sum of any two sides must be greater than the third side.
-- - therefore, we can follow these steps:
--     (1) Use `CASE WHEN ... THEN ... ELSE ... END AS 'triangle'` to determine if it is a triangle
--     (2) Include the condition `a + b > c AND a + c > b AND b + c > a` in step (1)

SELECT *,
    CASE
        WHEN (x+y>z) AND (x+z>y) AND (y+z>x) THEN "Yes"
        ELSE "No"
    END AS `triangle`
FROM Triangle;
