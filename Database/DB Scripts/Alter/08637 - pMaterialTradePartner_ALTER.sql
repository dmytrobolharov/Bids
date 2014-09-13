IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pMaterialTradePartner' AND COLUMN_NAME = 'EnableMaterialRequestPages')
BEGIN
	ALTER TABLE pMaterialTradePartner ADD EnableMaterialRequestPages INT
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08637', GetDate())
GO
