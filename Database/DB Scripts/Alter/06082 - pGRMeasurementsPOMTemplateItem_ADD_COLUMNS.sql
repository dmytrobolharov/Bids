IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pGRMeasurementsPOMTemplateItem' AND COLUMN_NAME = 'NonWashTolPlus')
BEGIN
	ALTER TABLE pGRMeasurementsPOMTemplateItem ADD NonWashTolPlus NUMERIC(18, 4) NULL
END
GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pGRMeasurementsPOMTemplateItem' AND COLUMN_NAME = 'NonWashTolMinus')
BEGIN
	ALTER TABLE pGRMeasurementsPOMTemplateItem ADD NonWashTolMinus NUMERIC(18, 4) NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06082', GetDate())
GO
