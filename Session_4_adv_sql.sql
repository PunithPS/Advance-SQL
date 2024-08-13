# Selecting the masai database 
USE masai;

# Getting an idea abou tcustomers table
SELECT * 
FROM Customers;

# Getting the number of customers from each country
SELECT Country, COUNT(*) AS Numb_of_People 
FROM Customers
GROUP BY Country
ORDER BY Country;

# Window Function
# When you don't want to group the non aggregated columns, then window functions help
# Eliminates the need for group by

SELECT *, COUNT(*) OVER (PARTITION BY Country) AS Numb_of_People_Country
FROM Customers;

SELECT *, COUNT(*) OVER () AS Numb_of_Total_People
FROM Customers;

# Getting an idea about Orders table
SELECT * 
FROM Orders;

# Getting the number of orders made by every customer
# along with all the columns of Orders table
SELECT *, COUNT(*) OVER (PARTITION BY CustomerID) AS Numb_Orders_Customer
FROM Orders;

# Getting the first order date of every customer
# along with all the columns of Orders table
SELECT *, MIN(OrderDate) OVER (PARTITION BY CustomerID) AS First_Order_Date
FROM Orders;

# Mixing Sub Queries with Window Functions
SELECT * 
FROM 
	(
    SELECT *, MIN(OrderDate) OVER (PARTITION BY CustomerID) AS First_Order_Date
	FROM Orders)
    AS c;

# Getting the CustomerID, FirstOrderDate and Number of Orders on FirstOrderDate
SELECT CustomerID, OrderDate, COUNT(*) AS Num_Orders_on_First_Date 
FROM 
	(SELECT * 
    FROM (
		SELECT *, MIN(OrderDate) OVER (PARTITION BY CustomerID) AS First_Order_Date
		FROM Orders) AS c
	WHERE OrderDate = First_Order_Date) AS d
GROUP BY CustomerID, OrderDate
ORDER BY Num_Orders_on_First_Date DESC;

# Rank() Function 
SELECT *, 
RANK() OVER (PARTITION BY CustomerID ORDER BY Total_Order_Amount DESC) AS rank_
FROM Orders;

SELECT *, 
RANK() OVER (PARTITION BY CustomerID ORDER BY Total_Order_Amount ASC) AS rank_
FROM Orders;

# Getting the details of cheapest order made by every customer
SELECT * 
FROM (
	SELECT *, 
	RANK() OVER (PARTITION BY CustomerID ORDER BY Total_Order_Amount ASC) AS rank_
	FROM Orders) 
    AS c
WHERE rank_ = 1;

# Getting the details of most expensive order made by every customer
SELECT * 
FROM (
	SELECT *, 
	RANK() OVER (PARTITION BY CustomerID ORDER BY Total_Order_Amount DESC) AS rank_
	FROM Orders) 
    AS c
WHERE rank_ = 1;

# Dense_Rank() Function 
SELECT *, 
DENSE_RANK() OVER (PARTITION BY CustomerID ORDER BY Total_Order_Amount DESC) AS rank_
FROM Orders;

SELECT *, 
DENSE_RANK() OVER (PARTITION BY CustomerID ORDER BY Total_Order_Amount ASC) AS rank_
FROM Orders;

# Key Interview Question -> What is the difference between rank and dense_rank ?

# ROW_NUMBER() -> assing a sequence of integers
SELECT *, 
ROW_NUMBER() OVER (ORDER BY DateEntered DESC) AS serial_number
FROM Customers;

SELECT *, 
ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY DateEntered DESC) AS serial_number
FROM Customers;

# Getting an idea about the tables
SELECT * 
FROM YearSales;

SELECT * 
FROM Students;

# Get all the columns from students table 
# along with rank given to the rows according to the marks in desc order
SELECT *, RANK() OVER(ORDER BY Marks DESC) AS rank_
FROM Students;

SELECT *, RANK() OVER(PARTITION BY Class ORDER BY Marks DESC) AS rank_
FROM Students;

# Get all the columns from students table 
# 2 columns, 1 for rank and 1 for dense_rank
SELECT *, RANK() OVER(PARTITION BY Class ORDER BY Marks DESC) AS rank_, 
DENSE_RANK() OVER(PARTITION BY Class ORDER BY Marks DESC) AS dense_rank_ 
FROM Students;

# Combining Window Functions with CTE
# Getting the first and second ranked students
WITH cte AS (
	SELECT *, RANK() OVER(PARTITION BY Class ORDER BY Marks DESC) AS rank_
	FROM Students)
SELECT *
FROM cte 
WHERE rank_ < 3;

# Combining Window Functions with Sub Queries
# Getting the first and second ranked students

SELECT * 
FROM (
	SELECT *, RANK() OVER(PARTITION BY Class ORDER BY Marks DESC) AS rank_
	FROM Students) AS c
WHERE rank_ < 3;

# Allocate ROW_NUMBER() depending on marks in descending order
SELECT *, ROW_NUMBER() OVER (ORDER BY marks DESC) AS row_numb
FROM Students;

# Allocate ROW_NUMBER() depending on marks for every class in descending order
SELECT *, ROW_NUMBER() OVER (PARTITION BY class ORDER BY marks DESC) AS row_numb
FROM Students;

# NTILE -> after sorting/partiitoning the data ,
# if we want to create groups/buckets in the data

SELECT COUNT(*) AS Number_of_Rows
FROM Students;

SELECT *, NTILE(2) OVER(ORDER BY Marks DESC) AS Bucket_Number
FROM Students;

SELECT *, NTILE(3) OVER(ORDER BY Marks DESC) AS Bucket_Number
FROM Students;

# If the number of total rows is not divisible by numbe rof buckets
# then, the birst bucket will get higher data points, then second and so on and so forth

SELECT *, NTILE(2) OVER(PARTITION BY Class ORDER BY Marks DESC) AS Bucket_Number
FROM Students;

# LEAD() and LAG()
SELECT * 
FROM YearSales;

SELECT *, LAG(Sales) OVER (ORDER BY Year, Quarter) AS Previous_Sales
FROM YearSales;

# Since 2011, is the first year, hence first quarter of 2011 has null in previous_sales

SELECT *, 
LAG(Sales) OVER (PARTITION BY Year ORDER BY Year, Quarter) AS Previous_Sales
FROM YearSales;

# Since, you have partitioned the data, 
# you will get null entry in the first row for that year

SELECT *, LEAD(Sales) OVER (ORDER BY Year, Quarter) AS Next_Sales
FROM YearSales;

# Since, 2nd quarter of 2014 is the last entry, 
# hence we are having null value for it

SELECT *, 
LEAD(Sales) OVER (PARTITION BY Year ORDER BY Year, Quarter) AS Next_Sales
FROM YearSales;

# Modifying the above query 
SELECT *, 
LEAD(Sales, 1, 0) OVER (ORDER BY Year, Quarter) AS Next_Sales
FROM YearSales;

# 1 -> Spacing 
# 0 -> Null Value Imputation

# Modifying the above query 
SELECT *, 
LEAD(Sales, 2, 0) OVER (ORDER BY Year, Quarter) AS Next_Sales
FROM YearSales;

# 2 -> Spacing 

# Cumulative SUM, AVG using Window Functions 
SELECT * 
FROM Sales;

# Query 
SELECT *, SUM(Sales) OVER() AS Total_Sales
FROM Sales;

SELECT MONTHNAME(Month_) AS Month, Sales,
SUM(Sales) OVER (ORDER BY Month_) AS Cum_Sum
FROM Sales;

# Cumulative Sum
SELECT *, 
SUM(Total_order_Amount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS cum_sales_for_each_customer
FROM Orders;

# Avg
SELECT *, 
AVG(Total_order_Amount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS avg_for_each_customer
FROM Orders;

