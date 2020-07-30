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
USING (select [CustomerID],[CustomerName],[BillToCustomerID],[CustomerCategoryID],[BuyingGroupID],[PrimaryContactPersonID],[AlternateContactPersonID],[DeliveryMethodID],[DeliveryCityID],[PostalCityID],[CreditLimit],[AccountOpenedDate],[StandardDiscountPercentage],[IsStatementSent],[IsOnCreditHold],[PaymentDays],[PhoneNumber],[FaxNumber],[DeliveryRun],[RunPosition],[WebsiteURL],[DeliveryAddressLine1],[DeliveryAddressLine2],[DeliveryPostalCode],[DeliveryLocation],[PostalAddressLine1],[PostalAddressLine2],[PostalPostalCode],[LastEditedBy]
	FROM Sales.Customers as c
	WHERE c.CustomerName = 'test7'
	) 
	AS source ([CustomerID],[CustomerName],[BillToCustomerID],[CustomerCategoryID],[BuyingGroupID],[PrimaryContactPersonID],[AlternateContactPersonID],[DeliveryMethodID],[DeliveryCityID],[PostalCityID],[CreditLimit],[AccountOpenedDate],[StandardDiscountPercentage],[IsStatementSent],[IsOnCreditHold],[PaymentDays],[PhoneNumber],[FaxNumber],[DeliveryRun],[RunPosition],[WebsiteURL],[DeliveryAddressLine1],[DeliveryAddressLine2],[DeliveryPostalCode],[DeliveryLocation],[PostalAddressLine1],[PostalAddressLine2],[PostalPostalCode],[LastEditedBy]) 
	ON
	(target.CustomerName = source.CustomerName) 
WHEN MATCHED 
	THEN UPDATE SET CustomerID = source.CustomerID
					,CustomerName = source.CustomerName
					,[BillToCustomerID] = source.[BillToCustomerID]
					,[CustomerCategoryID] = source.[CustomerCategoryID]
					,[BuyingGroupID] = source.[BuyingGroupID]
					,[PrimaryContactPersonID] = source.[PrimaryContactPersonID]
					,[AlternateContactPersonID] = source.[AlternateContactPersonID]
					,[DeliveryMethodID] = source.[DeliveryMethodID]
					,[DeliveryCityID] = source.[DeliveryCityID]
					,[PostalCityID] = source.[PostalCityID]
					,[CreditLimit] = source.[CreditLimit]
					,[AccountOpenedDate] = source.[AccountOpenedDate]
					,[StandardDiscountPercentage] = source.[StandardDiscountPercentage]
					,[IsStatementSent] = source.[IsStatementSent]
					,[IsOnCreditHold] = source.[IsOnCreditHold]
					,[PaymentDays] = source.[PaymentDays]
					,[PhoneNumber] = source.[PhoneNumber]
					,[FaxNumber] = source.[FaxNumber]
					,[DeliveryRun] = source.[DeliveryRun]
					,[RunPosition] = source.[RunPosition]
					,[WebsiteURL] = source.[WebsiteURL]
					,[DeliveryAddressLine1] = source.[DeliveryAddressLine1]
					,[DeliveryAddressLine2] = source.[DeliveryAddressLine2]
					,[DeliveryPostalCode] = source.[DeliveryPostalCode]
					,[DeliveryLocation] = source.[DeliveryLocation]
					,[PostalAddressLine1] = source.[PostalAddressLine1]
					,[PostalAddressLine2] = source.[PostalAddressLine2]
					,[PostalPostalCode] = source.[PostalPostalCode]
					,[LastEditedBy] = source.[LastEditedBy]
WHEN NOT MATCHED 
	THEN INSERT ([CustomerID],[CustomerName],[BillToCustomerID],[CustomerCategoryID],[BuyingGroupID],[PrimaryContactPersonID],[AlternateContactPersonID],[DeliveryMethodID],[DeliveryCityID],[PostalCityID],[CreditLimit],[AccountOpenedDate],[StandardDiscountPercentage],[IsStatementSent],[IsOnCreditHold],[PaymentDays],[PhoneNumber],[FaxNumber],[DeliveryRun],[RunPosition],[WebsiteURL],[DeliveryAddressLine1],[DeliveryAddressLine2],[DeliveryPostalCode],[DeliveryLocation],[PostalAddressLine1],[PostalAddressLine2],[PostalPostalCode],[LastEditedBy]) 
		VALUES (source.CustomerID
					,source.CustomerName
					,source.[BillToCustomerID]
					,source.[CustomerCategoryID]
					,source.[BuyingGroupID]
					,source.[PrimaryContactPersonID]
					,source.[AlternateContactPersonID]
					,source.[DeliveryMethodID]
					,source.[DeliveryCityID]
					,source.[PostalCityID]
					,source.[CreditLimit]
					,source.[AccountOpenedDate]
					,source.[StandardDiscountPercentage]
					,source.[IsStatementSent]
					,source.[IsOnCreditHold]
					,source.[PaymentDays]
					,source.[PhoneNumber]
					,source.[FaxNumber]
					,source.[DeliveryRun]
					,source.[RunPosition]
					,source.[WebsiteURL]
					,source.[DeliveryAddressLine1]
					,source.[DeliveryAddressLine2]
					,source.[DeliveryPostalCode]
					,source.[DeliveryLocation]
					,source.[PostalAddressLine1]
					,source.[PostalAddressLine2]
					,source.[PostalPostalCode]
					,source.[LastEditedBy]) 
OUTPUT deleted.*, $action, inserted.*;

select * from Sales.Customers
where CustomerName like 'test%'

--5 Напишите запрос, который выгрузит данные через bcp out и загрузить через bulk insert

--экспорт из табл в txt-файл
exec master..xp_cmdshell 'bcp "[WideWorldImporters].Sales.InvoiceLines" out  "D:\InvoiceLines15.txt" -T -w -t; -S UFA-OSENOVDD\SQL2019'

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
FROM "D:\InvoiceLines15.txt"
WITH 
	(
	BATCHSIZE = 1000, 
	DATAFILETYPE = 'widechar', --unicode
	FIELDTERMINATOR = ';', --разделитель
	ROWTERMINATOR ='\n',
	KEEPNULLS,
	TABLOCK        
	);