DELETE FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Style_Change_Summary'
GO

DECLARE @ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
		@DashStyleFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'Style'),
		@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')


INSERT INTO rDashFolderItem(DashFolderItemID, DashFolderID, DashFolderItemName, DashFolderItemUrl, DashFolderItemIcon, DashFolderItemSort, DashFolderItemActive, DashFolderItemServerUrl, DashFolderItemServerFolderName, DashFolderItemServerReportName) 
VALUES (NEWID(), @DashStyleFolderID, 'Style Change Log Summary', '/plmOnDashboards/Dash_Style_Change_Summary', 'icon_chart_bar.gif', '004', 1, @ReportServer, @YuniqueBI, 'Dash_Style_Change_Summary')
GO	

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04145', GetDate())
GO