USE sample_sales;

-- 1. Create a list of all transactions that took place on January 15, 2024, sorted by sale amount from highest to lowest.
SELECT * FROM store_sales
WHERE Transaction_Date >= '2024-01-15'
AND Transaction_Date < '2024-01-16'
ORDER BY Sale_Amount DESC;

-- 2. Which transactions had a sale amount greater than $500? Display the transaction date, store ID, product number, and sale amount.
SELECT
    Transaction_Date,
    Store_ID,
    Prod_Num,
    Sale_Amount
FROM store_sales
WHERE Sale_Amount > 500
ORDER BY Sale_Amount DESC;

-- 4. What is the total sales revenue across all transactions? What is the average transaction amount?
SELECT
    SUM(all_sales.Sale_Amount) AS Total_Revenue,
    ROUND(AVG(all_sales.Sale_Amount), 2) AS Average_Transaction
FROM (
    SELECT Sale_Amount
    FROM store_sales
    UNION ALL
    SELECT SalesTotal AS Sale_Amount
    FROM online_sales
) AS all_sales;

-- 6. Which store generated the highest total revenue? Which generated the lowest?
-- Highest Revenue																											
SELECT
    l.StoreId,
    l.StoreLocation,
    l.State,							
    ROUND(SUM(s.Sale_Amount), 2) AS Total_Revenue
FROM store_sales AS s
JOIN store_locations AS l ON s.Store_ID = l.StoreId
GROUP BY l.StoreId, l.StoreLocation, l.State
ORDER BY Total_Revenue DESC
LIMIT 1;

-- Lowest Revenue
SELECT
    l.StoreId,
    l.StoreLocation,
    l.State,
    ROUND(SUM(s.Sale_Amount), 2) AS Total_Revenue
FROM store_sales AS s
JOIN store_locations AS l ON s.Store_ID = l.StoreId
GROUP BY l.StoreId, l.StoreLocation, l.State
ORDER BY Total_Revenue ASC
LIMIT 1;

-- 8. Which stores had total revenue above $50,000? (Hint: you'll need HAVING.)
SELECT
    l.StoreId,
    l.StoreLocation,
    l.State,
    ROUND(SUM(s.Sale_Amount), 2) AS Total_Revenue
FROM store_sales AS s
JOIN store_locations AS l ON s.Store_ID = l.StoreId
GROUP BY l.StoreId, l.StoreLocation, l.State
HAVING SUM(s.Sale_Amount) > 50000
ORDER BY Total_Revenue DESC;
