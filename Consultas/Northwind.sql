--Consultas con INNER JOIN
--1. Listar todos los productos y sus categorías, ordenados por nombre de categoría
SELECT Products.ProductName, Categories.CategoryName
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
ORDER BY Categories.CategoryName;

--2. Mostrar los empleados y sus territorios de ventas, ordenados por apellido de empleado
SELECT Employees.FirstName, Employees.LastName, Territories.TerritoryDescription
FROM Employees
INNER JOIN EmployeeTerritories ON Employees.EmployeeID = EmployeeTerritories.EmployeeID
INNER JOIN Territories ON EmployeeTerritories.TerritoryID = Territories.TerritoryID
ORDER BY Employees.LastName;

--3. Obtener la cantidad total de productos vendidos por cada empleado, mostrando solo aquellos que han vendido más de 100 productos
SELECT Employees.FirstName, Employees.LastName, SUM(od.Quantity) AS TotalVendido
FROM Employees
INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN [Order Details] od ON Orders.OrderID = od.OrderID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
HAVING SUM(od.Quantity) > 100
ORDER BY TotalVendido DESC;

--4. Mostrar los clientes y la cantidad total de dinero gastado por cada uno, solo para aquellos que han gastado más de $2,500 en total
SELECT Customers.CustomerID, Customers.CompanyName, SUM(Orders.Freight) AS TotalGastado
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CompanyName
HAVING SUM(Orders.Freight) > 2500
ORDER BY TotalGastado DESC;

--5. Listar los empleados y la cantidad total de órdenes que han procesado, ordenados por el número de órdenes en orden descendente
SELECT Employees.FirstName, Employees.LastName, COUNT(Orders.OrderID) AS TotalOrdenes
FROM Employees
INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY TotalOrdenes DESC;

--6. Mostrar los productos, su precio unitario y el nombre del proveedor, solo para productos con un precio unitario superior a $50, ordenados por precio unitario de forma ascendente
SELECT Products.ProductName, Products.UnitPrice, Suppliers.CompanyName
FROM Products
INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Products.UnitPrice > 50
ORDER BY Products.UnitPrice;

--7. Mostrar los productos y su cantidad total vendida en órdenes, ordenados por cantidad vendida de forma descendente
SELECT p.ProductName, SUM(od.Quantity) AS TotalVendido
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalVendido DESC;

--8. Listar los empleados y la cantidad total de productos vendidos por categoría de producto, ordenados por cantidad de productos vendidos en orden descendente
SELECT Employees.FirstName, Employees.LastName, Categories.CategoryName, SUM(od.Quantity) AS TotalVendido
FROM Employees
INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN [Order Details] od ON Orders.OrderID = od.OrderID
INNER JOIN Products ON od.ProductID = Products.ProductID
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY Employees.FirstName, Employees.LastName, Categories.CategoryName
ORDER BY TotalVendido DESC;

--9. Mostrar los productos y el nombre del proveedor para aquellos productos que tienen un precio unitario superior a $30 y menos de 10 unidades en stock, ordenados por precio unitario de forma descendente
SELECT Products.ProductName, Products.UnitPrice, Suppliers.CompanyName
FROM Products
INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Products.UnitPrice > 30 AND Products.UnitsInStock < 10
ORDER BY Products.UnitPrice DESC;

--10. Obtener una lista de clientes y el total de dinero gastado por cada uno en órdenes, mostrando solo aquellos que han gastado menos de $1,000 en total, ordenados por el total gastado de forma ascendente
SELECT Customers.CustomerID, Customers.CompanyName, SUM(Orders.Freight) AS TotalGastado
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CompanyName
HAVING SUM(Orders.Freight) < 1000
ORDER BY TotalGastado;

--11. Listar los empleados y el nombre de sus jefes (supervisor), ordenados por el nombre del jefe
SELECT Employees.FirstName AS Empleado, Managers.FirstName AS Jefe
FROM Employees
INNER JOIN Employees AS Managers ON Employees.ReportsTo = Managers.EmployeeID
ORDER BY Jefe, Empleado;

--12. Mostrar los productos y la cantidad total de unidades vendidas en órdenes para cada uno, ordenados por la cantidad total vendida en orden descendente
SELECT Products.ProductName, SUM(od.Quantity) AS TotalVendido
FROM Products
INNER JOIN [Order Details] od ON Products.ProductID = od.ProductID
GROUP BY Products.ProductName
ORDER BY TotalVendido DESC;

--13. Listar los empleados y la cantidad total de órdenes que han procesado, ordenados por el número de órdenes en orden ascendente
SELECT Employees.FirstName, Employees.LastName, COUNT(Orders.OrderID) AS TotalOrdenes
FROM Employees
INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.FirstName, Employees.LastName
ORDER BY TotalOrdenes;

--14. Mostrar los productos y su precio unitario, solo para productos que tienen un precio unitario superior a $40 y que pertenecen a la categoría 'Beverages', ordenados por precio unitario de forma ascendente
SELECT Products.ProductName, Products.UnitPrice
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Products.UnitPrice > 40 AND Categories.CategoryName = 'Beverages'
ORDER BY Products.UnitPrice;

--15. Mostrar los productos y la cantidad total de unidades vendidas en órdenes para cada uno, ordenados por el nombre del producto de forma ascendente
SELECT p.ProductName, SUM(od.Quantity) AS TotalVendido
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY p.ProductName;

--16. Obtener una lista de empleados y la cantidad total de productos vendidos por cada uno, mostrando solo aquellos que han vendido más de 50 productos en total, ordenados por cantidad de productos vendidos de forma descendente
SELECT e.FirstName, e.LastName, SUM(od.Quantity) AS TotalVendido
FROM Employees e
INNER JOIN Orders ON e.EmployeeID = Orders.EmployeeID
INNER JOIN [Order Details] od ON Orders.OrderID = od.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING SUM(od.Quantity) > 50
ORDER BY TotalVendido DESC;

--17. Listar los productos y el nombre del proveedor para aquellos productos que tienen un precio unitario superior a $20 y al menos 20 unidades en stock, ordenados por nombre de producto
SELECT Products.ProductName, Suppliers.CompanyName
FROM Products
INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Products.UnitPrice > 20 AND Products.UnitsInStock >= 20
ORDER BY Products.ProductName;

--18. Mostrar los clientes y la cantidad total de dinero gastado por cada uno, solo para aquellos que han gastado más de $5,000 en total, ordenados por el total gastado de forma descendente
SELECT Customers.CustomerID, Customers.CompanyName, SUM(Orders.Freight) AS TotalGastado
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CompanyName
HAVING SUM(Orders.Freight) > 5000
ORDER BY TotalGastado DESC;

--19. Listar los empleados y la cantidad total de órdenes que han procesado, ordenados por el número de órdenes en orden descendente
SELECT Employees.FirstName, Employees.LastName, COUNT(Orders.OrderID) AS TotalOrdenes
FROM Employees
INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY TotalOrdenes DESC;

--20. Mostrar los productos y su precio unitario, solo para productos que tienen un precio unitario superior a $10 y que pertenecen a la categoría 'Confections', ordenados por precio unitario de forma descendente
SELECT Products.ProductName, Products.UnitPrice
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Products.UnitPrice > 10 AND Categories.CategoryName = 'Confections'
ORDER BY Products.UnitPrice DESC;

--21. Listar los empleados y la cantidad total de órdenes que han procesado, ordenados por el número de órdenes en orden ascendente
SELECT Employees.FirstName, Employees.LastName, COUNT(Orders.OrderID) AS TotalOrdenes
FROM Employees
INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.FirstName, Employees.LastName
ORDER BY TotalOrdenes;

--22. Listar los productos y la cantidad total de unidades vendidas en órdenes para cada uno, mostrando solo aquellos productos que tienen al menos una unidad vendida, ordenados por la cantidad total vendida de forma descendente
SELECT Products.ProductName, SUM(od.Quantity) AS TotalUnidadesVendidas
FROM Products
INNER JOIN [Order Details] od ON Products.ProductID = od.ProductID
GROUP BY Products.ProductName
HAVING SUM(od.Quantity) > 0
ORDER BY TotalUnidadesVendidas DESC;

--23. Mostrar los clientes y la cantidad total de órdenes realizadas por cada uno, solo para aquellos clientes que han realizado al menos una orden, ordenados por la cantidad total de órdenes de forma descendente
SELECT Customers.ContactName, COUNT(Orders.OrderID) AS TotalOrdenes
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.ContactName
HAVING COUNT(Orders.OrderID) > 0
ORDER BY TotalOrdenes DESC;

--24. Listar los productos y su precio unitario, solo para productos que tienen un precio unitario superior a $20 y que pertenecen a la categoría 'Produce', ordenados por precio unitario de forma ascendente
SELECT Products.ProductName, Products.UnitPrice
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Products.UnitPrice > 20 AND Categories.CategoryName = 'Produce'
ORDER BY Products.UnitPrice ASC;

--25. Mostrar los productos y el nombre del proveedor para aquellos productos que tienen un precio unitario superior a $25 y que se han agotado (0 unidades en stock), ordenados por nombre de producto
SELECT Products.ProductName, Suppliers.ContactName
FROM Products
INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Products.UnitPrice > 25 AND Products.UnitsInStock = 0
ORDER BY Products.ProductName;

--Consultas con LEFT JOIN
--1. Listar los productos y la cantidad total de unidades vendidas en órdenes para cada uno, incluyendo aquellos productos que no han sido vendidos en ninguna orden, ordenados por el nombre del producto de forma ascendente
SELECT Products.ProductName, COALESCE(SUM(od.Quantity), 0) AS TotalUnidadesVendidas
FROM Products
LEFT JOIN [Order Details] od ON Products.ProductID = od.ProductID
GROUP BY Products.ProductName
ORDER BY Products.ProductName;

--2. Mostrar los empleados y el nombre de la ciudad donde trabajan, incluyendo a todos los empleados incluso si no tienen una ciudad asignada, ordenados alfabéticamente por nombre de ciudad
SELECT Employees.FirstName, Employees.LastName, COALESCE(Employees.City, 'Sin Ciudad') AS Ciudad
FROM EmployeeTerritories
LEFT JOIN Territories ON EmployeeTerritories.TerritoryID = Territories.TerritoryID
LEFT JOIN Employees ON EmployeeTerritories.EmployeeID = Employees.EmployeeID
ORDER BY Ciudad;

--3. Listar los clientes y la cantidad total de dinero gastado por cada uno, incluyendo a todos los clientes incluso si no han realizado ninguna compra, ordenados por el total gastado de forma descendente
SELECT Customers.ContactName, COALESCE(SUM(Orders.Freight), 0) AS TotalGastado
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.ContactName
ORDER BY TotalGastado DESC;

--4. Mostrar los productos y su precio unitario para aquellos productos que tienen un precio unitario superior a $50, incluyendo productos que no tienen precio unitario asignado, ordenados por precio unitario de forma ascendente
SELECT Products.ProductName, COALESCE(Products.UnitPrice, 0) AS PrecioUnitario
FROM Products
LEFT JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE COALESCE(Products.UnitPrice, 0) > 50
ORDER BY PrecioUnitario ASC;

--5. Listar los empleados y la cantidad total de productos vendidos por categoría de producto, incluyendo a todos los empleados, incluso aquellos que no han vendido productos, ordenados por cantidad de productos vendidos en orden descendente
SELECT e.FirstName, e.LastName, COALESCE(c.CategoryName, 'Sin Venta') AS Categoria, COALESCE(SUM(od.Quantity), 0) AS TotalProductosVendidos
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID
LEFT JOIN Products p ON od.ProductID = p.ProductID
LEFT JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY e.FirstName, e.LastName, c.CategoryName
ORDER BY TotalProductosVendidos DESC;

--6. Mostrar los productos y el nombre del proveedor para aquellos productos que tienen un precio unitario superior a $30 y menos de 10 unidades en stock, incluyendo productos que no tienen proveedor asignado, ordenados por precio unitario de forma descendente
SELECT Products.ProductName, COALESCE(Suppliers.ContactName, 'Sin Proveedor') AS Proveedor, COALESCE(Products.UnitPrice, 0) AS PrecioUnitario, COALESCE(Products.UnitsInStock, 0) AS UnidadesEnStock
FROM Products
LEFT JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE COALESCE(Products.UnitPrice, 0) > 30 AND COALESCE(Products.UnitsInStock, 0) < 10
ORDER BY PrecioUnitario DESC;

--7. Obtener una lista de clientes y el total de dinero gastado por cada uno en órdenes, mostrando solo aquellos que han gastado menos de $1,000 en total, incluyendo a todos los clientes, incluso si no han realizado ninguna compra, ordenados por el total gastado de forma ascendente
SELECT Customers.ContactName, COALESCE(SUM(Orders.Freight), 0) AS TotalGastado
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.ContactName
HAVING COALESCE(SUM(Orders.Freight), 0) < 1000
ORDER BY TotalGastado ASC;

--8. Listar los empleados y la cantidad total de órdenes que han procesado, incluyendo a todos los empleados, incluso aquellos que no han procesado órdenes, ordenados por el número de órdenes en orden descendente
SELECT Employees.FirstName, Employees.LastName, COALESCE(COUNT(Orders.OrderID), 0) AS TotalOrdenesProcesadas
FROM Employees
LEFT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.FirstName, Employees.LastName
ORDER BY TotalOrdenesProcesadas DESC;

--9. Mostrar los productos y su precio unitario, solo para productos que tienen un precio unitario superior a $10 y que pertenecen a la categoría 'Confections', incluyendo productos que no tienen categoría asignada, ordenados por precio unitario de forma descendente
SELECT Products.ProductName, COALESCE(Products.UnitPrice, 0) AS PrecioUnitario, COALESCE(Categories.CategoryName, 'Sin Categoría') AS Categoria
FROM Products
LEFT JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE COALESCE(Products.UnitPrice, 0) > 10 AND COALESCE(Categories.CategoryName, 'Sin Categoría') = 'Confections'
ORDER BY PrecioUnitario DESC;

--10. Mostrar todos los empleados y sus territorios de ventas, incluyendo aquellos que no tienen territorios asignados
SELECT Employees.FirstName, Employees.LastName, Territories.TerritoryDescription
FROM Employees
LEFT JOIN EmployeeTerritories ON Employees.EmployeeID = EmployeeTerritories.EmployeeID
LEFT JOIN Territories ON EmployeeTerritories.TerritoryID = Territories.TerritoryID;

--11. Listar todos los clientes y sus órdenes, incluyendo aquellos clientes que no han realizado ninguna orden
SELECT Customers.CustomerID, Customers.CompanyName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

--12. Obtener una lista de productos y sus categorías, mostrando también aquellos productos que no tienen una categoría asignada
 SELECT Products.ProductName, Categories.CategoryName
FROM Products
LEFT JOIN Categories ON Products.CategoryID = Categories.CategoryID;

--13. Mostrar todos los empleados y sus jefes (supervisores), incluyendo a los empleados que no tienen un jefe asignado
SELECT E1.FirstName AS Empleado, E2.FirstName AS Jefe
FROM Employees AS E1
LEFT JOIN Employees AS E2 ON E1.ReportsTo = E2.EmployeeID;

--14. Listar todos los productos y sus proveedores, incluyendo aquellos productos que no tienen un proveedor asignado
SELECT Products.ProductName, Suppliers.CompanyName
FROM Products
LEFT JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID;

--15. Mostrar todos los productos y la cantidad total vendida en órdenes para cada uno, incluyendo aquellos productos que no han sido vendidos.
SELECT p.ProductName, COALESCE(SUM(od.Quantity), 0) AS TotalVendido
FROM Products p
LEFT JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;

--16. Listar todos los empleados y la cantidad total de órdenes que han procesado, incluyendo aquellos empleados que no han procesado ninguna orden
SELECT Employees.FirstName, Employees.LastName, COALESCE(COUNT(Orders.OrderID), 0) AS TotalOrdenes
FROM Employees
LEFT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName;

--17. Obtener una lista de clientes y la cantidad total de dinero gastado por cada uno en órdenes, incluyendo aquellos clientes que no han realizado ninguna compra
SELECT Customers.CustomerID, Customers.CompanyName, COALESCE(SUM(Orders.Freight), 0) AS TotalGastado
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CompanyName;

--18. Mostrar todos los productos y su precio unitario, incluyendo aquellos productos que no tienen un precio unitario asignado
SELECT Products.ProductName, COALESCE(Products.UnitPrice, 0) AS UnitPrice
FROM Products
LEFT JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID;

--19. Listar todos los empleados y sus jefes (supervisores), incluyendo a los empleados que no tienen un jefe asignado
SELECT E1.FirstName AS Empleado, E2.FirstName AS Jefe
FROM Employees AS E1
LEFT JOIN Employees AS E2 ON E1.ReportsTo = E2.EmployeeID;

--20. Mostrar todos los empleados y sus territorios de ventas, incluyendo aquellos empleados que no tienen territorios asignados
SELECT Employees.FirstName, Employees.LastName, Territories.TerritoryDescription
FROM Employees
LEFT JOIN EmployeeTerritories ON Employees.EmployeeID = EmployeeTerritories.EmployeeID
LEFT JOIN Territories ON EmployeeTerritories.TerritoryID = Territories.TerritoryID;

--21. Listar todos los productos y sus proveedores, incluyendo aquellos productos que no tienen un proveedor asignado
SELECT Products.ProductName, Suppliers.CompanyName
FROM Products
LEFT JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID;

--22. Mostrar todos los productos y la cantidad total vendida en órdenes para cada uno, incluyendo aquellos productos que no han sido vendidos
SELECT Products.ProductName, SUM(od.Quantity) AS TotalVendido
FROM Products
LEFT JOIN [Order Details] od ON Products.ProductID = od.ProductID
GROUP BY Products.ProductName;

--23. Listar todos los empleados y la cantidad total de órdenes que han procesado, incluyendo aquellos empleados que no han procesado ninguna orden
SELECT Employees.FirstName, Employees.LastName, COUNT(Orders.OrderID) AS TotalOrdenes
FROM Employees
LEFT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName;

--24. Obtener una lista de clientes y la cantidad total de dinero gastado por cada uno en órdenes, incluyendo aquellos clientes que no han realizado ninguna compra
SELECT Customers.CustomerID, Customers.CompanyName, SUM(Orders.Freight) AS TotalGastado
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CompanyName;

--25. Mostrar todos los productos y su precio unitario, incluyendo aquellos productos que no tienen un precio unitario asignado
SELECT Products.ProductName, Products.UnitPrice
FROM Products
LEFT JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID;

--Consultas con RIGHT JOIN
--1. Muestra una lista de productos junto con sus proveedores, incluso si algunos productos no tienen un proveedor asignado.
SELECT Products.ProductName, Suppliers.CompanyName
FROM Suppliers
RIGHT JOIN Products ON Suppliers.SupplierID = Products.SupplierID;

--2. Muestra una lista de productos y la cantidad total vendida en órdenes para cada uno, incluso si algunos productos no han sido vendidos.
SELECT Products.ProductName, SUM(od.Quantity) AS TotalVendido
FROM [Order Details] od
RIGHT JOIN Products ON od.ProductID = Products.ProductID
GROUP BY Products.ProductName;

--3. Lista a todos los empleados y la cantidad total de órdenes que han procesado, incluso si algunos empleados no han procesado ninguna orden.
SELECT Employees.FirstName, Employees.LastName, COUNT(Orders.OrderID) AS TotalOrdenes
FROM Orders
RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName;

--4. Obtiene una lista de clientes y muestra la cantidad total de dinero gastado en órdenes por cada cliente, incluso si algunos no han realizado compras.
SELECT Customers.CustomerID, Customers.CompanyName, SUM(Orders.Freight) AS TotalGastado
FROM Orders
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID, Customers.CompanyName;

--5. Muestra una lista de productos junto con sus precios unitarios, incluso si algunos productos no tienen un precio asignado.
SELECT Products.ProductName, Products.UnitPrice
FROM Suppliers
RIGHT JOIN Products ON Suppliers.SupplierID = Products.SupplierID;

--6. Lista todos los productos junto con sus categorías, incluso si algunos productos no tienen una categoría asignada.
SELECT Products.ProductName, Categories.CategoryName
FROM Categories
RIGHT JOIN Products ON Categories.CategoryID = Products.CategoryID;

--7. Muestra a todos los empleados junto con sus territorios de ventas, incluso si algunos empleados no tienen territorios asignados.
SELECT Employees.FirstName, Employees.LastName, Territories.TerritoryDescription
FROM Territories
RIGHT JOIN EmployeeTerritories ON Territories.TerritoryID = EmployeeTerritories.TerritoryID
RIGHT JOIN Employees ON EmployeeTerritories.EmployeeID = Employees.EmployeeID;

--8. Lista todos los productos junto con los pedidos, incluso si algunos productos no han sido pedidos.
SELECT p.ProductName, o.OrderID
FROM Orders o
RIGHT JOIN [Order Details] od ON o.OrderID = od.OrderID
RIGHT JOIN Products p ON od.ProductID = p.ProductID;

--9. Lista todos los clientes junto con sus órdenes, incluso si algunos clientes no han realizado ninguna orden.
SELECT Customers.CustomerID, Customers.CompanyName, Orders.OrderID
FROM Orders
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

--10. Muestra una lista de productos y la cantidad total vendida en órdenes para cada uno, incluso si algunos productos no han sido vendidos.
SELECT Products.ProductName, SUM(od.Quantity) AS TotalVendido
FROM Products
RIGHT JOIN [Order Details] od ON Products.ProductID = od.ProductID
GROUP BY Products.ProductName;

--11. Muestra una lista de productos junto con sus precios unitarios, incluso si algunos productos no tienen un precio asignado.
SELECT Products.ProductName, Products.UnitPrice
FROM Products
RIGHT JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID;

--12. Lista a todos los empleados junto con sus jefes (supervisores), incluso si algunos empleados no tienen un jefe asignado.
SELECT E1.FirstName AS Empleado, E2.FirstName AS Jefe
FROM Employees AS E1
RIGHT JOIN Employees AS E2 ON E1.ReportsTo = E2.EmployeeID;

--13. Muestra una lista de clientes y la cantidad total de dinero gastado en órdenes por cada cliente, incluso si algunos no han realizado compras.
SELECT Customers.CustomerID, Customers.CompanyName, SUM(Orders.Freight) AS TotalGastado
FROM Orders
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID, Customers.CompanyName;

--14. Lista a todos los empleados y muestra la cantidad total de productos vendidos por cada uno, incluso si algunos empleados no han vendido ningún producto.
SELECT Employees.FirstName, Employees.LastName, SUM(od.Quantity) AS TotalVendido
FROM Employees
RIGHT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
RIGHT JOIN [Order Details] od ON Orders.OrderID = od.OrderID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName;

--15. Mostrar una lista de productos con sus nombres y descripciones de la categoria, donde la descripción es un substring de los primeros 50 caracteres de la descripción original.
SELECT p.ProductName, LEFT(CONVERT(nvarchar(max), c.[Description]), 50) AS ShortDescription
FROM Categories c
RIGHT JOIN Products p ON p.CategoryID = c.CategoryID;

--16. Listar los clientes y la cantidad total de órdenes que han realizado, excluyendo aquellos que no han realizado ninguna orden, ordenados por la cantidad total de órdenes en orden descendente.
SELECT Customers.CustomerID, Customers.CompanyName, COUNT(Orders.OrderID) AS TotalOrdenes
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CompanyName
HAVING COUNT(Orders.OrderID) > 0
ORDER BY TotalOrdenes DESC;

--17. Listar los productos y la longitud de sus nombres, ordenados por la longitud del nombre en orden descendente.
SELECT ProductName, LEN(ProductName) AS LongitudNombre
FROM Products
RIGHT JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID;

--18. Obtener una lista de países y la cantidad total de clientes por país, excluyendo países con menos de 3 clientes, ordenados por la cantidad total de clientes en orden descendente.
SELECT Customers.Country, COUNT(Customers.CustomerID) AS TotalClientes
FROM Customers
GROUP BY Customers.Country
HAVING COUNT(Customers.CustomerID) >= 3
ORDER BY TotalClientes DESC;

--19. Mostrar una lista de empleados y la cantidad total de órdenes que han procesado, excluyendo aquellos empleados que no han procesado ninguna orden, ordenados por la cantidad total de órdenes en orden ascendente.
SELECT Employees.FirstName, Employees.LastName, COUNT(Orders.OrderID) AS TotalOrdenes
FROM Employees
RIGHT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
HAVING COUNT(Orders.OrderID) > 0
ORDER BY TotalOrdenes ASC;

--20. Listar los empleados y la fecha mínima de inicio de empleo en su departamento, ordenados por el departamento y la fecha.
SELECT E.EmployeeID, E.FirstName, E.LastName, MIN(O.OrderDate) AS MinOrderDate
FROM Employees AS E
LEFT JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
GROUP BY E.EmployeeID, E.FirstName, E.LastName
ORDER BY E.EmployeeID;

--21. Obtener una lista de categorías de productos junto con la cantidad de productos en cada categoría. Se excluyen las categorías que no tienen productos y se ordena la lista en orden descendente según la cantidad total de productos en cada categoría. 
SELECT Categories.CategoryName, COUNT(Products.ProductID) AS TotalProductos
FROM Categories
RIGHT JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryName
HAVING COUNT(Products.ProductID) > 0
ORDER BY TotalProductos DESC;

-- 22. Mostrar una lista de empleados y la diferencia en días entre su fecha de contratación y la fecha actual.
SELECT Employees.FirstName, Employees.LastName, DATEDIFF(DAY, Employees.HireDate, GETDATE()) AS DiasTrabajados
FROM Employees
ORDER BY DiasTrabajados DESC;

--23. Consulta de productos con nombre largo y exclusión de categorías
SELECT p.ProductName, c.CategoryName
FROM Products p
RIGHT JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE LEN(p.ProductName) > 20 AND p.CategoryID NOT IN (1, 2, 3)
ORDER BY c.CategoryName, p.ProductName;

--24. Mostrar una lista de clientes y sus direcciones completas (concatenando dirección, ciudad y país), incluyendo aquellos clientes que no tienen una dirección registrada.
SELECT Customers.CustomerID, CONCAT(Customers.Address, ', ', Customers.City, ', ', Customers.Country) AS DireccionCompleta
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

--25. Listar los productos y sus nombres abreviados, incluyendo aquellos productos que no tienen una abreviatura en su nombre. La abreviatura se obtiene tomando las primeras tres letras del nombre del producto.
SELECT Products.ProductName, 
       CASE WHEN CHARINDEX(' ', Products.ProductName) > 0 THEN 
           LEFT(Products.ProductName, CHARINDEX(' ', Products.ProductName) - 1)
       ELSE Products.ProductName END AS NombreAbreviado
FROM Products
RIGHT JOIN Categories ON Products.CategoryID = Categories.CategoryID;

--Consultas con FULL JOIN
--1. Listar los nombres de los empleados concatenando el nombre y el apellido, y mostrar la fecha de inicio de empleo en formato 'YYYY-MM-DD'.
SELECT CONCAT(Employees.FirstName, ' ', Employees.LastName) AS NombreCompleto,
       FORMAT(Employees.HireDate, 'yyyy-MM-dd') AS FechaInicio
FROM Employees
FULL JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID;

--2. Obtener una lista de clientes y contar la cantidad de órdenes que han realizado, mostrando solo aquellos clientes que han realizado más de 5 órdenes.
SELECT Customers.CustomerID, Customers.CompanyName,
       COUNT(Orders.OrderID) AS TotalOrdenes
FROM Customers
FULL JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CompanyName
HAVING COUNT(Orders.OrderID) > 5;

--3. Listar los productos y enumerarlos por categoría, mostrando solo los productos con un precio unitario superior a $30.
SELECT Products.ProductName, Products.UnitPrice, Categories.CategoryName,
       ROW_NUMBER() OVER (PARTITION BY Categories.CategoryName ORDER BY Products.ProductName) AS NumeroDeProducto
FROM Products
FULL JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Products.UnitPrice > 30;

--4. Mostrar la diferencia en días entre la fecha de pedido y la fecha de entrega de cada orden.
SELECT Orders.OrderID, Orders.OrderDate, Orders.ShippedDate,
       DATEDIFF(day, Orders.OrderDate, Orders.ShippedDate) AS DiasDeEnvio
FROM Orders
FULL JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID;

--5. Obtener una lista de empleados y la cantidad total de productos vendidos por cada uno, incluyendo aquellos empleados que no han vendido ningún producto.
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName,
       ISNULL(SUM(od.Quantity), 0) AS TotalProductosVendidos
FROM Employees
FULL JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
FULL JOIN [Order Details] od ON Orders.OrderID = od.OrderID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName;

--6. Mostrar los primeros 3 caracteres de cada nombre de producto y contar la cantidad de productos con los mismos tres primeros caracteres.
SELECT SUBSTRING(Products.ProductName, 1, 3) AS TresPrimerosCaracteres,
       COUNT(*) AS CantidadDeProductos
FROM Products
FULL JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
GROUP BY SUBSTRING(Products.ProductName, 1, 3);

--7. Listar los productos y mostrar el precio unitario promedio de todos los productos de la misma categoría.
SELECT Products.ProductName, Products.UnitPrice, Categories.CategoryName,
       AVG(Products.UnitPrice) OVER (PARTITION BY Categories.CategoryName) AS PrecioUnitarioPromedio
FROM Products
FULL JOIN Categories ON Products.CategoryID = Categories.CategoryID;

--8. Mostrar la cantidad de órdenes realizadas por día de la semana.
SELECT DATEPART(weekday, Orders.OrderDate) AS DiaSemana, 
       COUNT(Orders.OrderID) AS CantidadOrdenes
FROM Orders
FULL JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY DATEPART(weekday, Orders.OrderDate)
ORDER BY DiaSemana;

--9. Obtener una lista de proveedores y mostrar el producto más caro suministrado por cada proveedor.
SELECT Suppliers.CompanyName, Products.ProductName, MAX(Products.UnitPrice) AS PrecioMasAlto
FROM Suppliers
FULL JOIN Products ON Suppliers.SupplierID = Products.SupplierID
GROUP BY Suppliers.CompanyName, Products.ProductName;

--10. Listar los empleados y mostrar sus apellidos en mayúsculas.
SELECT Employees.EmployeeID, Employees.FirstName, UPPER(Employees.LastName) AS ApellidoEnMayusculas
FROM Employees
FULL JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID;

--11. Listar las órdenes y mostrar la fecha actual de la consulta.
SELECT Employees.EmployeeID, Employees.FirstName, UPPER(Employees.LastName) AS ApellidoEnMayusculas
FROM Employees
FULL JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID;

--12. Mostrar los productos y asignar un rango a los productos en función de su precio unitario dentro de cada categoría.
SELECT Products.ProductName, Products.UnitPrice, Categories.CategoryName,
       RANK() OVER (PARTITION BY Categories.CategoryName ORDER BY Products.UnitPrice) AS RangoPrecio
FROM Products
FULL JOIN Categories ON Products.CategoryID = Categories.CategoryID;

--13. Listar los clientes y mostrar la longitud de los nombres de la empresa.
SELECT Customers.CustomerID, Customers.CompanyName, LEN(Customers.CompanyName) AS LongitudNombreEmpresa
FROM Customers
FULL JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

--14. Mostrar la fecha de pedido y la fecha de entrega aumentadas en 7 días para cada orden.
SELECT Orders.OrderID, Orders.OrderDate, Orders.ShippedDate,
       DATEADD(day, 7, Orders.OrderDate) AS FechaPedidoAumentada,
       DATEADD(day, 7, Orders.ShippedDate) AS FechaEntregaAumentada
FROM Orders
FULL JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID;

--15. Obtener una lista de productos y mostrar el precio unitario más bajo de todos los productos de la misma categoría.
SELECT Products.ProductName, Products.UnitPrice, Categories.CategoryName,
       MIN(Products.UnitPrice) OVER (PARTITION BY Categories.CategoryName) AS PrecioUnitarioMasBajo
FROM Products
FULL JOIN Categories ON Products.CategoryID = Categories.CategoryID;

--16. Listar los empleados y reemplazar el carácter 'a' por 'A' en sus nombres.
SELECT Employees.EmployeeID, REPLACE(Employees.FirstName, 'a', 'A') AS NombreModificado
FROM Employees
FULL JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID;

--17. Mostrar la cantidad de clientes distintos que realizaron órdenes en cada mes.
SELECT DATEPART(month, Orders.OrderDate) AS Mes,
       COUNT(DISTINCT Customers.CustomerID) AS ClientesDistintos
FROM Orders
FULL JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY DATEPART(month, Orders.OrderDate)
ORDER BY Mes;

--18. Obtener una lista de órdenes y mostrar el año y el mes de cada orden.
SELECT Orders.OrderID, Orders.OrderDate,
       YEAR(Orders.OrderDate) AS Año,
       MONTH(Orders.OrderDate) AS Mes
FROM Orders
FULL JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID;

--19. Listar los productos y mostrar solo los primeros 5 caracteres de sus nombres.
SELECT Products.ProductName, LEFT(Products.ProductName, 5) AS Primeros5Caracteres
FROM Products
FULL JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID;

--20. Obtener una lista de empleados y mostrar la fecha máxima de inicio de empleo.
SELECT Employees.FirstName, Employees.LastName, MAX(Employees.HireDate) AS FechaMaximaInicio
FROM Employees
FULL JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.FirstName, Employees.LastName;

--21. Obtener una lista de órdenes y mostrar el número de día de la semana en que se realizó cada pedido.
SELECT Orders.OrderID, Orders.OrderDate, DATEPART(weekday, Orders.OrderDate) AS DiaSemanaPedido
FROM Orders
FULL JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

--22. Listar las categorías de productos y contar cuántos productos pertenecen a cada categoría.
SELECT Categories.CategoryName, COUNT(Products.ProductID) AS CantidadProductos
FROM Categories
FULL JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryName;

--23. Mostrar una lista de clientes y limitar la longitud de sus nombres de empresa a 20 caracteres.
SELECT Customers.CustomerID, LEFT(Customers.CompanyName, 20) AS NombreEmpresaCorto
FROM Customers
FULL JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

--24. Obtener una lista de productos y mostrar el precio unitario más alto para cada producto.
SELECT Products.ProductName, MAX(Products.UnitPrice) AS PrecioUnitarioMaximo
FROM Products
FULL JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
GROUP BY Products.ProductName;

--25. Mostrar una lista de empleados y mostrar la fecha y hora actual de sus registros.
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, GETDATE() AS FechaHoraActual
FROM Employees
FULL JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID;