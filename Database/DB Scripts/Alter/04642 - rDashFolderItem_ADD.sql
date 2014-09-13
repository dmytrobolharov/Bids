IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Quote_Summary_TradePartner')
BEGIN

	DECLARE @ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
			@DashStyleFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'Style'),
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
		N'Quote Summary by Trade Partner', 
		N'/plmOnDashboards/Dash_Quote_Summary_TradePartner', 
		N'icon_chart_pie.gif', 
		@Sort, 
		1, 
		@ReportServer, 
		@YuniqueBI, 
		N'Dash_Quote_Summary_TradePartner'
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04642', GetDate())
GO
