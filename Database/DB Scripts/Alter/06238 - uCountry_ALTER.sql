IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'uCountry' AND COLUMN_NAME = 'CustomSort')
BEGIN
	ALTER TABLE uCountry ADD CustomSort NVARCHAR(5)
END
ELSE
BEGIN
	PRINT 'Column CustomSort is already exist in table uCountry!'
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '06238', GetDate())
GO
