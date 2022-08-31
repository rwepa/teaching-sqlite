--file     : Chapter 6-SELECT.SQL
--title    : SQLite-06.SELECT查詢
--author   : Ming-Chang Lee
--date     : 2021.12.06
--email    : alan9956@gmail.com
--RWEPA    : http://rwepa.blogspot.tw/
--GitHub   : https://github.com/rwepa
--Encoding : UTF-8

-- Updated : 2022.08.30 -新增 CASE WHEN THEN END 函數

-- Download Northwind and connect database
-- https://github.com/rwepa/teaching-sqlite/blob/main/Northwind.sqlite

-- Alphabetical List Of Documents
-- https://www.sqlite.org/doclist.html

-- Built-In Scalar SQL Functions (純量函數)
-- https://www.sqlite.org/lang_corefunc.html
-- abs, min, max, lower, upper, round, random, substr('字串')

-- Built-In Mathematical SQL Functions (數學函數)
-- https://www.sqlite.org/lang_mathfunc.html
-- sin, cos, exp, log, log2, log10, pi, power(2,3), sqrt(9)

-- Built-in Aggregate Functions (聚合函數)
-- avg(平均值), count(個數), max, min, sum(整數), total(實數)

-- Keyword Index
-- https://www.sqlite.org/keyword_index.html
-- 練習查詢 CAST 線上說明

-- 5個資料類型：
-- 1.NULL    : 空值
-- 2.INTEGER : 整數, 是帶有正負值的整數, 可能會使用 1, 2, 3, 4, 6, 8個位元組(Bytes)來存放資料, 實際使用的Bytes數, 以存放的值來決定.
-- 3.REAL    : 浮點數值。以 8 Bytes來存放 IEEE 浮點數。
-- 4.TEXT    : 文字字串值。以資料庫的文字編碼方式：UTF-8, UTF-16BE, UTF-16LE來儲存資料。
-- 5.BLOB    : 二進位大型物件 (Binary Large OBject)。

SELECT 3+2, 3-2, 3*2, 12/5, 7%4;

SELECT power(2, 3);

SELECT '您好', 'Hello' , 'xin chào', LOWER('ABC');

SELECT * 
FROM Products;

SELECT ProductName, UnitPrice
FROM Products;

SELECT ProductName, UnitPrice, UnitPrice*0.8 AS 折扣價8折
FROM Products;

-- 數值置於前面,須加上 []
SELECT ProductName, CAST(UnitPrice * 0.8 AS INTEGER)  AS  [8折扣價]
FROM Products;

-- DISTINCT 不相同
SELECT DISTINCT SupplierID
FROM Products;

-- LIMIT 限制
SELECT *
FROM Products
LIMIT 5;

-- ORDER BY 排序: 依照 UnitPrice 遞增排序
SELECT *
FROM Products
ORDER BY UnitPrice;

-- ORDER BY 排序: 依照 UnitPrice 遞減排序
SELECT *
FROM Products
ORDER BY UnitPrice DESC;

-- AS 別名
SELECT ProductNAme AS 產品名稱, UnitPrice AS 單價 
FROM Products; 

-- JOIN ON
SELECT * FROM Customers;

SELECT * FROM Orders;

SELECT Customers.CompanyName, Customers.ContactName, Orders.OrderDate
FROM Orders
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID

-- SQLite use standard UNIX time with seconds, the others use milliseconds since 1970.
SELECT OrderDate
FROM Orders
LIMIT 1;

-- 將 秒 資料轉換為 年月日
SELECT strftime('%Y-%m-%d', 1216901515264/1000, 'unixepoch'); -- 2008/07/24

-- 將訂購日期轉換為年月日
SELECT strftime("%Y-%m-%d", OrderDate/1000, 'unixepoch')
FROM Orders;

-- 2個資料表 JOIN ON, Total rows 1030.
-- Customers, Total rows 222.
-- Orders, Total rows 1055.

SELECT Customers.CompanyName, Customers.ContactName, strftime("%Y-%m-%d", Orders.OrderDate/1000, 'unixepoch') AS OrderDate
FROM Customers 
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

-- 練習 Products, Categories 2個資料表 JOIN ON
-- Products(ProductID, ProductName, CategoryID), Categories(CategoryID, CategoryName)

-- LEFT JOIN, Totla rows 1089. Try: RIGHT JOIN, FULL JOIN
SELECT Customers.CompanyName, Customers.ContactName, strftime("%Y-%m-%d", Orders.OrderDate/1000, 'unixepoch') AS OrderDate
FROM Customers 
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

-- WHERE 條件式
SELECT *
FROM Employees
WHERE Country = 'USA';

-- WHERE AND 條件式
SELECT *
FROM Employees
WHERE Country = 'USA' AND TitleOfCourtesy == 'Ms.';

-- WHERE OR 條件式
SELECT *
FROM Employees
WHERE Country = 'USA' OR TitleOfCourtesy == 'Dr.';

-- 依據 CustomerID, GROUP 群組統計訂購次數
SELECT OrderID, CustomerID, COUNT(OrderDate) AS 訂購次數
FROM Orders
GROUP BY CustomerID;

-- 依據 CustomerID, GROUP 群組統計訂購次數, 訂購次數遞減排序
SELECT  OrderID, CustomerID, COUNT(OrderDate) AS 訂購次數
FROM     Orders
GROUP BY  CustomerID
ORDER BY 訂購次數 DESC;

-- 依據 CustomerID, GROUP 群組統計訂購次數, 訂購次數遞減排序, HAVING 條件式
SELECT  OrderID, CustomerID, COUNT(OrderDate) AS 訂購次數
FROM     Orders
GROUP BY  CustomerID
HAVING 訂購次數 > 10
ORDER BY 訂購次數 DESC;

-- CASE WHEN THEN END 函數
SELECT ProductID,
       ProductName,
       UnitPrice,
       CASE 
           WHEN UnitPrice >= 1000 THEN 'High'
           WHEN UnitPrice >= 10 AND UnitPrice < 1000 THEN 'Middle'
           ELSE 'Low'
       END AS PriceType
FROM Products;
