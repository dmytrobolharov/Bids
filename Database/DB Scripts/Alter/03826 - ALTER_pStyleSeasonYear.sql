IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleSeasonYear' and  DATA_TYPE = N'varchar')
BEGIN
	ALTER TABLE pStyleSeasonYear ALTER COLUMN StyleSeason nvarchar(50)
	ALTER TABLE pStyleSeasonYear ALTER COLUMN StyleYear nvarchar(50)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03826', GetDate())
GO
