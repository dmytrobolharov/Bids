UPDATE rReportTechPackPageItem SET ReportTemplateName = 'v5_' + ReportTemplateName
WHERE ReportTemplateName = 'Style_Material_Header_LLT'
GO

UPDATE rReportTechPackPageItem
SET ReportTemplateName = 'v5_' + ReportTemplateName, 
	ReportFormName = 'v5_' + ReportFormName
WHERE ReportServerType = 'SQL' AND CHARINDEX('v5', ReportFormName, 0) = 0
GO


UPDATE rReportStylePageItem SET ReportIsWorkflow = 0 WHERE ReportIsWorkflow IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04918', GetDate())
GO
