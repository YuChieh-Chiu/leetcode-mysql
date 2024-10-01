-- Objective:
-- - Our goal is to count the number of distinct `lead_id` and distinct `partner_id` for each `date_id` and `make_name`.
--     - Note that `lead_id` and `partner_id` should be deduplicated separately.
-- Information:
-- - Based on the problem description, the information for the `DailySales` table is as follows:
--     - It may contain duplicates.
-- Steps:
-- (1) GROUP BY `date_id` and `make_name`.
-- (2) Use COUNT(DISTINCT column) on `lead_id` and `partner_id` separately.

SELECT date_id, make_name, 
    COUNT(DISTINCT lead_id) AS `unique_leads`,
    COUNT(DISTINCT partner_id) AS `unique_partners`
FROM DailySales
GROUP BY date_id, make_name
