-- Business Analysis

-- Category performance
SELECT
    Category,
    SUM(Amount) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Details
GROUP BY Category
ORDER BY Total_Profit DESC;

-- Loss-making sub-categories
SELECT
    `Sub-Category`,
    SUM(Amount) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Details
GROUP BY `Sub-Category`
HAVING SUM(Profit) < 0
ORDER BY Total_Profit;

-- Customer performance
SELECT
    o.CustomerName,
    SUM(d.Amount) AS Total_Sales,
    SUM(d.Profit) AS Total_Profit
FROM Orders o
JOIN Details d
    ON o.`Order ID` = d.`Order ID`
GROUP BY o.CustomerName
ORDER BY Total_Profit DESC;

-- State performance
SELECT
    o.State,
    SUM(d.Amount) AS Total_Sales,
    SUM(d.Profit) AS Total_Profit
FROM Orders o
JOIN Details d
    ON o.`Order ID` = d.`Order ID`
GROUP BY o.State
ORDER BY Total_Profit DESC;

-- Profit vs Loss classification
SELECT
    `Order ID`,
    Amount,
    Profit,
    CASE
        WHEN Profit < 0 THEN 'Loss'
        ELSE 'Profit'
    END AS Profit_Status
FROM Details;