Update rReportSrmFolderItem set ReportSrmFolderItemUrl = 'Dash_AgentVendor_ChangeActivityTracking_Body_LLT&h=0' where ReportSrmFolderItemName = 'Sample Request'
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03894', GetDate())
GO
