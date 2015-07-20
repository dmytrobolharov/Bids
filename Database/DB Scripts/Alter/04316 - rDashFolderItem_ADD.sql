DELETE FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Style_CostingScenario'
GO

DECLARE @ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
		@DashStyleFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'Style'),
		@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')


INSERT [dbo].[rDashFolderItem] 
(
	[DashFolderItemID], 
	[DashFolderID], 
	[DashFolderItemName], 
	[DashFolderItemUrl], 
	[DashFolderItemIcon], 
	[DashFolderItemSort], 
	[DashFolderItemActive], 
	[DashFolderItemServerUrl], 
	[DashFolderItemServerFolderName], 
	[DashFolderItemServerReportName]
) 
VALUES 
(
	NEWID(),
	@DashStyleFolderID, 
	N'Style Costing Scenario', 
	N'/plmOnDashboards/Dash_Style_CostingScenario', 
	N'icon_chart_bar.gif', 
	N'005', 
	1, 
	@ReportServer, 
	@YuniqueBI, 
	N'Dash_Style_CostingScenario'
)

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04316', GetDate())
GO
