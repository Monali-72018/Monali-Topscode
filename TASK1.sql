CREATE DATABASE MYDB_Assignment;

USE MYDB_Assignment;

CREATE TABLE Company (
    CompanyID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10)
);

# Q-1 Statement to create the Contact table  

CREATE TABLE Contact (
    ContactID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyID INT,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10),
    IsMain BOOLEAN,
    Email VARCHAR(45),
    Phone VARCHAR(12),
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);

# Q-2 Statement to create the Employee table  

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Salary DECIMAL(10,2),
    HireDate DATE,
    JobTitle VARCHAR(25),
    Email VARCHAR(45),
    Phone VARCHAR(12)
);


# Q-3 Statement to create the ContactEmployee table  
#HINT: Use DATE as the datatype for ContactDate. It allows you to store the 
#date in this format: YYYY-MM-DD (i.e., ‘2014-03-12’ for March 12, 2014). 

CREATE TABLE ContactEmployee (
    ContactEmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    ContactID INT,
    EmployeeID INT,
    ContactDate DATE,
    Description VARCHAR(100),
    FOREIGN KEY (ContactID) REFERENCES Contact(ContactID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

INSERT INTO Company (CompanyName, Street, City, State, Zip)
VALUES
('Urban Outfitters, Inc.', '500 Market St', 'Philadelphia', 'PA', '19103'),
('Toll Brothers', '250 Gibraltar Rd', 'Horsham', 'PA', '19044');


INSERT INTO Contact (CompanyID, FirstName, LastName, Street, City, State, Zip, IsMain, Email, Phone)
VALUES
(1, 'Dianne', 'Connor', '10 Walnut St', 'Philadelphia', 'PA', '19103', TRUE, 'dianne@urban.com', '215-555-1111'),
(2, 'James', 'Brown', '50 Oak St', 'Horsham', 'PA', '19044', TRUE, 'james@toll.com', '215-555-2222');

INSERT INTO Employee (FirstName, LastName, Salary, HireDate, JobTitle, Email, Phone)
VALUES
('Lesley', 'Bland', 55000, '2021-06-15', 'HR Manager', 'lesley.bland@company.com', '215-555-1234'),
('Jack', 'Lee', 65000, '2020-04-15', 'Sales Manager', 'jack.lee@company.com', '215-555-3333'),
('Anna', 'Smith', 58000, '2019-06-20', 'Sales Executive', 'anna.smith@company.com', '215-555-4444');

INSERT INTO ContactEmployee (ContactID, EmployeeID, ContactDate, Description)
VALUES
(1, 2, '2024-01-05', 'Initial meeting'),
(2, 3, '2024-02-10', 'Project discussion');


 # Q - 4 In the Employee table, the statement that changes Lesley Bland’s phone number to 215-555-8800 
  
UPDATE Employee
SET Phone = '215-555-8800'
WHERE EmployeeID = 1;

# Q - 5 In the Company table, the statement that changes the name of “Urban Outfitters, Inc.” to “Urban Outfitters” .

UPDATE Company
SET CompanyName = 'Urban Outfitters'
WHERE CompanyID =  1;

# Q - 6 In ContactEmployee table, the statement that removes Dianne Connor’s contact event with Jack Lee (one statement). 
#HINT: Use the primary key of the ContactEmployee table to specify the correct record to remove. 

DELETE FROM ContactEmployee
WHERE ContactEmployeeID = 1;

# Q - 7 Write the SQL SELECT query that displays the names of the employees that have contacted Toll Brothers (one statement).

SELECT DISTINCT e.FirstName, e.LastName
FROM Employee e
JOIN ContactEmployee ce ON e.EmployeeID = ce.EmployeeID
JOIN Contact c ON ce.ContactID = c.ContactID
JOIN Company co ON c.CompanyID = co.CompanyID
WHERE co.CompanyName = 'Toll Brothers';

# Q - 8 What is the significance of “%” and “_” operators in the LIKE statement?  

	#1.The LIKE operator is used to search for a specified pattern in a column.
	#2.The symbols % and _ are wildcard characters that help in pattern matching.
    
-- % (Percent Sign)
# Represents zero, one, or multiple characters Used when the length of the text is unknown

SELECT * 
FROM Employee
WHERE FirstName LIKE 'A%';

-- _ (Underscore)
# Represents exactly one single character Used when the position of a character is known

SELECT * 
FROM Employee
WHERE FirstName LIKE 'J_ck';

# Q - 9 Explain normalization in the context of databases. 

-- Normalization is the process of organizing data in a database to reduce redundancy and avoid data inconsistency.
-- It divides large tables into smaller related tables and establishes relationships using keys.
-- Normalization improves data integrity, efficiency, and ease of maintenance.

#1.First Normal Form (1NF)

-- Each field contains atomic (indivisible) values
-- No repeating groups or multi-valued attributes

#2.Second Normal Form (2NF)

-- Table is already in 1NF
-- All non-key attributes depend on the entire primary key

#3.Third Normal Form (3NF)

-- Table is already in 2NF
-- No transitive dependency (non-key attributes should not depend on other non-key attributes)

# Q - 10 What does a join in MySQL mean?  

-- A JOIN in MySQL is used to combine rows from two or more tables based on a related column between them.
-- It allows retrieving meaningful data spread across multiple tables using a common key.
-- Common types of joins include INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN.

-- Join Type	 	Meaning
-- 	INNER JOIN		Only matching rows
-- 	LEFT JOIN		All left + matching right
-- 	RIGHT JOIN		All right + matching left
-- 	FULL JOIN		All rows from both tables

# 1.INNER JOIN

SELECT e.FirstName, e.LastName, co.CompanyName
FROM Employee e
INNER JOIN ContactEmployee ce ON e.EmployeeID = ce.EmployeeID
INNER JOIN Contact c ON ce.ContactID = c.ContactID
INNER JOIN Company co ON c.CompanyID = co.CompanyID;

# 2.LEFT JOIN

SELECT e.FirstName, e.LastName, co.CompanyName
FROM Employee e
LEFT JOIN ContactEmployee ce ON e.EmployeeID = ce.EmployeeID
LEFT JOIN Contact c ON ce.ContactID = c.ContactID
LEFT JOIN Company co ON c.CompanyID = co.CompanyID;

# 3.RIGHT JOIN

SELECT e.FirstName, e.LastName, co.CompanyName
FROM Employee e
RIGHT JOIN ContactEmployee ce ON e.EmployeeID = ce.EmployeeID
RIGHT JOIN Contact c ON ce.ContactID = c.ContactID
RIGHT JOIN Company co ON c.CompanyID = co.CompanyID;

# 4.FULL JOIN

SELECT e.FirstName, e.LastName, co.CompanyName
FROM Employee e
LEFT JOIN ContactEmployee ce ON e.EmployeeID = ce.EmployeeID
LEFT JOIN Contact c ON ce.ContactID = c.ContactID
LEFT JOIN Company co ON c.CompanyID = co.CompanyID

UNION

SELECT e.FirstName, e.LastName, co.CompanyName
FROM Employee e
RIGHT JOIN ContactEmployee ce ON e.EmployeeID = ce.EmployeeID
RIGHT JOIN Contact c ON ce.ContactID = c.ContactID
RIGHT JOIN Company co ON c.CompanyID = co.CompanyID;


# Q - 11 What do you understand about DDL, DCL, and DML in MySQL? 

-- DDL (Data Definition Language)
-- DDL is used to define and modify the structure of database objects like tables and databases.
-- Examples: CREATE, ALTER, DROP, TRUNCATE.

-- DML (Data Manipulation Language)
-- DML is used to insert, update, delete, and retrieve data stored in tables.
-- Examples: INSERT, UPDATE, DELETE, SELECT.

-- DCL (Data Control Language)
-- DCL is used to control access and permissions in the database.
-- Examples: GRANT, REVOKE.

# Q - 12 What is the role of the MySQL JOIN clause in a query, and what are some common types of joins? 

-- The MySQL JOIN clause is used to combine data from two or more tables based on a related column between them.
-- It helps retrieve meaningful information that is spread across multiple tables.

-- Common types of joins include:

-- INNER JOIN – returns only matching records from both tables
-- LEFT JOIN – returns all records from the left table and matching records from the right table
-- RIGHT JOIN – returns all records from the right table and matching records from the left table
-- FULL JOIN – returns all records from both tables (achieved in MySQL using UNION)