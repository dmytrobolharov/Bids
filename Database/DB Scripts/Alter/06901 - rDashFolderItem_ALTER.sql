UPDATE rDashFolderItem SET DashFolderItemSort = '001' WHERE DashFolderItemServerReportName = 'Dash_Quote_SharedComments'
GO
UPDATE rDashFolderItem SET DashFolderItemSort = '002' WHERE DashFolderItemServerReportName = 'Dash_Style_Quotation'
GO
UPDATE rDashFolderItem SET DashFolderItemSort = '003' WHERE DashFolderItemServerReportName = 'Dash_Quote_Change_Summary'
GO
UPDATE rDashFolderItem SET DashFolderItemSort = '004' WHERE DashFolderItemServerReportName = 'Dash_Quote_Change'
GO
UPDATE rDashFolderItem SET DashFolderItemSort = '005' WHERE DashFolderItemServerReportName = 'Dash_Quote_Summary_COO'
GO
UPDATE rDashFolderItem SET DashFolderItemSort = '006' WHERE DashFolderItemServerReportName = 'Dash_Quote_Summary_TradePartner'
GO
UPDATE rDashFolderItem SET DashFolderItemSort = '007' WHERE DashFolderItemServerReportName = 'Dash_Commitment_SharedComments'
GO
UPDATE rDashFolderItem SET DashFolderItemSort = '008' WHERE DashFolderItemServerReportName = 'Dash_Style_Commitment'
GO
UPDATE rDashFolderItem SET DashFolderItemSort = '009' WHERE DashFolderItemServerReportName = 'Dash_Commitment_Change_Summary'
GO
UPDATE rDashFolderItem SET DashFolderItemSort = '010' WHERE DashFolderItemServerReportName = 'Dash_Commitment_Change'
GO
UPDATE rDashFolderItem SET DashFolderItemSort = '011' WHERE DashFolderItemServerReportName = 'Dash_Commitment_Summary_COO'
GO
UPDATE rDashFolderItem SET DashFolderItemSort = '012' WHERE DashFolderItemServerReportName = 'Dash_Commitment_Summary_TradePartner'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06901', GetDate())
GO