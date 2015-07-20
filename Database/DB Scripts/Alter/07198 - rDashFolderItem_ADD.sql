DECLARE
	@ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
	@DashFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'To Do'),
	@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')

IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_CalendarMilestoneSummary')
BEGIN
	INSERT [dbo].[rDashFolderItem] 
	(
		[DashFolderItemID]
		, [DashFolderID]
		, [DashFolderItemName]
		, [DashFolderItemUrl]
		, [DashFolderItemIcon]
		, [DashFolderItemSort]
		, [DashFolderItemActive]
		, [DashFolderItemServerUrl]
		, [DashFolderItemServerFolderName]
		, [DashFolderItemServerReportName]

	) 
	VALUES 
	(
		NEWID()
		, @DashFolderID
		, N'Calendar'
		, N'/plmOnDashboards/Dash_CalendarMilestoneSummary'
		, N'icon_chart_bar.gif'
		, '004'
		, 1
		, @ReportServer
		, @YuniqueBI
		, N'Dash_CalendarMilestoneSummary'
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07198', GetDate())
GO
