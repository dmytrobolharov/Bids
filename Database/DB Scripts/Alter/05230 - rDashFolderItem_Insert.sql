
DECLARE @DashFolderID UNIQUEIDENTIFIER = (SELECT DashFolderID FROM rDashFolder WHERE DashFolderName = 'To Do')
DECLARE	@ReportServer NVARCHAR(400) = (SELECT substring(AppSettingValue,1,LEN(AppSettingValue)-1) FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl')
DECLARE	@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')


IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Sourcing_Quotation')
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
		N'Sourcing Quotataion To Do',
		N'/plmOnDashboards/Dash_Sourcing_Quotation',
		N'icon_chart_pie.gif', 
		'001', 
		0, 
		@ReportServer, 
		@YuniqueBI, 
		N'Dash_Sourcing_Quotation',
		NULL
	)
END
GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05230', GetDate())
GO
