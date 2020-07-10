SELECT StockItemName
FROM Warehouse.StockItems 
WHERE StockItemName like '%urgent%' or StockItemName like 'Animal%'

SELECT SupplierName
FROM Purchasing.Suppliers s
LEFT JOIN Purchasing.PurchaseOrders o on o.SupplierID = s.SupplierID
WHERE o.PurchaseOrderID is null

SELECT o.OrderID, 
OrderDate, CONVERT(nvarchar(16), OrderDate, 104) as Дата,
DATENAME(MONTH, OrderDate) as Месяц,
DAY(OrderDate) AS OrderDay,
DATENAME(quarter, OrderDate) as Квартал,
o.CustomerPurchaseOrderNumber
FROM Sales.Orders o
LEFT JOIN Sales.OrderLines l on o.OrderID = l.OrderID
WHERE (UnitPrice > '100.00' OR Quantity > '20') AND o.PickingCompletedWhen is not null

SELECT dm.DeliveryMethodName, po.ExpectedDeliveryDate, s.SupplierName, p.PreferredName
FROM Purchasing.PurchaseOrders po
INNER JOIN Purchasing.Suppliers s on s.SupplierID = po.SupplierID
INNER JOIN Application.DeliveryMethods dm on dm.DeliveryMethodID = po.DeliveryMethodID
INNER JOIN Application.People p on p.PersonID = po.ContactPersonID
--Если взять первые пару условий в скобки то в ркзультате пусто, а так как в задании не уточнено, но предположил что скобки не нужны
WHERE dm.DeliveryMethodName like 'Air Freight' or dm.DeliveryMethodName like 'Refrigerated Air Freight' and po.ExpectedDeliveryDate like '2014-01-%'

select top 10
	o.*,
	c.CustomerName,
	p.FullName
from Sales.Orders o
inner join Sales.Customers c on c.CustomerID = o.CustomerID
inner join Application.People p on p.PersonID = o.SalespersonPersonID
order by o.OrderDate desc

select distinct
	c.CustomerID,
	c.CustomerName,
	c.PhoneNumber
from Sales.Orders o
inner join Sales.OrderLines ol on ol.OrderID = o.OrderID
inner join Sales.Customers c on c.CustomerID = o.CustomerID
inner join Warehouse.StockItems si on si.StockItemID = ol.StockItemID
where si.StockItemName = 'Chocolate frogs 250g'