--1.
select	DATEPART(YYYY,i.InvoiceDate) as 'Год продажи',
		DATEPART(MM,i.InvoiceDate) as 'Месяц продажи',
		AVG(s.UnitPrice) as 'Средняя цена / мес',
		SUM(il.UnitPrice) as 'Сумма продаж'
from Sales.Invoices i
inner join Sales.InvoiceLines il on il.InvoiceID = i.InvoiceID
inner join Warehouse.StockItems s on s.StockItemID = il.StockItemID
group by DATEPART(YYYY,i.InvoiceDate), DATEPART(MM,i.InvoiceDate)
order by DATEPART(YYYY,i.InvoiceDate), DATEPART(MM,i.InvoiceDate)

--2.
select	DATEPART(YYYY,i.InvoiceDate) as 'Год продажи',
		DATEPART(MM,i.InvoiceDate) as 'Месяц продажи',
		SUM(il.UnitPrice) as 'Сумма продаж'
from Sales.Invoices i
inner join Sales.InvoiceLines il on il.InvoiceID = i.InvoiceID
inner join Warehouse.StockItems s on s.StockItemID = il.StockItemID
group by DATEPART(YYYY,i.InvoiceDate), DATEPART(MM,i.InvoiceDate)
having SUM(il.UnitPrice) > 10000
order by DATEPART(YYYY,i.InvoiceDate), DATEPART(MM,i.InvoiceDate)

--3.
select	DATEPART(YYYY,i.InvoiceDate) as 'Год продажи',
	DATEPART(MM,i.InvoiceDate) as 'Месяц продажи',
	si.StockItemName as 'Наименование товара',
	SUM(il.UnitPrice) as 'Сумма продаж',
	i.InvoiceDate as 'Дата первой продажи',
	count(il.Quantity) as 'Количество проданного'
from Sales.Invoices i
inner join Sales.InvoiceLines il on il.InvoiceID = i.InvoiceID
inner join Warehouse.StockItems si on si.StockItemID = il.StockItemID
group by DATEPART(MM,i.InvoiceDate), si.StockItemName, i.InvoiceDate
having count(il.Quantity) < 50
order by i.InvoiceDate, si.StockItemName;

--4.
CREATE DATABASE test1;
GO

CREATE TABLE dbo.MyEmployees
(
EmployeeID smallint NOT NULL,
FirstName nvarchar(30) NOT NULL,
LastName nvarchar(40) NOT NULL,
Title nvarchar(50) NOT NULL,
DeptID smallint NOT NULL,
ManagerID int NULL,
CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC)
);

INSERT INTO dbo.MyEmployees VALUES
(1, N'Ken', N'Sánchez', N'Chief Executive Officer',16,NULL)
,(273, N'Brian', N'Welcker', N'Vice President of Sales',3,1)
,(274, N'Stephen', N'Jiang', N'North American Sales Manager',3,273)
,(275, N'Michael', N'Blythe', N'Sales Representative',3,274)
,(276, N'Linda', N'Mitchell', N'Sales Representative',3,274)
,(285, N'Syed', N'Abbas', N'Pacific Sales Manager',3,273)
,(286, N'Lynn', N'Tsoflias', N'Sales Representative',3,285)
,(16, N'David',N'Bradley', N'Marketing Manager', 4, 273)
,(23, N'Mary', N'Gibson', N'Marketing Specialist', 4, 16);

/*Результат вывода рекурсивного CTE:
EmployeeID Name Title EmployeeLevel
1 Ken Sánchez Chief Executive Officer 1
273 | Brian Welcker Vice President of Sales 2
16 | | David Bradley Marketing Manager 3
23 | | | Mary Gibson Marketing Specialist 4
274 | | Stephen Jiang North American Sales Manager 3
276 | | | Linda Mitchell Sales Representative 4
275 | | | Michael Blythe Sales Representative 4
285 | | Syed Abbas Pacific Sales Manager 3
286 | | | Lynn Tsoflias Sales Representative 4*/

select * from MyEmployees;

with CTE as (
	select EmployeeID, FirstName, LastName, Title, DeptID, ManagerID, 1 as EmployeeLevel, cast('' as varchar) as "Test"
	from MyEmployees 
	where ManagerID is null

	union all

	select me.EmployeeID, me.FirstName, me.LastName, me.Title, me.DeptID, me.ManagerID, EmployeeLevel + 1, cast(c."Test" +'|'+cast(me.EmployeeID as varchar) as varchar) as "Test"
	from MyEmployees me
	inner join CTE c on c.EmployeeID = me.ManagerID
)
select EmployeeID, replicate(' I ',EmployeeLevel-1) + FirstName + LastName as Name, Title, EmployeeLevel from CTE
order by "Test", Name