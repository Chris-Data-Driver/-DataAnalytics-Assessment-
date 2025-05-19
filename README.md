# -DataAnalytics-Assessment-

  1. ### Assessment_Q1.sql
     **Find customers with at least one funded savings plan AND one funded investment plan**
      The approach used is
      A. Use of Common Table Expressions (CTEs) for Modularization
      Two CTEs are used to prepare the data in a clean and structured manner:
      B. joined the CTEs with the main table 
      C. lastly ordered by total deposits 


2. ### Assessment_Q2.sql
   **Categorize customers by transaction frequency for segmentation analysis**
   The approach used is
   A. Use of Common Table Expression (CTE) for Preprocessing. A single CTE named customer_frequency is created to compute average transaction frequency per customer.
   B. Used Main Query to Aggregate Insights
   C. use of Custom Sorting for Clarity

3. ### Assessment_Q3.sql
   **Find accounts with no transactions in the last 365 days**
   A. Identified Inactive Savings Accounts.
   B. Identified Inactive Investment Plans.
   C. Combined Results Using UNION ALL.
   D. Final Ordering: The output is sorted by inactivity_days in descending order to highlight the most inactive accounts first.

4. ### Assessment_Q4.sql
   **Calculate Customer Lifetime Value**
   A.Joined Users and Transactions.
   B.Calculated Customer Tenure.Tenure is calculated in months using TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()).
   C. Counted Total Transactions: The total number of savings transactions per customer is counted using COUNT(s.id)
   D.Estimate CLV: CLV is estimated using the formula:
   CLV = (Total Transactions/Tenure) × 12 × Avg Profit per Transaction.
