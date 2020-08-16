--1
INSERT INTO [Sales].[Customers]
           ([CustomerID]
           ,[CustomerName]
           ,[BillToCustomerID]
           ,[CustomerCategoryID]
           ,[BuyingGroupID]
           ,[PrimaryContactPersonID]
           ,[AlternateContactPersonID]
           ,[DeliveryMethodID]
           ,[DeliveryCityID]
           ,[PostalCityID]
           ,[CreditLimit]
           ,[AccountOpenedDate]
           ,[StandardDiscountPercentage]
           ,[IsStatementSent]
           ,[IsOnCreditHold]
           ,[PaymentDays]
           ,[PhoneNumber]
           ,[FaxNumber]
           ,[DeliveryRun]
           ,[RunPosition]
           ,[WebsiteURL]
           ,[DeliveryAddressLine1]
           ,[DeliveryAddressLine2]
           ,[DeliveryPostalCode]
           ,[DeliveryLocation]
           ,[PostalAddressLine1]
           ,[PostalAddressLine2]
           ,[PostalPostalCode]
           ,[LastEditedBy])
VALUES
    (next value for Sequences.CustomerID --<CustomerID, int,>
    ,'test5' --<CustomerName, nvarchar(100),>
    ,1 --<BillToCustomerID, int,>
    ,3 --<CustomerCategoryID, int,>
    ,1 --<BuyingGroupID, int,>
    ,1001 --<PrimaryContactPersonID, int,>
    ,1002 --<AlternateContactPersonID, int,>
    ,3 --<DeliveryMethodID, int,>
    ,19586 --<DeliveryCityID, int,>
    ,19586 --<PostalCityID, int,>
    ,null --<CreditLimit, decimal(18,2),>
    ,'2013-01-01' --<AccountOpenedDate, date,>
    ,0.500 --<StandardDiscountPercentage, decimal(18,3),>
    ,0 --<IsStatementSent, bit,>
    ,0 --<IsOnCreditHold, bit,>
    ,7 --<PaymentDays, int,>
    ,'(308) 555-0100' --<PhoneNumber, nvarchar(20),>
    ,'(308) 555-0101' --<FaxNumber, nvarchar(20),>
    ,null --<DeliveryRun, nvarchar(5),>
    ,null --<RunPosition, nvarchar(5),>
    ,'http://www.tailspintoys.com' --<WebsiteURL, nvarchar(256),>
    ,'Shop 38' --<DeliveryAddressLine1, nvarchar(60),>
    ,'1877 Mittal Road' --<DeliveryAddressLine2, nvarchar(60),>
    ,'90410' --<DeliveryPostalCode, nvarchar(10),>
    ,null --<DeliveryLocation, geography,>
    ,'PO Box 8975' --<PostalAddressLine1, nvarchar(60),>
    ,'Ribeiroville' --<PostalAddressLine2, nvarchar(60),>
    ,'90410' --<PostalPostalCode, nvarchar(10),>
    ,1 --<LastEditedBy, int,>
	)

-- по аналогии еще 4 строки

select * from Sales.Customers
where CustomerName like 'test%'

--2

delete from Sales.Customers 
where CustomerName = 'test5';

--3

UPDATE Sales.Customers 
SET CreditLimit = '777' 
WHERE CustomerName = 'test4';

select * from Sales.Customers
where CustomerName = 'test4'

--4 Написать MERGE, который вставит запись в клиенты, если ее там нет, и изменит если она уже есть

MERGE Sales.Customers AS target 
USING (SELECT CustomerID
				,CustomerName
				,LastEditedBy
				,BillToCustomerID
				,CustomerCategoryID
				,PrimaryContactPersonID
				,DeliveryMethodID
				,DeliveryCityID
				,PostalCityID
				,AccountOpenedDate
				,StandardDiscountPercentage
				,IsStatementSent
				,IsOnCreditHold
				,PaymentDays
				,PhoneNumber
				,FaxNumber
				,WebsiteURL
				,DeliveryAddressLine1
				,DeliveryPostalCode
				,PostalAddressLine1
				,PostalPostalCode
		FROM Sales.Customers as c 
		) 
		AS source (CustomerID
					,CustomerName
					,LastEditedBy
					,BillToCustomerID
					,CustomerCategoryID
					,PrimaryContactPersonID
					,DeliveryMethodID
					,DeliveryCityID
					,PostalCityID
					,AccountOpenedDate
					,StandardDiscountPercentage
					,IsStatementSent
					,IsOnCreditHold
					,PaymentDays
					,PhoneNumber
					,FaxNumber
					,WebsiteURL
					,DeliveryAddressLine1
					,DeliveryPostalCode
					,PostalAddressLine1
					,PostalPostalCode
					) ON
		(target.CustomerID = source.CustomerID) 
WHEN MATCHED 
	THEN UPDATE SET LastEditedBy = source.LastEditedBy
WHEN NOT MATCHED 
	THEN INSERT (CustomerID
					,CustomerName
					,LastEditedBy
					,BillToCustomerID
					,CustomerCategoryID
					,PrimaryContactPersonID
					,DeliveryMethodID
					,DeliveryCityID
					,PostalCityID
					,AccountOpenedDate
					,StandardDiscountPercentage
					,IsStatementSent
					,IsOnCreditHold
					,PaymentDays
					,PhoneNumber
					,FaxNumber
					,WebsiteURL
					,DeliveryAddressLine1
					,DeliveryPostalCode
					,PostalAddressLine1
					,PostalPostalCode
					) 
			VALUES (source.CustomerID
					,source.CustomerName
					,source.LastEditedBy
					,source.BillToCustomerID
					,source.CustomerCategoryID
					,source.PrimaryContactPersonID
					,source.DeliveryMethodID
					,source.DeliveryCityID
					,source.PostalCityID
					,source.AccountOpenedDate
					,source.StandardDiscountPercentage
					,source.IsStatementSent
					,source.IsOnCreditHold
					,source.PaymentDays
					,source.PhoneNumber
					,source.FaxNumber
					,source.WebsiteURL
					,source.DeliveryAddressLine1
					,source.DeliveryPostalCode
					,source.PostalAddressLine1
					,source.PostalPostalCode
				) 
	OUTPUT $action, deleted.*,  inserted.*;

--5 Напишите запрос, который выгрузит данные через bcp out и загрузить через bulk insert

--экспорт из табл в txt-файл
exec master..xp_cmdshell 'bcp "[WideWorldImporters].Sales.InvoiceLines" out  "D:\DemoTable.txt" -T -w -t; -S UFA-OSENOVDD\SQL2019'

-- удалить табл если есть
drop table if exists [Sales].[InvoiceLines_BulkDemo]

--создать таблицу
CREATE TABLE [Sales].[InvoiceLines_BulkDemo](
	[InvoiceLineID] [int] NOT NULL,
	[InvoiceID] [int] NOT NULL,
	[StockItemID] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[PackageTypeID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[TaxRate] [decimal](18, 3) NOT NULL,
	[TaxAmount] [decimal](18, 2) NOT NULL,
	[LineProfit] [decimal](18, 2) NOT NULL,
	[ExtendedPrice] [decimal](18, 2) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Sales_InvoiceLines_BulkDemo] PRIMARY KEY CLUSTERED 
(
	[InvoiceLineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

select * from [Sales].[InvoiceLines_BulkDemo]

--Импорт из файла
BULK INSERT [WideWorldImporters].[Sales].[InvoiceLines_BulkDemo]
FROM "D:\DemoTable.txt"
WITH 
	(
	BATCHSIZE = 1000, 
	DATAFILETYPE = 'widechar', --unicode
	FIELDTERMINATOR = ';', --разделитель
	ROWTERMINATOR ='\n',
	KEEPNULLS,
	TABLOCK        
	);