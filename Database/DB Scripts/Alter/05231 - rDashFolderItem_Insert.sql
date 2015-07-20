DECLARE @DashFolderID UNIQUEIDENTIFIER = (SELECT DashFolderID FROM rDashFolder WHERE DashFolderName = 'To Do')
DECLARE	@ReportServer NVARCHAR(400) = (SELECT substring(AppSettingValue,1,LEN(AppSettingValue)-1) FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl')
DECLARE	@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')

IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Sourcing_Commitment')
BEGIN
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
		[DashFolderItemServerReportName],
		[DashFolderItemLandPage]
	) 
	VALUES 
	(
		NEWID(),
		@DashFolderID, 
		N'Sourcing Commitment To Do',
		N'/plmOnDashboards/Dash_Sourcing_Commitment',
		N'icon_chart_pie.gif', 
		'002', 
		0, 
		@ReportServer, 
		@YuniqueBI, 
		N'Dash_Sourcing_Commitment',
		NULL
	)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05231', GetDate())
GO
