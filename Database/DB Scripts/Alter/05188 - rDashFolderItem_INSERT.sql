DECLARE @DashFolderID UNIQUEIDENTIFIER = (SELECT DashFolderID FROM rDashFolder WHERE DashFolderName = 'To Do')
DECLARE	@ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl')
DECLARE	@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')

UPDATE rDashFolderItem SET
	DashFolderID = @DashFolderID
	, DashFolderItemSort = '002'
WHERE DashFolderItemName = 'Quote To Do Dashboard'

IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_CommitmentToDo')
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
		@DashFolderID, 
		N'Commitment To Do Dashboard',
		N'/plmOnDashboards/Dash_CommitmentToDo',
		N'icon_chart_pie.gif', 
		'003', 
		1, 
		@ReportServer, 
		@YuniqueBI, 
		N'Dash_CommitmentToDo'
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05188', GetDate())
GO
