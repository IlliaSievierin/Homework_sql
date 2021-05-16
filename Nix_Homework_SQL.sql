--> 1. ��� ���������� ����� ������� ����� �� �������� ��������� �1?
SELECT TOP 1
	ProductName
FROM dbo.Products
WHERE CategoryID = 1
ORDER BY UnitPrice DESC;

--> 2. � ����� ������ ������ ��������������� ����� ������ ����?
SELECT DISTINCT 
	ShipCity
FROM dbo.Orders
WHERE DATEDIFF(day,OrderDate,ShippedDate)>10;

--> 3. ����� ���������� �� ��� ��� ���� �������� ����� �������?
SELECT
	ContactName
FROM dbo.Customers INNER JOIN dbo.Orders ON Customers.CustomerID=Orders.CustomerID
WHERE ShippedDate IS NULL;
	
--> 4. �������� ����������� �������� ��������, ���������� �� ������ ���������� �������?
SELECT TOP 1
	COUNT(CustomerID) count_customer
FROM dbo.Orders
GROUP BY EmployeeID
ORDER BY count_customer DESC;

--> 5. ������� ����������� ������� �������� �������� �1 � 1997-�?
SELECT 
	COUNT(ShipCity) count_sity
FROM dbo.Orders
WHERE ShipCountry = 'France' AND EmployeeID = 1 AND YEAR(ShippedDate) = 1997
GROUP BY ShipCountry;

--> 6. � ����� ������� ���� ������, � ������� ���� ���������� ������ ���� �������?
SELECT DISTINCT
	ShipCountry 
FROM dbo.Orders 
GROUP BY ShipCountry, ShipCity 
HAVING COUNT(OrderID) > 2;

--> 7. ����������� �������� �������, ������� ���� ������� � ���������� ����� 1000 ���� (quantity)?
SELECT 
	ProductName
FROM dbo.Products INNER JOIN dbo.[Order Details] ON dbo.Products.ProductID = dbo.[Order Details].ProductID
GROUP BY ProductName
HAVING SUM(Quantity)<1000;
 
--> 8. ��� ����� �����������, ������� ������ ������ � ��������� � ������ ����� (�� � ���, � ������� ��� ���������)?
SELECT DISTINCT
	ContactName
FROM dbo.Customers INNER JOIN dbo.Orders ON dbo.Customers.CustomerID = dbo.Orders.CustomerID
WHERE City <> ShipCity;

--> 9. �������� �� ����� ��������� � 1997-� ���� ���������������� ������ ����� ��������, ������� ����?
SELECT TOP 1
	CategoryName,COUNT(EmployeeID) count_employee 
FROM dbo.Categories 
INNER JOIN dbo.Products ON dbo.Categories.CategoryID= dbo.Products.CategoryID 
INNER JOIN dbo.[Order Details] ON dbo.Products.ProductID=dbo.[Order Details].ProductID
INNER JOIN dbo.Orders ON dbo.Orders.OrderID=dbo.[Order Details].OrderID
INNER JOIN dbo.Customers ON dbo.Customers.CustomerID = dbo.Orders.CustomerID
WHERE YEAR(OrderDate) = 1997 AND Fax IS NOT NULL
GROUP BY CategoryName
ORDER BY count_employee DESC;

--> 10. ������� ����� ������ ������� (�� ����, ���� � Quantity) ������ ������ �������� (���, �������) ������ 1996 ����?
SELECT
	FirstName,LastName,SUM(Quantity) sum_product
FROM dbo.[Order Details] 
INNER JOIN dbo.Orders ON dbo.Orders.OrderID=dbo.[Order Details].OrderID
INNER JOIN dbo.Employees ON dbo.Employees.EmployeeID = dbo.Orders.EmployeeID
WHERE OrderDate between CAST('09/01/1996 00:00:00' as DATETIME) and CAST('30/11/1996 23:59:59' as DATETIME)
GROUP BY FirstName,LastName;







