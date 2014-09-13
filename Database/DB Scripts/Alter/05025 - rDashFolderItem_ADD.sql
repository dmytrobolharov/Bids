UPDATE rDashFolderItem SET DashFolderItemSort = '001' WHERE DashFolderItemServerReportName = 'Dash_Quote_Summary_COO'
UPDATE rDashFolderItem SET DashFolderItemSort = '002' WHERE DashFolderItemServerReportName = 'Dash_Quote_SharedComments'
UPDATE rDashFolderItem SET DashFolderItemSort = '003' WHERE DashFolderItemServerReportName = 'Dash_Quote_Summary_TradePartner'
UPDATE rDashFolderItem SET DashFolderItemSort = '004' WHERE DashFolderItemServerReportName = 'Dash_Style_Quotation'

DECLARE
	@ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
	@DashStyleFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'Sourcing'),
	@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')

IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Commitment_Summary_COO')
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
		[DashFolderItemServerReportName]
	) 
	VALUES 
	(
		NEWID(),
		@DashStyleFolderID, 
		N'Commitment Summary by Country of Origin', 
		N'/plmOnDashboards/Dash_Commitment_Summary_COO', 
		N'icon_chart_pie.gif', 
		'005', 
		1, 
		@ReportServer, 
		@YuniqueBI, 
		N'Dash_Commitment_Summary_COO'
	)
END

IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Commitment_SharedComments')
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
		[DashFolderItemServerReportName]
	) 
	VALUES 
	(
		NEWID(),
		@DashStyleFolderID, 
		N'Commitment Shared Comment Summary', 
		N'/plmOnDashboards/Dash_Commitment_SharedComments', 
		N'icon_chart_bar.gif', 
		'006', 
		1, 
		@ReportServer, 
		@YuniqueBI, 
		N'Dash_Commitment_SharedComments'
	)
END

IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Commitment_Summary_TradePartner')
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
		[DashFolderItemServerReportName]
	) 
	VALUES 
	(
		NEWID(),
		@DashStyleFolderID, 
		N'Commitment Summary by Trade Partner', 
		N'/plmOnDashboards/Dash_Commitment_Summary_TradePartner', 
		N'icon_chart_pie.gif', 
		'007', 
		1, 
		@ReportServer, 
		@YuniqueBI, 
		N'Dash_Commitment_Summary_TradePartner'
	)
END

IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Style_Commitment')
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
		[DashFolderItemServerReportName]
	) 
	VALUES 
	(
		NEWID(),
		@DashStyleFolderID, 
		N'Commitment by Style', 
		N'/plmOnDashboards/Dash_Style_Commitment', 
		N'icon_chart_bar.gif', 
		'008', 
		1, 
		@ReportServer, 
		@YuniqueBI, 
		N'Dash_Style_Commitment'
	)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05025', GetDate())
GO
