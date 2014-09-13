IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Quote_SharedComments')
BEGIN

	DECLARE @ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
			@DashStyleFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'Style'),
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
		@DashStyleFolderID, 
		N'Quotation Shared Comments Summary', 
		N'/plmOnDashboards/Dash_Quote_SharedComments', 
		N'icon_chart_bar.gif', 
		N'007', 
		1, 
		@ReportServer, 
		@YuniqueBI, 
		N'Dash_Quote_SharedComments'
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04505', GetDate())
GO
