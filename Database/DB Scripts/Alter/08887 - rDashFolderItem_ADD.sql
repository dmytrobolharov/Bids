DECLARE
	@ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
	@DashFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'Material'),
	@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')
	

IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Material_Dev_Exception')
BEGIN

	UPDATE rDashFolderItem
	SET DashFolderItemSort = RIGHT('000' + CAST((CAST(DashFolderItemSort AS INT) + 1) AS NVARCHAR(5)), 3)
	WHERE DashFolderID = @DashFolderID
	AND CAST(DashFolderItemSort AS INT) > 4

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
		, @DashFolderID
		, N'Material Development Exception'
		, N'/plmOnDashboards/Dash_Material_Dev_Exception'
		, N'icon_chart_bar.gif'
		, '005'
		, 1
		, @ReportServer
		, @YuniqueBI
		, N'Dash_Material_Dev_Exception'
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08887', GetDate())
GO
