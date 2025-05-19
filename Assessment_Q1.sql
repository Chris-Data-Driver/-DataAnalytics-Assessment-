-- Assessment_Q1.sql
-- Find customers with at least one funded savings plan AND one funded investment plan

use adashi_staging;

-- First let's Get total deposits per user
WITH savings_summary AS (
    SELECT 
        owner_id, 
        SUM(COALESCE(confirmed_amount, 0)) / 100.0 AS total_deposits
    FROM savings_savingsaccount
    GROUP BY owner_id
),

-- secondly let's Get counts of plan types per user
plan_summary AS (
    SELECT 
        owner_id,
        SUM(CASE WHEN is_regular_savings = 1 THEN 1 ELSE 0 END) AS savings_plan_count,
        SUM(CASE WHEN is_a_fund = 1 THEN 1 ELSE 0 END) AS investment_plan_count
    FROM plans_plan
    GROUP BY owner_id
)

-- then Join everything together
SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COALESCE(p.savings_plan_count, 0) AS savings_plan_count,
    COALESCE(p.investment_plan_count, 0) AS investment_plan_count,
    ROUND(COALESCE(s.total_deposits, 0), 2) AS total_deposits
FROM 
    users_customuser u
LEFT JOIN plan_summary p ON u.id = p.owner_id
LEFT JOIN savings_summary s ON u.id = s.owner_id
WHERE p.savings_plan_count > 0 AND p.investment_plan_count > 0
ORDER BY 
    total_deposits DESC;


    
    