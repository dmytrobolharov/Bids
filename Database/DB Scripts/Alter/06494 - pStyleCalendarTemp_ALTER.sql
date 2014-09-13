IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='SeasonYearID' AND TABLE_NAME='pStyleCalendarTemp')
BEGIN
	ALTER TABLE pStyleCalendarTemp ADD [SeasonYearID] [uniqueidentifier] NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06494', GetDate())
GO
