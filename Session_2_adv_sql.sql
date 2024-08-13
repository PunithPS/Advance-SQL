# Selecting the masai database
USE masai;

# Getting an idea about he orders table
SELECT * 
FROM orders;

# Getting the number of days to deliver
SELECT *, TIMESTAMPDIFF(DAY, OrderDate, DeliveryDate) AS Numb_of_Days
FROM orders;

# Getting the number of weeks to deliver
SELECT *, TIMESTAMPDIFF(WEEK, OrderDate, DeliveryDate) AS Numb_of_Weeks
FROM orders;

# TIMESTAMPDIFF Syntax -> (Unit, Date_1, Date_2) 

SELECT TIMESTAMPDIFF(DAY, '2024-01-01', '2024-01-31') AS output;

# Problem - 
# Write a query to get the CustomerID, Customer FirstName and
# Average number of Days required to deliver the order

SELECT a.CustomerID, a.FirstName,
AVG(TIMESTAMPDIFF(DAY, OrderDate, DeliveryDate)) AS Avg_Delivery_Days
FROM Customers AS a
JOIN Orders AS b
ON a.CustomerID = b.CustomerID
GROUP BY a.CustomerID, a.FirstName
ORDER BY Avg_Delivery_Days DESC;

# Casting the datatype
SELECT *,
CAST(TIMESTAMPDIFF(DAY, OrderDate, DeliveryDate) AS SIGNED) AS Num_of_Days
FROM Orders;

# Signed means signed integers (Positive and Negative)

# Casting the datatype
SELECT *,
CAST(TIMESTAMPDIFF(DAY, OrderDate, DeliveryDate) AS UNSIGNED) AS Num_of_Days
FROM Orders;

# Unsigned means unsigned integers (Only Positive Integers)

# Getting an idea about Customers
SELECT * 
FROM Customers;

SELECT CustomerID, FirstName, LastName,
Date_of_Birth, CAST(Date_of_Birth AS DATE) AS DOB
FROM Customers;

# Using CONCAT Function
SELECT CONCAT(CAST(1 AS NCHAR), ' plus ', CAST(2 AS NCHAR), ' is three.') AS output;
SELECT CONCAT(CONVERT(1, NCHAR), ' plus ', CONVERT(2, NCHAR), ' is three.') AS output;

# Homework -> Find the difference between CAST and CONVERT function

# Problem - 
# Write a query that gives a staement like - 
# 'The total amount spent by Customer_Full_Name is XYZ.'

SELECT a.CustomerID, CONCAT(a.FirstName, ' ', a.LastName) AS Full_Name, 
SUM(total_order_amount) AS Total_Spent
FROM Customers AS a
JOIN orders AS b
ON a.CustomerID = b.CustomerID
GROUP BY a.CustomerID, a.FirstName;

SELECT CONCAT('The total amount spent by ', Full_Name, ' is ', Total_Spent) AS Output
FROM (
	SELECT a.CustomerID, CONCAT(a.FirstName, ' ', a.LastName) AS Full_Name, 
	SUM(total_order_amount) AS Total_Spent
	FROM Customers AS a
	JOIN orders AS b
	ON a.CustomerID = b.CustomerID
	GROUP BY a.CustomerID, a.FirstName
    ) AS t;

# Filtering based on CAST/CONVERT
SELECT a.CustomerID, a.FirstName, SUM(total_order_amount) AS Total_Spent
FROM Customers AS a
JOIN Orders AS b
ON a.CustomerID = b.CustomerID
GROUP BY a.CustomerID, a.FirstName
HAVING CAST(SUM(total_order_amount) AS NCHAR) LIKE '30%';

# Homework -> Find the difference between CHAR, NCHAR, VARCHAR

# IFNULL, COALESCE -> Dealing 

SELECT COALESCE(NULL, NULL, 2, 'Hi') AS output;
SELECT IFNULL(NULL, 2) AS output;
SELECT IFNULL(1, 2) AS output;

# Coalesce -> Selects the first non-null entry 
# IF NULL -> Replaces the null values (if found) in the first entry with second entry

# Getting the data from Customers
SELECT * 
FROM Customers;

# Inserting the data
INSERT INTO Customers (CustomerID, FirstName, City)
VALUES
(1, 'Prateek', 'Bangalore');

# Getting the data from Customers
SELECT * 
FROM Customers;

# Getting the full name
SELECT CONCAT(FirstName, ' ', LastName) AS Full_Name 
FROM Customers;

# Getting the full name
SELECT CONCAT(FirstName, ' ', COALESCE(LastName, '')) AS Full_Name 
FROM Customers;

# Getting the full name
SELECT CONCAT(FirstName, ' ', IFNULL(LastName, '')) AS Full_Name 
FROM Customers;

# String Functions 

# Substring 
SELECT CONCAT('The first 3 letters in the name of ', 
FirstName, ' are ', SUBSTRING(FirstName, 1, 3)) AS output
FROM Customers;

# Substring Syntax -> (Data, Starting Index, Stopping Index)

# LENGTH()
SELECT *, LENGTH(FirstName) AS FirstName_Length
FROM Customers;

# Question -
SELECT * 
FROM Customers
ORDER BY SUBSTRING(FirstName, LENGTH(FirstName) - 2, LENGTH(FirstName));

# Question -
SELECT * 
FROM Customers
ORDER BY RIGHT(FirstName, 3);

# Question -
SELECT * 
FROM Customers
ORDER BY LEFT(FirstName, 3);

# REPLACE()
SELECT REPLACE(FirstName, 'a', 'A') AS output
FROM Customers;

SELECT REPLACE('Hello World !', 'Hello ', '') AS output;

# Replace Syntax -> (Data, Value to be replaced, Value with which we will replace)

# TRIM() Function -> Used to remove extra spaces

SELECT TRIM('		There is a lot of empty space.		') AS output;
SELECT LTRIM('		There is a lot of empty space.		') AS output;
SELECT RTRIM('		There is a lot of empty space.		') AS output;

# UPPER() and LOWER()
SELECT LOWER(FirstName) AS FirstName, UPPER(LastName) AS LastName
FROM Customers;

# Research about how to get only first character in capital

# REPEAT() 
# Syntax -> (Value to be repeated, Number of times to be repeated)

SELECT REPEAT('0', 5) AS output;

# Question -
SELECT CONCAT(REPEAT('0', 5), SUBSTRING(FirstName, 1, 3), 
CAST(CustomerID AS NCHAR), SUBSTRING(LastName, 1, 4), REPEAT('1', 4)) AS output
FROM Customers;

# POSITION() - Return the index of the element (first found)
# Syntax -> Position(X IN Data)

SELECT POSITION('Hello' IN 'This is a Hello World Program') AS output;
SELECT POSITION('hi' IN 'This is a Hello World Program') AS output;
