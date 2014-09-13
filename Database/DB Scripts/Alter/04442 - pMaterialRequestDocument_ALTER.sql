IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pMaterialRequestDocument' and COLUMN_NAME = N'MaterialDocumentName')
BEGIN 
	ALTER TABLE pMaterialRequestDocument ALTER COLUMN MaterialDocumentName nvarchar(500)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04442', GetDate())
GO
