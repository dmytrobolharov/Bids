DECLARE
	@ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
	@DashStyleFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'Sample'),
	@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')

IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Sample_WorkflowDueDate_Tracking_Body_LLT')
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
		, N'Sample Due Date Tracking'
		, N'/plmOnDashboards/Dash_Sample_WorkflowDueDate_Tracking_Body_LLT'
		, N'icon_chart_bar.gif'
		, '005'
		, 1
		, @ReportServer
		, @YuniqueBI
		, N'Dash_Sample_WorkflowDueDate_Tracking_Body_LLT'
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06972', GetDate())
GO
