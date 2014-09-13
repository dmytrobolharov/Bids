DECLARE
	@ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
	@DashFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'Dev Calendar'),
	@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')

IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'TACal_Extract')
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
		, N'Calendar Extract'
		, N'/plmOnDashboards/TACal_Extract'
		, N'icon_chart_bar.gif'
		, '001'
		, 0
		, @ReportServer
		, @YuniqueBI
		, N'TACal_Extract'
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09078', GetDate())
GO