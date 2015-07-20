IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCategory' and COLUMN_NAME = N'Sort')
BEGIN 
	ALTER TABLE pStyleCategory ALTER COLUMN Sort nvarchar(20) NULL
END

Go
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03073'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03073', GetDate())
END
GO	