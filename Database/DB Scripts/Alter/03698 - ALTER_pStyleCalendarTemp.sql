IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCalendarTemp' and COLUMN_NAME = N'PKeyId' and DATA_TYPE = N'varchar')
BEGIN
	ALTER TABLE pStyleCalendarTemp ALTER COLUMN PKeyId nvarchar(200)
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCalendarTemp' and COLUMN_NAME = N'CalendarLinkSubId' and DATA_TYPE = N'varchar')
BEGIN
	ALTER TABLE pStyleCalendarTemp ALTER COLUMN CalendarLinkSubId nvarchar(200)
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCalendarTemp' and COLUMN_NAME = N'CalendarType' and DATA_TYPE = N'varchar')
BEGIN
	ALTER TABLE pStyleCalendarTemp ALTER COLUMN CalendarType nvarchar(50)
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCalendarTemp' and COLUMN_NAME = N'CalendarStatus' and DATA_TYPE = N'varchar')
BEGIN
	ALTER TABLE pStyleCalendarTemp ALTER COLUMN CalendarStatus nvarchar(50)
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCalendarTemp' and COLUMN_NAME = N'CalendarDescription' and DATA_TYPE = N'varchar')
BEGIN
	ALTER TABLE pStyleCalendarTemp ALTER COLUMN CalendarDescription nvarchar(200)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03698', GetDate())
GO