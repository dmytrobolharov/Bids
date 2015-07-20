IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Permission_Summary_Main')
BEGIN
	DECLARE @ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
			@DashStyleFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'Admin'),
			@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')


	INSERT INTO rDashFolderItem(
		DashFolderItemID
		, DashFolderID
		, DashFolderItemName
		, DashFolderItemUrl
		, DashFolderItemIcon
		, DashFolderItemSort
		, DashFolderItemActive
		, DashFolderItemServerUrl
		, DashFolderItemServerFolderName
		, DashFolderItemServerReportName) 
	VALUES (
		NEWID()
		, @DashStyleFolderID
		, 'Permission Group Membership Summary'
		, '/plmOnDashboards/Dash_Permission_Summary_Main'
		, 'icon_chart_bar.gif'
		, '001'
		, 1
		, @ReportServer
		, @YuniqueBI
		, 'Dash_Permission_Summary_Main')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04721', GetDate())
GO
