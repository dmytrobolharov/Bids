IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'rReportStylePageItemTemp' and COLUMN_NAME = N'SystemCultureId')
BEGIN 
	ALTER TABLE rReportStylePageItemTemp 
	ADD SystemCultureId UNIQUEIDENTIFIER NULL
END

Go
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03127'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03127', GetDate())
END
GO	
