# Selecting the given database
USE masai;

# Getting the raw data
SELECT * 
FROM Sales;

# 3 months rolling sum 
SELECT MONTHNAME(Month_) AS  Month_Name, Sales,
SUM(Sales) OVER (ORDER BY Month_ ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
AS '3_Months_Rolling_Sum'
FROM Sales;

# 3 months rolling sum 
SELECT MONTHNAME(Month_) AS  Month_Name, Sales,
SUM(Sales) OVER (ORDER BY Month_ ROWS 2 PRECEDING)
AS '3_Months_Rolling_Sum'
FROM Sales;

# 3 months future avg 
SELECT MONTHNAME(Month_) AS  Month_Name, Sales,
AVG(Sales) OVER (ORDER BY Month_ ROWS BETWEEN 1 FOLLOWING AND 3 FOLLOWING)
AS '3_Months_Future_Avg'
FROM Sales;

# 3 months rolling avg 
SELECT MONTHNAME(Month_) AS  Month_Name, Sales,
AVG(Sales) OVER (ORDER BY Month_ ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
AS '3_Months_Rolling_Avg'
FROM Sales;

# 4 months rolling avg 
SELECT MONTHNAME(Month_) AS  Month_Name, Sales,
AVG(Sales) OVER (ORDER BY Month_ ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING)
AS '4_Months_Rolling_Avg'
FROM Sales;

# Question - Reverse Cumulative Sum
SELECT MONTHNAME(Month_) AS 'Month', Sales,
COUNT(*) OVER (ORDER BY Month_ ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
AS 'Count',
SUM(Sales) OVER (ORDER BY Month_ ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
AS 'Reverse_Cum_Sum'
FROM Sales
ORDER BY MONTH(Month_);

# Question - Cumulative Sum
SELECT MONTHNAME(Month_) AS 'Month', Sales,
COUNT(*) OVER (ORDER BY Month_ ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
AS 'Count',
SUM(Sales) OVER (ORDER BY Month_ ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
AS 'Cum_Sum'
FROM Sales
ORDER BY MONTH(Month_);

# CTE Practice Problem - 
# Calculate the total amount spent by  each customer on orders
# Columns -> FirstName, LastName, Total Spent
# Tables -> Customers, Orders

WITH CustomerSpending AS (
	SELECT CustomerID, SUM(Total_Order_Amount) AS TotalSpent
    FROM Orders
    GROUP BY CustomerID
    )
SELECT c.FirstName, c.LastName, cs.TotalSpent
FROM Customers AS c
JOIN CustomerSpending AS cs
ON c.CustomerID = cs.CustomerID;

# Getting the maximum sales out of 2 previous, current row and 1 following month
SELECT MONTHNAME(Month_) AS  Month_Name, Sales,
MAX(Sales) OVER (ORDER BY Month_ ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING)
AS '3_Months_Max_Sales'
FROM Sales;

# Getting the minimum sales out of 2 previous, current row and 1 following month
SELECT MONTHNAME(Month_) AS  Month_Name, Sales,
MIN(Sales) OVER (ORDER BY Month_ ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING)
AS '3_Months_Min_Sales'
FROM Sales;

# Question - 
# Get all the columns from Orders table along with 
# the average order amount for every customer
# sorted by order date among 4 previous and 1 folloring order date
# and also get the number of orders in that interval as a seperate column

SELECT *, 
AVG(Total_Order_Amount) OVER (PARTITION BY CustomerID ORDER BY OrderDate
ROWS BETWEEN 4 PRECEDING AND 1 FOLLOWING) AS 'Avg_Order_Amount',
COUNT(*) OVER (PARTITION BY CustomerID ORDER BY OrderDate
ROWS BETWEEN 4 PRECEDING AND 1 FOLLOWING) AS 'Numb_of_Orders'
FROM Orders;

# Stored Procedures

SELECT *
FROM Customers 
WHERE City LIKE 'New York';

SELECT *
FROM Customers 
WHERE City LIKE 'Berlin';

# Creating a stored procedure
DELIMITER $$
CREATE PROCEDURE procedure_1 (IN CityName VARCHAR(30))
BEGIN 
SELECT * 
FROM Customers
WHERE City LIKE CityName;
END$$

DELIMITER ;

# Interview Question -> Why do we need to change the delimiter ?
# To make sure that the complete definition of the stored procedure  
# is executed in 1 shot by the SQL Interpreter, 
# we have to change the delimiter

# Creating a stored procedure
DELIMITER //
CREATE PROCEDURE procedure_2 (IN CityName VARCHAR(30))
BEGIN 
SELECT * 
FROM Customers
WHERE City LIKE CityName;
END//

DELIMITER ;

# Using a stored procedure
CALL procedure_1('Berlin');
CALL procedure_2('new York');

# Question -
# Create a stored Procedure which gives all the details of orders 
# For a particular day and above a particular value
# Parameters -> Dayname and Amount
# Table -> Orders

DELIMITER $$
CREATE PROCEDURE Orders_Weekday_Proc
(IN order_amount FLOAT, weekday VARCHAR(30))
BEGIN 
SELECT *, DAYNAME(OrderDate) AS Week_Day
FROM Orders
WHERE Total_Order_Amount >= order_amount 
AND DAYNAME(OrderDate) LIKE weekday;
END$$

DELIMITER ;

# Calling a Stored Procedure
CALL Orders_Weekday_Proc(5000, 'Thursday');

# Dropping Stored Procedure
DROP PROCEDURE Orders_Weekday_Proc;

# Getting an idea about the data
SELECT * 
FROM Products_Prices;

SELECT * 
FROM Products_Owned;

# Example 
SELECT Product,
SUM(CASE WHEN Year = 2012 THEN Price END) AS '2012',
SUM(CASE WHEN Year = 2013 THEN Price END) AS '2013',
SUM(CASE WHEN Year = 2014 THEN Price END) AS '2014',
SUM(CASE WHEN Year = 2015 THEN Price END) AS '2015',
SUM(CASE WHEN Year = 2016 THEN Price END) AS '2016'
FROM Products_Prices
GROUP BY Product
ORDER BY Product;





