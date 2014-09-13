IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_SampleRequestScorecard')
BEGIN

	DECLARE @ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
			@DashSampleFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'Sample'),
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
		@DashSampleFolderID, 
		N'Sample Request Scorecard', 
		N'/plmOnDashboards/Dash_SampleRequestScorecard', 
		N'icon_chart_bar.gif', 
		N'004', 
		1, 
		@ReportServer, 
		@YuniqueBI, 
		N'Dash_SampleRequestScorecard'
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04492', GetDate())
GO
