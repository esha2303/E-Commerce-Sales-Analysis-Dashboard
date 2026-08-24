-- Basic Analysis
SELECT * FROM Orders LIMIT 10;

SELECT
    SUM(Amount) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity
FROM Details;

SELECT
    Category,
    SUM(Amount) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity
FROM Details
GROUP BY Category
ORDER BY Total_Profit DESC;

SELECT
    `Sub-Category`,
    SUM(Amount) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Details
GROUP BY `Sub-Category`
HAVING SUM(Profit) < 0
ORDER BY Total_Profit;