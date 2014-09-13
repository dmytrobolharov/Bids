IF NOT EXISTS (SELECT * FROM rDashFolder WHERE DashFolderName = 'Planning')
	INSERT INTO rDashFolder (DashFolderID, DashFolderName, DashFolderSort, DashFolderActive)
	VALUES (NEWID(), 'Planning', '000', 0)
GO
	
DECLARE @DashFolderID UNIQUEIDENTIFIER = (SELECT DashFolderID FROM rDashFolder WHERE DashFolderName = 'Planning')
DECLARE @ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl')
DECLARE @YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')
IF NOT EXISTS (SELECT * FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Dash_Planning_LineFolder_MainMaterial')
	INSERT INTO rDashFolderItem (DashFolderItemID, DashFolderID, DashFolderItemName, DashFolderItemUrl, DashFolderItemIcon, DashFolderItemSort, DashFolderItemActive, DashFolderItemServerUrl, DashFolderItemServerFolderName, DashFolderItemServerReportName, DashFolderItemLandPage)
	VALUES (NEWID(), @DashFolderID, 'Planning Report', '/plmOnDashboards/Dash_Planning_LineFolder_MainMaterial', 'icon_chart_bar.gif', '000', 0, @ReportServer, @YuniqueBI, 'Dash_Planning_LineFolder_MainMaterial', 0)
GO
