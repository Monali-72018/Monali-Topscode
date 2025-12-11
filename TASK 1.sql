CREATE DATABASE MYDB_Assessment;

USE MYDB_Assessment;

CREATE TABLE WORKER(
		WORKER_ID INT primary key,
        FIRST_NAME VARCHAR(20),
        LAST_NAME VARCHAR(20),
        SALARY INT,
        JOINING_DATE DATETIME,
        DEPARTMENT VARCHAR(30)
);

INSERT INTO WORKER (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT)
VALUES
(1, 'Monika', 'Arora', 100000, '2014-02-20 09:00:00', 'HR'),
(2, 'Niharika', 'Verma', 80000, '2014-06-11 09:00:00', 'Admin'),
(3, 'Vishal', 'Singhal', 300000, '2014-02-20 09:00:00', 'HR'),
(4, 'Amitabh', 'Singh', 500000, '2014-02-20 09:00:00', 'Admin'),
(5, 'Vivek', 'Bhati', 500000, '2014-06-11 09:00:00', 'Admin'),
(6, 'Vipul', 'Diwan', 200000, '2014-06-11 09:00:00', 'Account'),
(7, 'Satish', 'Kumar', 75000, '2014-01-20 09:00:00', 'Account'),
(8, 'Geetika', 'Chauhan', 90000, '2014-04-11 09:00:00', 'Admin');

SELECT * FROM WORKER; 


 -- Q-1 Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending. 

SELECT * FROM WORKER
ORDER BY FIRST_NAME ASC,DEPARTMENT DESC;

-- Q-2 .Write an SQL query to print details for Workers with the first names “Vipul” and “Satish” from the Worker table. 

SELECT * FROM WORKER
WHERE FIRST_NAME IN ("Vipul","Satish");

-- Q-3 Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets. 

SELECT * FROM WORKER
WHERE FIRST_NAME LIKE "_____h";

-- Q-4 Write an SQL query to print details of the Workers whose SALARY lies between 1. 

SELECT * FROM WORKER 
WHERE SALARY BETWEEN 1 AND 100000;

-- Q-5 Write an SQL query to fetch duplicate records having matching data in some fields of a table. 

SELECT  FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT,COUNT(*)
FROM WORKER
GROUP BY FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT
HAVING COUNT(*) > 1;

-- Q-6 Write an SQL query to show the top 6 records of a table. 

SELECT *  FROM WORKER limit 6;

-- Q-7 Write an SQL query to fetch the departments that have less than five people in them.

SELECT 
    DEPARTMENT,
    COUNT(*) AS TotalPeople
FROM WORKER
GROUP BY DEPARTMENT
HAVING COUNT(*) < 5;

-- Q-8. Write an SQL query to show all departments along with the number of people in there. 

SELECT 
	 DEPARTMENT,
     COUNT(*) AS people
FROM WORKER
GROUP BY DEPARTMENT;

-- Q - 9 Write an SQL query to print the name of employees having the highest salary in each department. 

SELECT * FROM WORKER;

SELECT 
    CONCAT(a.FIRST_NAME, ' ', a.LAST_NAME) AS Emp_Name,
	a.DEPARTMENT,
	a.SALARY
FROM WORKER a
WHERE a.SALARY = (SELECT MAX(SALARY) FROM WORKER WHERE DEPARTMENT = a.DEPARTMENT);
