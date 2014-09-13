IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleDevelopmentItem' AND COLUMN_NAME = N'Sort')
BEGIN 
	ALTER TABLE pStyleDevelopmentItem ADD Sort INT NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04558', GetDate())
GO
