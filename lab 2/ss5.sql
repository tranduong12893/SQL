SELECT LoginID
FROM Employee
WHERE JobTitle = 'Design Engineer'
CREATE TYPE usertype FROM varchar(20) NOT NULL
DECLARE @Number int;
SET @Number = 2 + 2 * (4 + (5 - 3))
SELECT @Number
SELECT SalesOrderID, CustomerID, SalesPersonID, TerritoryID,YEAR(OrderDate)
AS CurrentYear, YEAR(OrderDate) + 1 AS NextYear
FROM Sales.SalesOrderHeader
USE AdventureWorks2012
--  HumanResources.Employee table contains the details of an employee.  
-- This statement retrieves all the rows of the table 
-- HumanResources.Employee.
SELECT * FROM HumanResources.Employee
USE AdventureWorks2012
/* HumanResources.Employee table contains the details of an employee.
 This statement retrieves all the rows of the table 
HumanResources.Employee. */
SELECT * FROM HumanResources.Employee
USE AdventureWorks2012
SELECT * FROM HumanResources.Employee
GO
SELECT <select list>
FROM <table source>
WHERE <search condition>
GROUP BY <group by list>
HAVING <search condition>
ORDER BY <order by list>
SELECT SalesPersonID, YEAR(OrderDate) AS OrderYear
FROM Sales.SalesOrderHeader
WHERE CustomerID = 30084
GROUP BY SalesPersonID, YEAR(OrderDate)
HAVING COUNT(*) > 1
ORDER BY SalesPersonID, OrderYear;
