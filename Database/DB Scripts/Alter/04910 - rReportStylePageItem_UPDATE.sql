UPDATE rReportStylePageItem SET ReportTemplateName = 'v5_' + ReportTemplateName
WHERE ReportTemplateName = 'Style_Material_Header_LLT'
GO

UPDATE rReportStylePageItem 
SET ReportTemplateName = 'v5_' + ReportTemplateName, ReportFormName = 'v5_' + ReportFormName
WHERE ReportFormName = 'Style_StyleDetailTab_Body_LLT' 
	OR ReportFormName = 'Style_Home_Style_SizeConstruction_Body_LLT'
	OR ReportFormName = 'Style_MaterialImageGrid_Body_LLT'
GO

UPDATE rReportStylePageItem
SET ReportTemplateName = 'v5_' + ReportTemplateName, 
	ReportFormName = 'v5_' + ReportFormName
WHERE ReportPageID IN
(SELECT ReportPageID FROM rReportStylePageItem
	INNER JOIN pWorkflow on ReportMapID = WorkflowID
	INNER JOIN Mapping on ReportMapID = Mapping.Map
WHERE ReportPageActive = 1 and ReportServerType = 'SQL')
AND CHARINDEX('v5', ReportFormName, 0) = 0
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04910', GetDate())
GO
