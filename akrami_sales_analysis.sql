USE sample_sales;  

SHOW TABLES;  

-- What is total revenue overall for sales in the assigned territory, plus the start date and end date that tell you what period the data covers?  

SELECT  
	SUM(s.Sale_Amount) AS Total_Revenue,   
	MIN(s.Transaction_Date) AS Start_Date,   
	MAX(s.Transaction_Date) AS End_Date   
FROM store_sales AS s  
JOIN store_locations AS l ON s.Store_ID = l.StoreId  
WHERE l.State = 'Florida';  

-- What is the revenue breakdown by year and month for the sales territory?  
SELECT  
	YEAR(s.Transaction_Date) AS Sales_Year,   
	MONTH(s.Transaction_Date) AS Sales_Month,   
	SUM(s.Sale_Amount) AS Total_Revenue   
FROM store_sales AS s  
JOIN store_locations AS l ON s.Store_ID = l.StoreId  
WHERE l.State = 'Florida'  
GROUP BY YEAR(s.Transaction_Date),   
MONTH(s.Transaction_Date)   
ORDER BY Sales_Year, Sales_Month;  

-- Provide a comparison of total revenue for the specific sales territory and the region it belongs to.  
-- Florida Revenue  

SELECT SUM(s.Sale_Amount) AS Florida_Revenue  
FROM store_sales AS s  
JOIN store_locations AS l ON s.Store_ID = l.StoreId  
WHERE l.State = 'Florida';  

-- South Region Revenue  
SELECT SUM(s.Sale_Amount) AS South_Revenue  
FROM store_sales AS s  
JOIN store_locations AS l ON s.Store_ID = l.StoreId  
JOIN management AS m ON l.State = m.State  
WHERE m.Region = 'South';  

-- What is the number of transactions per month and average transaction amount by product category for the sales territory?  
SELECT 
	YEAR(s.Transaction_Date) AS Sales_Year, 
	MONTH(s.Transaction_Date) AS Sales_Month, 
    c.Category, 
    COUNT(*) AS Total_Transactions, 
    ROUND(AVG(s.Sale_Amount), 2) AS Average_Transaction 
FROM store_sales AS s 
JOIN store_locations AS l ON s.Store_ID = l.StoreId 
JOIN products AS p ON s.Prod_Num = p.ProdNum 
JOIN inventory_categories AS c ON p.Categoryid = c.Categoryid 
WHERE l.State = 'Florida' 
GROUP BY 
	YEAR(s.Transaction_Date), 
	MONTH(s.Transaction_Date), 
    c.Category 
    ORDER BY Sales_Year, Sales_Month; 

-- Can you provide a ranking of in-store sales performance by each store in the sales territory, or a ranking of online sales performance by state within an online sales territory?  
SELECT 
	l.StoreId,
    l.StoreLocation, 
    SUM(s.Sale_Amount) AS Total_Revenue 
FROM store_sales AS s 
JOIN store_locations AS l ON s.Store_ID = l.StoreId 
WHERE l.State = 'Florida' 
GROUP BY l.StoreId, l.StoreLocation 
ORDER BY Total_Revenue DESC

-- What is your recommendation for where to focus sales attention in the next quarter? 
 