# Selecting the given database
USE masai;

# Datetime Functions 
SELECT CURRENT_DATE() AS today;
SELECT NOW() AS datetime_today;

SELECT DAY(CURRENT_DATE()) AS day_today,
WEEK(CURRENT_DATE()) AS week_today,
MONTH(CURRENT_DATE()) AS month_today,
QUARTER(CURRENT_DATE()) AS quarter_today,
YEAR(CURRENT_DATE()) AS year_today,
MONTHNAME(CURRENT_DATE()) AS monthname_today,
DAYNAME(CURRENT_DATE()) AS dayname_today;

SELECT FirstName, Date_of_Birth,
DAY(Date_of_Birth) AS Day_of_Birth,
WEEK(Date_of_Birth) AS Week_of_Birth,
MONTH(Date_of_Birth) AS Month_of_Birth,
QUARTER(Date_of_Birth) AS Quarter_of_Birth,
YEAR(Date_of_Birth) AS Year_of_Birth,
DAYNAME(Date_of_Birth) AS DayName_of_Birth,
MONTHNAME(Date_of_Birth) AS MonthName_of_Birth
FROM Customers;

# Question -
# Getting the count of people born on different days
# Table -> Customers

SELECT DAYNAME(Date_of_Birth) AS Day_Name,
COUNT(*) AS Count
FROM Customers
GROUP BY DAYNAME(Date_of_Birth);

# Question -
# Getting the count of people born on different months
# Table -> Customers

SELECT MONTHNAME(Date_of_Birth) AS Month_Name,
COUNT(*) AS Count
FROM Customers
GROUP BY MONTHNAME(Date_of_Birth);

# Question - 
# Getting the count of people born in May and October
# Table - Customers

SELECT MONTHNAME(Date_of_Birth) AS Month_Name,
COUNT(*) AS Count
FROM Customers
GROUP BY MONTHNAME(Date_of_Birth)
HAVING Month_Name IN ('May', 'October');

SELECT MONTHNAME(Date_of_Birth) AS Month_Name,
COUNT(*) AS Count
FROM Customers
WHERE MONTH(Date_of_Birth) IN (5, 10)
GROUP BY MONTHNAME(Date_of_Birth);

# Getting the year wise, quarter wise total sales 
# Table - Orders
SELECT YEAR(OrderDate) AS Year_, QUARTER(OrderDate) AS Quarter_,
SUM(total_order_amount) AS Total_Sales
FROM Orders
GROUP BY YEAR(OrderDate), QUARTER(OrderDate)
ORDER BY YEAR(OrderDate), QUARTER(OrderDate);

# DATEDIFF
SELECT DATEDIFF('2022-04-30', '2022-03-31') AS output;

# Getting the delivery days
SELECT *, DATEDIFF(DeliveryDate, OrderDate) AS Delivery_Days
FROM Orders;

SELECT *, DATEDIFF(OrderDate, DeliveryDate) AS Delivery_Days
FROM Orders;

# Getting the first order date of every customer
SELECT CustomerID, MIN(OrderDate) AS First_Order_Date
FROM Orders
GROUP BY CustomerID
ORDER BY CustomerID;

# Getting the most recent order date for every customer
SELECT CustomerID, MAX(OrderDate) AS Recent_Order_Date
FROM Orders
GROUP BY CustomerID
ORDER BY CustomerID;

# Join()
SELECT b.CustomerID, FirstName, LastName, MAX(OrderDate) AS Recent_Order_Date
FROM Orders AS a
JOIN Customers AS b
ON a.CustomerID = b.CustomerID
GROUP BY b.CustomerID, FirstName, LastName
ORDER BY b.CustomerID;

# Self Join Example 
# Getting unique combination of customers from same city 
SELECT a.FirstName AS Customer_A_FirstName,
a.LastName AS Customer_A_LastName,
b.FirstName AS Customer_B_FirstName,
b.LastName AS Customer_B_LastName,
a.city AS City_of_Customer_A, 
b.city AS City_of_Customer_B
FROM Customers AS a
JOIN Customers AS b 
ON a.city = b.city
WHERE a.FirstName <> b.FirstName AND a.LastName <> b.LastName;

# Getting unique combination of customers from Dublin, Belfast 
SELECT a.FirstName AS Customer_A_FirstName,
a.LastName AS Customer_A_LastName,
b.FirstName AS Customer_B_FirstName,
b.LastName AS Customer_B_LastName,
a.city AS City_of_Customer_A, 
b.city AS City_of_Customer_B
FROM Customers AS a
JOIN Customers AS b 
ON a.city = b.city
WHERE a.FirstName <> b.FirstName AND a.LastName <> b.LastName AND
a.city IN ('Belfast', 'Dublin');

# Common Table Expressions 
SELECT * FROM Orders;
SELECT * FROM Payments;
SELECT * FROM Customers;

# Join Query
SELECT a.OrderID, c.FirstName, c.LastName, b.PaymentID, 
a.CustomerID, Total_Order_Amount, b.PaymentType
FROM Orders AS a
JOIN Payments AS b 
ON a.PaymentID = b.PaymentID
JOIN Customers AS c
ON a.CustomerID = c.CustomerID;

# CTE 
WITH Order_Payments_Info AS (
SELECT a.OrderID, b.PaymentID, a.CustomerID,
Total_Order_Amount, b.PaymentType
FROM Orders AS a
JOIN Payments AS b
ON a.PaymentID = b.PaymentID
)
SELECT d.*, e.FirstName, e.LastName
FROM Customers AS e
JOIN Order_Payments_Info AS d
on e.CustomerID = d.CustomerID;

# Benefits of CTE -> Complex Problems, Easy to integrate, Memory Efficient

# Views -> Virtual Table, Stored as a physical object in the memory

SELECT *, DAYNAME(OrderDate) AS Week_Day_of_Orders
FROM Orders
WHERE DAYNAME(OrderDate) IN ('Saturday', 'Sunday');

# Creating a view
CREATE VIEW weekend_orders AS 
SELECT *, DAYNAME(OrderDate) AS Week_Day_of_Orders
FROM Orders
WHERE DAYNAME(OrderDate) IN ('Saturday', 'Sunday');

# Getting the data
SELECT * 
FROM weekend_orders;

# Filtering the data 
SELECT * FROM weekend_orders
WHERE PaymentID = 2;

# Join 
SELECT a.*, b.PaymentType
FROM weekend_orders AS a 
JOIN Payments AS b
ON a.PaymentID = b.PaymentID;

# Altering the view
ALTER VIEW weekend_orders AS 
SELECT *, DAYNAME(OrderDate) AS Week_Day_of_Orders
FROM Orders
WHERE DAYNAME(OrderDate) IN ('Saturday', 'Sunday')
AND Total_Order_Amount >= 20000;

# Getting the data from the view
SELECT * 
FROM weekend_orders;

# Renaming a view
RENAME TABLE weekend_orders
TO newView;

# Getting the data from the view
SELECT * 
FROM newView;

# Dropping a view
DROP VIEW newView;
