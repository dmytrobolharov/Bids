IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='pControlBOMConfig' AND COLUMN_NAME='ShowLinePlanColors')
BEGIN
	ALTER TABLE pControlBOMConfig
	ADD ShowLinePlanColors BIT DEFAULT 0
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10204', GetUTCDate())
GO
