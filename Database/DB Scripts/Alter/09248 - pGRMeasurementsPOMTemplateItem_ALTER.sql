IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pGRMeasurementsPOMTemplateItem' AND COLUMN_NAME = 'bKey')
	ALTER TABLE pGRMeasurementsPOMTemplateItem ADD bKey INT
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0', '09248', GetDate())
GO