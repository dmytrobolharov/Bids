UPDATE rReportSampleRequestSubmitItem
SET ReportTemplateName = 'v5_' + ReportTemplateName, ReportFormName  = 'v5_' + ReportFormName
WHERE ReportServerType = 'SQL' AND CHARINDEX('v5_', ReportTemplateName) = 0
GO

UPDATE rReportSampleRequestSubmitItem
SET ReportTemplateName = 'v5_' + ReportTemplateName
WHERE ReportServerType = 'ASPX' AND CHARINDEX('v5_', ReportTemplateName) = 0
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04961', GetDate())
GO
