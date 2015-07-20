
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerTemplateItem' and COLUMN_NAME = N'Sort')
BEGIN 
	ALTER TABLE uTradePartnerTemplateItem ADD Sort int NULL Default 0
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerTemplatePage' and COLUMN_NAME = N'Sort')
BEGIN 
	ALTER TABLE uTradePartnerTemplatePage ADD Sort int NULL Default 0
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartner' and COLUMN_NAME = N'TradePartnerTemplateID')
BEGIN 
	ALTER TABLE uTradePartner ADD TradePartnerTemplateID uniqueidentifier null
END


if not exists (select * from uTradePartnerTemplatePage WHERE UPPER(TradePartnerTemplatePageName) = 'SHIPPING INFO')
	begin
		INSERT INTO [uTradePartnerTemplatePage]
				   ([TradePartnerTemplatePageName]
				   ,[TradePartnerTemplatePageDesc]				   			   
				   ,[Active])				   
			 VALUES
				   ('Shipping Info'
				   ,'Shipping Info'				   			  
				   ,1
				  )
	end
	
if not exists (select * from uTradePartnerTemplatePage WHERE UPPER(TradePartnerTemplatePageName) = 'CAPACITY')
	begin
		INSERT INTO [uTradePartnerTemplatePage]
				   ([TradePartnerTemplatePageName]
				   ,[TradePartnerTemplatePageDesc]				   			   
				   ,[Active])				   
			 VALUES
				   ('Capacity'
				   ,'Capacity'				   			  
				   ,1
				  )
	end
	
	if not exists (select * from uTradePartnerTemplatePage WHERE UPPER(TradePartnerTemplatePageName) = 'RELATIONSHIP')
	begin
		INSERT INTO [uTradePartnerTemplatePage]
				   ([TradePartnerTemplatePageName]
				   ,[TradePartnerTemplatePageDesc]				   			   
				   ,[Active])				   
			 VALUES
				   ('Relationship'
				   ,'Relationship'				   			  
				   ,1
				  )
	end		
		
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03252'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03252', GetDate())

END

GO