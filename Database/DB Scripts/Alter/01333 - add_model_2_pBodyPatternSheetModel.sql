IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pBodyPatternSheetModel' and COLUMN_NAME = N'ModelID')
BEGIN
     TRUNCATE TABLE pBodyPatternSheetModel
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pBodyPatternSheetModel' and COLUMN_NAME = N'ModelID')
BEGIN
     ALTER TABLE pBodyPatternSheetModel ADD ModelID uniqueidentifier NOT NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01333', GetDate())

GO