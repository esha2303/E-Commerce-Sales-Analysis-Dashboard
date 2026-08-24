-- Advanced SQL Analysis

-- 1. Category ranking
WITH category_profit AS (
    SELECT
        Category,
        SUM(Amount) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM Details
    GROUP BY Category
)
SELECT
    Category,
    Total_Sales,
    Total_Profit,
    RANK() OVER (ORDER BY Total_Profit DESC) AS Profit_Rank
FROM category_profit
ORDER BY Profit_Rank;


-- 2. Month-over-Month profit
WITH monthly_profit AS (
    SELECT
        MONTH(o.`Order Date`) AS Month,
        SUM(d.Profit) AS Total_Profit
    FROM Orders o
    JOIN Details d
        ON o.`Order ID` = d.`Order ID`
    GROUP BY MONTH(o.`Order Date`)
)
SELECT
    Month,
    Total_Profit,
    LAG(Total_Profit) OVER (ORDER BY Month) AS Previous_Month_Profit,
    Total_Profit - LAG(Total_Profit) OVER (ORDER BY Month) AS Profit_Change
FROM monthly_profit
ORDER BY Month;


-- 3. Running total of sales
WITH monthly_sales AS (
    SELECT
        MONTH(o.`Order Date`) AS Month,
        SUM(d.Amount) AS Total_Sales
    FROM Orders o
    JOIN Details d
        ON o.`Order ID` = d.`Order ID`
    GROUP BY MONTH(o.`Order Date`)
)
SELECT
    Month,
    Total_Sales,
    SUM(Total_Sales) OVER (ORDER BY Month) AS Running_Total_Sales
FROM monthly_sales
ORDER BY Month;


-- 4. Top 5 customers by profit
SELECT
    o.CustomerName,
    SUM(d.Amount) AS Total_Sales,
    SUM(d.Profit) AS Total_Profit,
    DENSE_RANK() OVER (ORDER BY SUM(d.Profit) DESC) AS Customer_Rank
FROM Orders o
JOIN Details d
    ON o.`Order ID` = d.`Order ID`
GROUP BY o.CustomerName
ORDER BY Customer_Rank
LIMIT 5;