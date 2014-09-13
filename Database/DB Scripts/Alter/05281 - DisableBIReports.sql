UPDATE rDashFolderItem SET DashFolderItemActive = 0
WHERE DashFolderItemServerReportName = 'Dash_Quote_Summary_COO'
OR DashFolderItemServerReportName = 'Dash_Quote_Summary_TradePartner'
OR DashFolderItemServerReportName = 'Dash_Commitment_Summary_COO'
OR DashFolderItemServerReportName = 'Dash_Commitment_Summary_TradePartner'
OR DashFolderItemServerReportName = 'Dash_Sourcing_Quotation'
OR DashFolderItemServerReportName = 'Dash_Sourcing_Commitment'
OR DashFolderItemServerReportName = 'Dash_Style_CostingScenario'

GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'rReportFolderItem' AND COLUMN_NAME='ReportFolderItemActive')
BEGIN ALTER TABLE rReportFolderItem ADD ReportFolderItemActive INT DEFAULT 1 END

GO

UPDATE rReportFolderItem SET ReportFolderItemActive = 0
WHERE ReportFormName = 'Style_PreCosting_LLT'
OR ReportFormName = 'Dash_Style_VendorColor_WorkflowDueDate_Tracking_(Image_Above)_Version2_Body_LLT'
OR ReportFormName = 'LineFolder_Global_4x1_Category_LLT'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05281', GetDate())
GO
