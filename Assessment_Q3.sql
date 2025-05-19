-- Assessment_Q3.sql
-- Find accounts with no transactions in the last 365 days

USE adashi_staging;

-- let's find out Inactive Savings Accounts
SELECT 
    s.id AS plan_id,
    s.owner_id,
    'savings' AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days
FROM 
    savings_savingsaccount s
GROUP BY 
    s.id, s.owner_id
HAVING 
    inactivity_days > 365

UNION ALL

-- then find out Inactive Investment Plans

SELECT 
    p.id AS plan_id,
    p.owner_id,
    'investment' AS type,
    MAX(p.start_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(p.start_date)) AS inactivity_days
FROM 
    plans_plan p
WHERE 
    p.is_a_fund = 1
GROUP BY 
    p.id, p.owner_id
HAVING 
    inactivity_days > 365

ORDER BY 
    inactivity_days DESC;
