UPDATE rReportStylePageItem
SET ReportTemplateName = 'v5_' + ReportTemplateName, 
	ReportFormName = 'v5_' + ReportFormName
WHERE ReportPageID IN
(SELECT ReportPageID FROM rReportStylePageItem
	INNER JOIN pWorkflow on ReportMapID = WorkflowID
	INNER JOIN Mapping on ReportMapID = Mapping.Map
WHERE pWorkflow.Active = 1 and ReportPageActive = 1 and ReportServerType = 'SQL')
AND CHARINDEX('v5', ReportFormName, 0) = 0
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04907', GetDate())
GO
