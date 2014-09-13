IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pMaterialTradePartner' and COLUMN_NAME = N'MaterialTradePartnerCustom25')
       BEGIN 
            ALTER TABLE pMaterialTradePartner ALTER COLUMN MaterialTradePartnerCustom25 decimal(18, 4) NULL
       END
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01831'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01831', GetDate())
	END
GO