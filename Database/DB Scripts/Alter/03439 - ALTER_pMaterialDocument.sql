IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pMaterialDocument' and COLUMN_NAME = N'MaterialDocumentName' and DATA_TYPE = N'varchar')
	BEGIN 
		ALTER TABLE pMaterialDocument ALTER COLUMN MaterialDocumentName nvarchar(500)
	END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03439', GetDate())
GO
