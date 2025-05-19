-- Assessment_Q4.sql
-- Calculate Customer Lifetime Value

USE adashi_staging;

SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    
    COUNT(s.id) AS total_transactions,
    
    -- Estimated CLV using the formula: (total_transactions / tenure) * 12 * avg_profit_per_transaction
    ROUND((
        (COUNT(s.id) / GREATEST(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 1)) 
        * 12 
        * (AVG(s.confirmed_amount) * 0.001)
    ), 2) AS estimated_clv

FROM 
    users_customuser u

LEFT JOIN 
    savings_savingsaccount s ON u.id = s.owner_id

GROUP BY 
    u.id, u.first_name, u.last_name, u.date_joined

ORDER BY 
    estimated_clv DESC;
