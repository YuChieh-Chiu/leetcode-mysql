-- Objective:
-- - Return a table with three categories: `Low Salary`, `Average Salary`, and `High Salary`.
-- - If there are no accounts in a category, return 0 as the count.
-- Information:
-- - The `account_id` serves as the primary key of the table.
-- - "Low Salary": Salaries less than $20,000.  
-- - "Average Salary": Salaries between $20,000 and $50,000 (inclusive).  
-- - "High Salary": Salaries greater than $50,000.  
-- Steps:
-- (1) Use the `WHERE` clause to filter rows into each salary category.  
-- (2) Use the `COUNT()` function to calculate the number of rows in each category.  
-- (3) Use the `UNION` operator to combine the results of all three categories.  

(
    SELECT "Low Salary" AS `category`, COUNT(*) AS `accounts_count`
    FROM Accounts
    WHERE income < 20000
)
UNION
(
    SELECT "Average Salary" AS `category`, COUNT(*) AS `accounts_count`
    FROM Accounts
    WHERE income >= 20000
    AND income <= 50000
)
UNION
(
    SELECT "High Salary" AS `category`, COUNT(*) AS `accounts_count`
    FROM Accounts
    WHERE income > 50000
);
