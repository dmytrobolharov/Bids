IF NOT EXISTS(SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
				WHERE TABLE_NAME='pLineFolder' AND COLUMN_NAME='LineListTypeID')
BEGIN
	ALTER TABLE pLineFolder ADD LineListTypeID UNIQUEIDENTIFIER
END

GO

UPDATE pLineFolder SET LineListTypeID = (SELECT TOP 1 LineListTypeID FROM pLineListType ORDER BY Sort)
WHERE LineListTypeID IS NULL

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05176', GetDate())
GO
