ALTER TABLE pGRMeasurementsPOMTemplateGroup ALTER COLUMN SizeClass NVARCHAR(400);
ALTER TABLE pGRMeasurementsPOMTemplateGroup ALTER COLUMN SizeRange NVARCHAR(200);
ALTER TABLE pGRMeasurementsPOMTemplateGroup ALTER COLUMN ClassRange NVARCHAR(610);
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09379', GetDate())
GO
