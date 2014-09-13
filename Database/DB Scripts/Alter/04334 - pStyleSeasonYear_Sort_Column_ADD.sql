IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleSeasonYear' AND COLUMN_NAME=N'Sort')
	ALTER TABLE pStyleSeasonYear ADD Sort INT
	
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04334', GetDate())
GO
