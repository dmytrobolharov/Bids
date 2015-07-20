DELETE FROM rReportFolderItem WHERE ReportFormName = 'Dash_Style_Change'
GO

DELETE FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Style_Change'
GO

DECLARE @ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
		@DashStyleFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'Style'),
		@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')


INSERT INTO rDashFolderItem(DashFolderItemID, DashFolderID, DashFolderItemName, DashFolderItemUrl, DashFolderItemIcon, DashFolderItemSort, DashFolderItemActive, DashFolderItemServerUrl, DashFolderItemServerFolderName, DashFolderItemServerReportName) 
VALUES (NEWID(), @DashStyleFolderID, 'Style Change Log', '/plmOnDashboards/Dash_Style_Change', 'icon_chart_bar.gif', '002', 1, @ReportServer, @YuniqueBI, 'Dash_Style_Change')
GO	

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04136', GetDate())
GO