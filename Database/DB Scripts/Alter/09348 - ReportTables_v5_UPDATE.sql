UPDATE rReportFolderItem SET
	ReportFormName = REPLACE(ReportFormName, 'v5_', '')
GO

UPDATE rReportMaterialRequestSubmitItem SET
	ReportTemplateName = REPLACE(ReportTemplateName, 'v5_', '')
	, ReportFormName = REPLACE(ReportFormName, 'v5_', '')
GO

UPDATE rReportPageItem SET
	ReportTemplateName = REPLACE(ReportTemplateName, 'v5_', '')
	, ReportFormName = REPLACE(ReportFormName, 'v5_', '')
GO

UPDATE rReportSamplePageItemTemp SET
	ReportTemplateName = REPLACE(ReportTemplateName, 'v5_', '')
	, ReportFormName = REPLACE(ReportFormName, 'v5_', '')
GO

UPDATE rReportSampleRequestSubmitFolder SET
	ReportTechPackFormName = REPLACE(ReportTechPackFormName, 'v5_', '')
GO

UPDATE rReportSampleRequestSubmitItem SET
	ReportTemplateName = REPLACE(ReportTemplateName, 'v5_', '')
	, ReportFormName = REPLACE(ReportFormName, 'v5_', '')
GO

UPDATE rReportStylePageItem SET
	ReportTemplateName = REPLACE(ReportTemplateName, 'v5_', '')
	, ReportFormName = REPLACE(ReportFormName, 'v5_', '')
GO

UPDATE rReportStylePageItemTemp SET
	ReportTemplateName = REPLACE(ReportTemplateName, 'v5_', '')
	, ReportFormName = REPLACE(ReportFormName, 'v5_', '')
GO

UPDATE rReportTechPackFolder SET
	ReportTechPackFormName = REPLACE(ReportTechPackFormName, 'v5_', '')
GO

UPDATE rReportTechPackPageItem SET
	ReportTemplateName = REPLACE(ReportTemplateName, 'v5_', '')
	, ReportFormName = REPLACE(ReportFormName, 'v5_', '')
GO

UPDATE pTechPackCoverpage SET
	CustomKey = REPLACE(CustomKey, 'v5_', '')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09348', GetDate())
GO
