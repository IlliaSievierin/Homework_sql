--> 1. Как называется самый дорогой товар из товарной категории №1?
SELECT TOP 1
	ProductName
FROM dbo.Products
WHERE CategoryID = 1
ORDER BY UnitPrice DESC;

--> 2. В какие города заказы комплектовались более десяти дней?
SELECT DISTINCT 
	ShipCity
FROM dbo.Orders
WHERE DATEDIFF(day,OrderDate,ShippedDate)>10;

--> 3. Какие покупатели до сих пор ждут отгрузки своих заказов?
SELECT
	ContactName
FROM dbo.Customers INNER JOIN dbo.Orders ON Customers.CustomerID=Orders.CustomerID
WHERE ShippedDate IS NULL;
	
--> 4. Скольких покупателей обслужил продавец, лидирующий по общему количеству заказов?
SELECT TOP 1
	COUNT(CustomerID) count_customer
FROM dbo.Orders
GROUP BY EmployeeID
ORDER BY count_customer DESC;

--> 5. Сколько французских городов обслужил продавец №1 в 1997-м?
SELECT 
	COUNT(ShipCity) count_sity
FROM dbo.Orders
WHERE ShipCountry = 'France' AND EmployeeID = 1 AND YEAR(ShippedDate) = 1997
GROUP BY ShipCountry;

--> 6. В каких странах есть города, в которые было отправлено больше двух заказов?
SELECT DISTINCT
	ShipCountry 
FROM dbo.Orders 
GROUP BY ShipCountry, ShipCity 
HAVING COUNT(OrderID) > 2;

--> 7. Перечислите названия товаров, которые были проданы в количестве менее 1000 штук (quantity)?
SELECT 
	ProductName
FROM dbo.Products INNER JOIN dbo.[Order Details] ON dbo.Products.ProductID = dbo.[Order Details].ProductID
GROUP BY ProductName
HAVING SUM(Quantity)<1000;
 
--> 8. Как зовут покупателей, которые делали заказы с доставкой в другой город (не в тот, в котором они прописаны)?
SELECT DISTINCT
	ContactName
FROM dbo.Customers INNER JOIN dbo.Orders ON dbo.Customers.CustomerID = dbo.Orders.CustomerID
WHERE City <> ShipCity;

--> 9. Товарами из какой категории в 1997-м году заинтересовалось больше всего компаний, имеющих факс?
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

--> 10. Сколько всего единиц товаров (то есть, штук – Quantity) продал каждый продавец (имя, фамилия) осенью 1996 года?
SELECT
	FirstName,LastName,SUM(Quantity) sum_product
FROM dbo.[Order Details] 
INNER JOIN dbo.Orders ON dbo.Orders.OrderID=dbo.[Order Details].OrderID
INNER JOIN dbo.Employees ON dbo.Employees.EmployeeID = dbo.Orders.EmployeeID
WHERE OrderDate between CAST('09/01/1996 00:00:00' as DATETIME) and CAST('30/11/1996 23:59:59' as DATETIME)
GROUP BY FirstName,LastName;







