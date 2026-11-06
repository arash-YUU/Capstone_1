-- Sales territory: Florida
-- Region: South
USE sample_sales;  

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
GROUP BY YEAR(s.Transaction_Date), MONTH(s.Transaction_Date)   
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
ORDER BY Total_Revenue DESC;

-- What is your recommendation for where to focus sales attention in the next quarter? 
 /* 
Based on my results, I recommend focusing next quarter on Florida 
stores with lower sales, especially Naples and Lakeland. Florida 
made $3,930,187.55 from 2022 to 2025, compared with $7,996,850.12 
for the South Region, so Florida is a big part of the region's sales. 

Miami had the highest revenue at $618,846.25, while Naples had 
the lowest at $259,602.83. I think we should look at what Miami 
is doing well and see what could help Naples and Lakeland. 
We should also consider differences in store size and location. 

I would also try promotions during slower sales periods. 
June had the lowest revenue in 2025 at $101,328.59, while October 
had the highest at $188,215.96. Looking into why those months 
were different could help us plan promotions for next quarter. 

Technology & Accessories had the highest average transaction 
amount each month in our results. I recommend keeping popular 
items in stock and trying offers that include related supplies. 

Next quarter, I would check revenue, transaction counts, and 
average transaction amounts to see if these changes are helping. 

*/ 
