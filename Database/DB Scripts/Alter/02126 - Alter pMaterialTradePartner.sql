IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pMaterialTradePartner' and COLUMN_NAME = N'MaterialTradePartnerCustom24')
	BEGIN 
		ALTER TABLE pMaterialTradePartner ALTER COLUMN  MaterialTradePartnerCustom24 NVARCHAR(500) null
	END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02126'))
BEGIN
	INSERT INTO sVersion
		(
			AppName
			,[Version]
			,LastScriptRun
			,[TimeStamp]
		)
	VALUES     
		(
			'DB_Version'
			,'4.1.3000'
			,'02126'
			,GetDate()
		)
END	
GO

