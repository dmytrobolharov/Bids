IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleHeader' and COLUMN_NAME = N'OwnerGroup')
BEGIN 
	ALTER TABLE pStyleHeader ADD OwnerGroup nvarchar(50) NULL
END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03203'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03203', GetDate())
END
GO	