IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_MaterialRequestSubmit_SharedComments')
BEGIN

	DECLARE @ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
			@DashStyleFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'Material'),
			@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue'),
			@Sort NVARCHAR(5)
			
	SET @Sort = (SELECT RIGHT('000' + cast((MAX(DashFolderItemSort) + 1) as nvarchar), 3) FROM rDashFolderItem WHERE DashFolderID = @DashStyleFolderID)

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
		N'Material Request Shared Comment Summary', 
		N'/plmOnDashboards/Dash_MaterialRequestSubmit_SharedComments', 
		N'icon_chart_bar.gif', 
		@Sort, 
		1, 
		@ReportServer, 
		@YuniqueBI, 
		N'Dash_MaterialRequestSubmit_SharedComments'
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04858', GetDate())
GO
