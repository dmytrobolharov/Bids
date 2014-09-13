IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pMaterial' and COLUMN_NAME = N'MaterialTemplateID')
BEGIN 
	ALTER TABLE pMaterial 
	ADD MaterialTemplateID UNIQUEIDENTIFIER NULL
END
GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03366', GetDate())

GO