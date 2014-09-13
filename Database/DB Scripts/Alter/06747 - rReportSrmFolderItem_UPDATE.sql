UPDATE rReportSrmFolderItem
SET ReportSrmFolderItemUrl = 'Dash_AgentVendor_ChangeActivityTracking_Body_SrmOn_LLT&h=0'
WHERE ReportSrmFolderItemName = 'Sample Request'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06747', GetDate())
GO
