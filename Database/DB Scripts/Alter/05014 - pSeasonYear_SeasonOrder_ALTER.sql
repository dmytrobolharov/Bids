IF NOT EXISTS (SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
				WHERE TABLE_NAME='pSeasonYear' AND COLUMN_NAME='SeasonOrder')
BEGIN
	ALTER TABLE pSeasonYear ADD SeasonOrder INT DEFAULT 0
END

GO

UPDATE pSeasonYear SET SeasonOrder = 0 WHERE SeasonOrder IS NULL

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05014', GetDate())
GO
