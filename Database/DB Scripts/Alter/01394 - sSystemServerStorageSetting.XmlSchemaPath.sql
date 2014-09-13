	
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'sSystemServerStorageSetting'
    AND  COLUMN_NAME = 'XmlSchemaPath')
	ALTER TABLE sSystemServerStorageSetting ADD  XmlSchemaPath UNIQUEIDENTIFIER
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01394', GetDate())

GO