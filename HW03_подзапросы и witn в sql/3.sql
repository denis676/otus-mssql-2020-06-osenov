--1. Выберите сотрудников (Application.People), которые являются продажниками (IsSalesPerson), и не сделали ни одной продажи 04 июля 2015 года. Вывести ИД сотрудника и его полное имя. Продажи смотреть в таблице Sales.Invoices.

select
	PersonID,
	FullName,
(select
count(Invoiceid) as SalesCount
from Sales.Invoices i
where  i.SalespersonPersonID = p.PersonID and i.InvoiceDate = '2015-07-04'
) as TotalSaledCount
from Application.People p
where IsSalesperson = 0 

with a
as (
	select PersonID 
	from Application.People 
	where IsSalesperson = '1'
except
	select SalespersonPersonID
	from Sales.Invoices sal
	where InvoiceDate = '2015-07-04'
)
select p.PersonID, p.FullName  
from a
join Application.People p 
on p.PersonID = a.PersonID

--2. Выберите товары с минимальной ценой (подзапросом). Сделайте два варианта подзапроса. Вывести: ИД товара, наименование товара, цена.

select StockItemID, StockItemName, UnitPrice
from Warehouse.StockItems
where UnitPrice = (
	select min(UnitPrice) 
	from Warehouse.StockItems
);

with b
as (
	select StockItemID, StockItemName, UnitPrice 
	from Warehouse.StockItems 
	where UnitPrice <= (
		select min(UnitPrice) as MinPrice 
		from Warehouse.StockItems)
)
select * from b;

--3. Выберите информацию по клиентам, которые перевели компании пять максимальных платежей из Sales.CustomerTransactions. Представьте несколько способов (в том числе с CTE).

select distinct c.CustomerName
from Sales.Customers c
join (select top 5 *
	from Sales.CustomerTransactions ct
	order by ct.TransactionAmount desc
) as D
on c.CustomerID = D.CustomerID

with x as (
	select top 5 *
	from Sales.CustomerTransactions ct
	order by ct.TransactionAmount desc
)
select distinct c.CustomerName
from Sales.Customers c
inner join x on x.CustomerID = c.CustomerID

--4. Выберите города (ид и название), в которые были доставлены товары, входящие в тройку самых дорогих товаров, а также имя сотрудника, который осуществлял упаковку заказов (PickedByPersonID).

with richItems as(
	select top 3 StockItemID
	from Warehouse.StockItems
	order by UnitPrice desc
)
select DeliveryCityID, CityName, p.FullName
from Sales.OrderLines ol
inner join Sales.Orders o on o.OrderID = ol.OrderID
inner join richItems i on i.StockItemID = ol.StockItemID
inner join Sales.Customers c on c.CustomerID = o.CustomerID
inner join Application.People p on p.PersonID = o.PickedByPersonID
inner join Application.Cities cit on cit.CityID = c.DeliveryCityID