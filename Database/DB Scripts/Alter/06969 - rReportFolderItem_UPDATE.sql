UPDATE rReportFolderItem SET ReportFolderItemActive = 0 WHERE ReportFormName = 'Dash_Style_WorkflowDueDate_Tracking_Body_LLT'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06969', GetDate())
GO
