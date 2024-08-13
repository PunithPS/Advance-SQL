# Creating a demo database
CREATE DATABASE demo;

# Selecting the database 
USE demo;

# Constraints -> Rules / Restrictions 

# Primary Key (Way 1)
# Primary Key is a column/s which should be able to uniquely classify every row in the table
# 2 Restrictions -> Unique, Not Null

CREATE TABLE Users (
ID INT PRIMARY KEY,
Full_Name VARCHAR(30)
);

# Inserting the data
INSERT INTO Users 
VALUES 
(1, 'Aman');

# Getting an idea about the data
SELECT * 
FROM Users;

# Inserting the data
INSERT INTO Users 
VALUES 
(1, 'Ajay');

# Primary Key Constraint is working

# Dropping the table 
DROP TABLE Users;

# Primary Key (Way 2)
CREATE TABLE Users (
ID INT,
Full_Name VARCHAR(30),
CONSTRAINT pk_users_ PRIMARY KEY (ID)
);

# Inserting the data
INSERT INTO Users 
VALUES 
(1, 'Aman');

# Getting an idea about the data
SELECT * 
FROM Users;

# Inserting the data
INSERT INTO Users 
VALUES 
(1, 'Ajay');

# Primary Key Constraint is working

# Dropping the table 
DROP TABLE Users;

# Unique Constraint (Way 1) 
CREATE TABLE Users (
ID INT,
Full_Name VARCHAR(30),
CONSTRAINT unique_constraint UNIQUE(ID)
);

# Inserting the data into the table
INSERT INTO Users
VALUES 
(1, 'Aman');

# Inserting the data into the table
INSERT INTO Users
VALUES 
(1, 'Ajay');

# Inserting the data into the table
INSERT INTO Users
VALUES 
(NULL, 'Ajay');

# Selecting the data
SELECT * 
FROM Users;

# Dropping the table  
DROP TABLE Users;

# Unique Constraint (Way 2) 
CREATE TABLE Users (
ID INT UNIQUE,
Full_Name VARCHAR(30)
);

# Inserting the data into the table
INSERT INTO Users
VALUES 
(1, 'Aman');

# Inserting the data into the table
INSERT INTO Users
VALUES 
(1, 'Ajay');

# Inserting the data into the table
INSERT INTO Users
VALUES 
(NULL, 'Ajay');

# Selecting the data
SELECT * 
FROM Users;

# Dropping the table  
DROP TABLE Users;

# Foreign Key (Way 1)
CREATE TABLE Users (
ID INT PRIMARY KEY,
Full_Name VARCHAR(30)
);

CREATE TABLE Blogs (
ID INT PRIMARY KEY,
Blog_Name VARCHAR(30),
User_ID INT,
FOREIGN KEY (User_ID) REFERENCES Users(ID)
);

# Dropping the tables 
DROP TABLE Blogs;
DROP TABLE Users;

# Foreign Key (Way 2)
CREATE TABLE Users (
ID INT PRIMARY KEY,
Full_Name VARCHAR(30)
);

CREATE TABLE Blogs (
ID INT PRIMARY KEY,
Blog_Name VARCHAR(30),
User_ID INT,
CONSTRAINT fk_users_ FOREIGN KEY (User_ID) REFERENCES Users(ID)
);

# Dropping the tables 
DROP TABLE Blogs;
DROP TABLE Users;

# Check Constraint 

# Way 1 - 
CREATE TABLE Users (
ID INT PRIMARY KEY,
Full_Name VARCHAR(30) CHECK (Full_Name LIKE '%a%')
);

# Percentage (%) denotes any number of any characters.

# Inserting the data into the table
INSERT INTO Users
VALUES 
(1, 'Ajay');

# Inserting the data into the table
INSERT INTO Users
VALUES 
(2, 'Nrupul');

# Getting the data
SELECT * 
FROM Users;

# Dropping the table
DROP TABLE Users;

# Way 2 - 
CREATE TABLE Users (
ID INT PRIMARY KEY,
Full_Name VARCHAR(30) 
CONSTRAINT ck_users_ CHECK (Full_Name LIKE '%a%')
);

# Percentage (%) denotes any number of any characters.

# Inserting the data into the table
INSERT INTO Users
VALUES 
(1, 'Ajay');

# Inserting the data into the table
INSERT INTO Users
VALUES 
(2, 'Nrupul');

# Getting the data
SELECT * 
FROM Users;

# Dropping the table
DROP TABLE Users;

# Default Constraint 
CREATE TABLE Users (
ID INT PRIMARY KEY,
Full_Name VARCHAR(30) DEFAULT 'MySQL'
);

# Inserting the data
INSERT INTO Users (ID)
VALUES 
(1),
(2),
(3);

# Getting the data
SELECT * 
FROM Users;

# Dropping the table
DROP TABLE Users;

# NOT NULL Constraint 
CREATE TABLE Users (
ID INT NOT NULL,
Full_Name VARCHAR(30)
);

INSERT INTO Users (Full_Name)
VALUES 
('Ajay');

# Dropping the table
DROP TABLE Users;

# Dropping the database
DROP DATABASE IF EXISTS demo;

# Getting an idea about the masai database tables
SELECT * FROM category;
SELECT * FROM customers;
SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM products;
SELECT * FROM shippers;
SELECT * FROM suppliers;

# ALTER Statement -> Change the existing structure 

# Adding a new column to the table Customers
ALTER TABLE Customers
ADD Favorite_Sport VARCHAR(30);

# Getting the data
SELECT * 
FROM Customers;

# Dropping that extra column 
ALTER TABLE Customers
DROP COLUMN Favorite_Sport;

SELECT * 
FROM Customers;

# Adding a new column to the table Customers
ALTER TABLE Customers
ADD Favorite_Sport VARCHAR(30);

# Setting the default value
ALTER TABLE Customers
ALTER Favorite_Sport SET DEFAULT 'Cricket';

SELECT * 
FROM Customers;

# Inserting the data
INSERT INTO Customers (CustomerID, FirstName, City)
VALUES 
(1, 'Prateek', 'Bangalore');

SELECT * 
FROM Customers;

# Dropping that extra column 
ALTER TABLE Customers
DROP COLUMN Favorite_Sport;

# Adding the primary key (Way 1)
ALTER TABLE Customers
ADD PRIMARY KEY (CustomerID);

# Dropping the primar key
ALTER TABLE Customers
DROP PRIMARY KEY;

# Adding the primary key (Way 2)
ALTER TABLE Customers
ADD CONSTRAINT pk_cust_ PRIMARY KEY (CustomerID);

# Dropping the primar key
ALTER TABLE Customers
DROP PRIMARY KEY;

# Getting the data
SELECT * 
FROM Customers;

# Converting the data type
ALTER TABLE Customers
MODIFY COLUMN Date_of_Birth DATE;

# Getting the data
SELECT * 
FROM Customers;

# Renaming a column 
ALTER TABLE Customers
RENAME COLUMN CustomerID TO ID;

# Getting the data
SELECT * 
FROM Customers;

# Renaming a table 
ALTER TABLE Customers
RENAME Customer_Details;

# Getting the data
SELECT * 
FROM Customer_Details;
