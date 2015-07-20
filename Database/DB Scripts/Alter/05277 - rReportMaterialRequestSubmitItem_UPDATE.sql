UPDATE rReportMaterialRequestSubmitItem
SET ReportTemplateName = 'v5_' + ReportTemplateName, ReportFormName = 'v5_' + ReportFormName
WHERE CHARINDEX('v5_', ReportFormName) = 0
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05277', GetDate())
GO
