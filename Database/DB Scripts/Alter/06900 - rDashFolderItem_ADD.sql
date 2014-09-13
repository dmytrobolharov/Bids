DECLARE
	@ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
	@DashStyleFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'Sourcing'),
	@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')

IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Quote_Change_Summary')
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
		, @DashStyleFolderID
		, N'Quotations Change Log Summary Report'
		, N'/plmOnDashboards/Dash_Quote_Change_Summary'
		, N'icon_chart_bar.gif'
		, '009'
		, 1
		, @ReportServer
		, @YuniqueBI
		, N'Dash_Quote_Change_Summary'
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06900', GetDate())
GO
