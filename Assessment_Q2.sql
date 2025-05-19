-- Assessment_Q2.sql
-- Categorize customers by transaction frequency for segmentation analysis

USE adashi_staging;

-- let's Compute average transactions per customer per month and assign frequency categories

WITH customer_frequency AS (
    SELECT 
        owner_id,

        -- Calculate average transactions per month per customer
        ROUND(
            COUNT(id) / GREATEST(TIMESTAMPDIFF(MONTH, MIN(transaction_date), MAX(transaction_date)), 1),
            2
        ) AS avg_txn_per_month,

        CASE 
            WHEN COUNT(id) / GREATEST(TIMESTAMPDIFF(MONTH, MIN(transaction_date), MAX(transaction_date)), 1) >= 10 
                THEN 'High Frequency'
            WHEN COUNT(id) / GREATEST(TIMESTAMPDIFF(MONTH, MIN(transaction_date), MAX(transaction_date)), 1) BETWEEN 3 AND 9 
                THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM 
        savings_savingsaccount
    GROUP BY 
        owner_id
)

-- Let's Summarize the number of customers and average transactions per frequency category
SELECT 
    frequency_category,
    COUNT(owner_id) AS customer_count,                  -- Number of customers in each category
    ROUND(AVG(avg_txn_per_month), 2) AS avg_transactions_per_month  -- Average monthly transactions per category
FROM 
    customer_frequency
GROUP BY 
    frequency_category
ORDER BY 
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');  -- Custom order for clarity
