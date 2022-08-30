-- title: CASE END 函數
-- date: 2022.8.30
-- 使用 Northwind.sqlite

SELECT ProductID,
       ProductName,
       UnitPrice,
       CASE 
           WHEN UnitPrice >= 1000 THEN 'High'
           WHEN UnitPrice >= 10 AND UnitPrice < 1000 THEN 'Middle'
           ELSE 'Low'
       END AS PriceType
FROM Products;
