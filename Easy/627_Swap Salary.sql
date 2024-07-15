-- thought:
-- - regarding the constraints of this problem:
--     (1) only `UPDATE` can be used, `SELECT` is not allowed.
--     (2) temporary tables cannot be used.
-- - therefore, we can follow these steps:
--     (1) use the `UPDATE` statement to update the table.
--     (2) use `CASE WHEN ... THEN ... ELSE ... END` to swap the data in the `sex` column (f <-> m).

UPDATE Salary
SET sex=CASE WHEN sex="m" THEN "f"
    ELSE "m"
END;
