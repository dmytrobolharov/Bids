IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleDocument' and COLUMN_NAME = N'StyleDocumentName' and DATA_TYPE = N'varchar')
	BEGIN 
		ALTER TABLE pStyleDocument ALTER COLUMN StyleDocumentName nvarchar(500)
	END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03436', GetDate())
GO
