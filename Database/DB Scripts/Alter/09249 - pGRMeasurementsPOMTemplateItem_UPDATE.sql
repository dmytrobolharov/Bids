UPDATE pGRMeasurementsPOMTemplateItem SET bKey = 1
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0', '09249', GetDate())
GO