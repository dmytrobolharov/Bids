IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningItem' AND COLUMN_NAME = 'StyleSKUHeaderID')
BEGIN
	ALTER TABLE pPlanningItem ADD StyleSKUHeaderID UNIQUEIDENTIFIER
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07185', GetDate())
GO
