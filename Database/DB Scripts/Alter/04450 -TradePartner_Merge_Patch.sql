UPDATE t1
SET t1.TradePartnerTemplateID = null,
t1.MUser = 'Merge', t1.MDate = CURRENT_TIMESTAMP

FROM uTradePartner t1
    JOIN uTradePartnerRelationshipType t2 INNER JOIN
                      uTradePartnerType t3 ON t2.TradePartnerRelationshipTypeName = t3.Custom AND 
                      t2.TradePartnerLevel = t3.CustomKey on t1.TradePartnerType = t3.CustomKey
                      
GO

delete from uTradePartnerRelationship where CUser = 'Merge'
GO

DECLARE @Row int
DECLARE @Count int  
DECLARE @TradePartnerIDTemp UNIQUEIDENTIFIER
DECLARE @Tradepartnertype nvarchar(50)



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
		select @Tradepartnertype = Tradepartnertype  from uTradePartner where  TradePartnerID = @TradePartnerIDTemp
		if @Tradepartnertype != '3'
			BEGIN
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
			END
		SET @Row   =  @Row  + 1
	END
drop table #TradePartnerTemp

GO
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

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04450', GetDate())
GO 