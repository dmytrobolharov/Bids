IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_uTradePartnerRelationship_uTradePartner1]') AND parent_object_id = OBJECT_ID(N'[dbo].[uTradePartnerRelationship]'))
	ALTER TABLE [dbo].[uTradePartnerRelationship] DROP CONSTRAINT [FK_uTradePartnerRelationship_uTradePartner1]
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartner' and COLUMN_NAME = N'Laboratory')
   BEGIN 
		
        ALTER TABLE uTradePartner ADD Laboratory int NULL
   END
GO
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerRelationship' and COLUMN_NAME = N'MUser')
   BEGIN 
		
        ALTER TABLE uTradePartnerRelationship ADD MUser nvarchar(200) NULL
   END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerRelationship' and COLUMN_NAME = N'MDate')
   BEGIN 
		
        ALTER TABLE uTradePartnerRelationship ADD MDate datetime NULL
   END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartner' and COLUMN_NAME = N'CurrencyType')
   BEGIN		
       ALTER TABLE uTradePartner
		ALTER COLUMN CurrencyType uniqueidentifier null
   END
GO

Update uTradePartner set TradePartnerType = '1' where TradePartnerType is null and TradePartnerRelationshipType is null
GO

MERGE uTradePartnerRelationshipType as T2
USING (select CustomKey,Custom,  CASE   
		WHEN CustomKey = '1'  THEN 1  
		WHEN CustomKey = '2' THEN 2  
		WHEN CustomKey = '3' THEN 3  
		WHEN CustomKey > '3' THEN 3 
		END AS TradePartnerLevel, 
		CASE   
		WHEN CustomKey = '1'  THEN 1  
		WHEN CustomKey = '2' THEN 1  
		WHEN CustomKey = '3' THEN 0  
		WHEN CustomKey > '3' THEN 0 
		END AS TradePartnerAllowRelationship, 
		Active
       from uTradePartnerType) as T1
ON lower(T1.Custom) = lower(T2.TradePartnerRelationshipTypeName)

WHEN NOT MATCHED THEN 
  insert (TradePartnerRelationshipTypeID, TradePartnerRelationshipTypeName, TradePartnerAllowRelationship, TradePartnerLevel, Active, CUser, CDate) 
  values(newid(), T1.Custom, T1.TradePartnerAllowRelationship, T1.TradePartnerLevel, T1.Active, 'Merge', CURRENT_TIMESTAMP);
GO
  
Declare @id as uniqueidentifier
set @id = NEWID()
Declare @ItemID as uniqueidentifier
set @ItemID = NEWID()
Declare @PageID as uniqueidentifier
select @PageID = TradePartnerTemplatePageID from uTradePartnerTemplatePage where lower(TradePartnerTemplatePageName) = 'relationship'

Insert into  uTradePartnerTemplate (TradePartnerTemplateID, TradePartnerTemplateName, TradePartnerTemplateDesc,Active,CUser,CDate,MUser,MDate)
values (@id, 'Existing Agent', 'Merged from existing agent', 1, 'Merge', CURRENT_TIMESTAMP,'Merge',CURRENT_TIMESTAMP )

Insert into  uTradePartnerTemplateItem (TradePartnerTemplateItemID, TradePartnerTemplateID, TradePartnerTemplatePageID, Active,CUser,CDate,MUser,MDate)
values (@ItemID, @id, @PageID, 1, 'Merge', CURRENT_TIMESTAMP,'Merge',CURRENT_TIMESTAMP )

DECLARE @Row int
DECLARE @Count int  
DECLARE @TradePartnerType nvarchar(50)
DECLARE @TradePartnerRelationshipTypeID2  UNIQUEIDENTIFIER
DECLARE @TradePartnerRelationshipTypeID3  UNIQUEIDENTIFIER
DECLARE @TradePartnerIDTemp UNIQUEIDENTIFIER
DECLARE @TradePartnerAddressTypeIDTemp UNIQUEIDENTIFIER


CREATE TABLE #TradePartnerTemp  (
	RowID  int IDENTITY (1,1) ,
	TradePartnerTypeTemp nvarchar(50),
	TradePartnerIDTemp  uniqueidentifier
)
INSERT INTO   #TradePartnerTemp (TradePartnerIDTemp,TradePartnerTypeTemp)
SELECT TradePartnerID, TradePartnerType  FROM  uTradePartner
WHERE TradePartnerTemplateID is null

SET @Row = 1
SELECT @Count = COUNT(*) FROM #TradePartnerTemp  

IF @Count IS NULL  SET @Count = 0

SELECT @TradePartnerRelationshipTypeID2 = tprt.TradePartnerRelationshipTypeID
FROM uTradePartnerType tpt INNER JOIN
uTradePartnerRelationshipType tprt ON tpt.Custom = tprt.TradePartnerRelationshipTypeName and tpt.CustomKey = '2'

SELECT @TradePartnerRelationshipTypeID3 = tprt.TradePartnerRelationshipTypeID
FROM uTradePartnerType tpt INNER JOIN
uTradePartnerRelationshipType tprt ON tpt.Custom = tprt.TradePartnerRelationshipTypeName and tpt.CustomKey = '3'

SELECT @TradePartnerAddressTypeIDTemp = TradePartnerAddressTypeID from uTradePartnerAddressType where lower(TradePartnerAddressName) = 'headquarter'

WHILE  @Row <=  @Count
	BEGIN

		
		set @TradePartnerType = null
		set @TradePartnerIDTemp = null

		select @TradePartnerIDTemp = TradePartnerIDTemp, @TradePartnerType = TradePartnerTypeTemp from #TradePartnerTemp where  RowID = @Row
		        

		--if @TradePartnerType = '1' or @TradePartnerType = '2'
		--	BEGIN
			INSERT INTO uTradePartner (
				TradePartnerID, 
				TradePartnerCode,
				TradePartnerName,
				Address1,
				Address2,
				City,
				State,
				PostalCode,
				Country,
				PhoneNumber,
				FaxNumber,
				Username,
				Password,
				Active,
				CUser,
				CDate,
				MUser,
				MDate,
				Comments,
				Freight,
				Duty,
				Fabric,
				Trim,
				FG,
				Mill,
				CurrencyType,
				HKFreight,
				HKDuty,
				USFreight,
				USDuty,
				TradePartnerRelationshipType,
				TradePartnerTemplateID,
				Direct,					
				Laboratory
				)
			SELECT 
				TradePartnerVendorID, 
				VendorCode,
				VendorName,
				Address1,
				Address2,
				City,
				State,
				PostalCode,
				Country,
				PhoneNumber,
				FaxNumber,
				Username,
				Password,
				Active,
				'Merge',
				CURRENT_TIMESTAMP,
				'Merge',
				CURRENT_TIMESTAMP,
				Comments,
				Freight,
				Duty,
				Fabric,
				Trim,
				FG,
				Mill,
				CurrencyType,
				HKFreight,
				HKDuty,
				USFreight,
				USDuty,
				CASE   
				WHEN @TradePartnerType = '1' THEN @TradePartnerRelationshipTypeID2  
				WHEN @TradePartnerType = '2' THEN @TradePartnerRelationshipTypeID3 
				WHEN @TradePartnerType = '3' THEN @TradePartnerRelationshipTypeID3 
				END AS TradePartnerRelationshipType, 
				@id,
				0,
				Laboratory
			  FROM  uTradePartnerVendor
			WHERE TradePartnerID = @TradePartnerIDTemp
				

			--END
		SET @Row   =  @Row  + 1
	END
	drop table #TradePartnerTemp
GO


DECLARE @Row int
DECLARE @Count int  
DECLARE @TradePartnerIDTemp UNIQUEIDENTIFIER




CREATE TABLE #TradePartnerTemp  (
	RowID  int IDENTITY (1,1) ,
	TradePartnerTypeTemp nvarchar(50),
	TradePartnerIDTemp  uniqueidentifier
)
INSERT INTO   #TradePartnerTemp (TradePartnerIDTemp,TradePartnerTypeTemp)
SELECT TradePartnerID, TradePartnerType  FROM  uTradePartner
WHERE TradePartnerTemplateID is null

SET @Row = 1
SELECT @Count = COUNT(*) FROM #TradePartnerTemp  

IF @Count IS NULL  SET @Count = 0


WHILE  @Row <=  @Count
	BEGIN

		set @TradePartnerIDTemp = null

		select @TradePartnerIDTemp = TradePartnerIDTemp from #TradePartnerTemp where  RowID = @Row
		        
			
			INSERT INTO uTradePartnerRelationship (
				TradePartnerMasterID,
				TradePartnerID, 
				CUser,
				CDate,
				MUser,
				MDate
				)
			SELECT
				@TradePartnerIDTemp,
				TradePartnerVendorID, 				
				'Merge',
				CURRENT_TIMESTAMP,
				'Merge',
				CURRENT_TIMESTAMP
			  FROM  uTradePartnerVendor
			WHERE TradePartnerID = @TradePartnerIDTemp
			--END
		SET @Row   =  @Row  + 1
	END
drop table #TradePartnerTemp

	INSERT INTO uTradePartnerContact (
		TradePartnerID, 
		FirstName,
		MiddleName,
		LastName,
		Title,
		PhoneNumber,
		MobileNumber,
		Email,
		CUser,
		CDate,
		MUser,
		MDate
		)
	SELECT 
		TradePartnerVendorID, 
		FirstName,
		MiddleName,
		LastName,
		Title,
		PhoneNumber,
		MobileNumber,
		Email,
		'Merge',
		CURRENT_TIMESTAMP,
		'Merge',
		CURRENT_TIMESTAMP
	  FROM  uTradePartnerVendorContact
	  
Declare @id as uniqueidentifier	
SELECT @id = TradePartnerTemplateID FROM uTradePartnerTemplate where TradePartnerTemplateName = 'Existing Agent' and CUser = 'Merge'
  
UPDATE t1
SET t1.TradePartnerRelationshipType = t2.TradePartnerRelationshipTypeID, t1.TradePartnerTemplateID = @id,
t1.MUser = 'Merge', t1.MDate = CURRENT_TIMESTAMP

FROM uTradePartner t1
    JOIN uTradePartnerRelationshipType t2 INNER JOIN
                      uTradePartnerType t3 ON t2.TradePartnerRelationshipTypeName = t3.Custom AND 
                      t2.TradePartnerLevel = t3.CustomKey on t1.TradePartnerType = t3.CustomKey
                      
                     
                      
                      
GO  

Declare @id as uniqueidentifier	
SELECT @id = TradePartnerTemplateID FROM uTradePartnerTemplate where TradePartnerTemplateName = 'Existing Agent' and CUser = 'Merge'
update uTradePartner set TradePartnerTemplateID = @id where TradePartnerTemplateID is null

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04436', GetDate())
GO                    
                      
                      