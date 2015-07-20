DELETE FROM rReportFolderItem WHERE ReportFormName = 'Desktop_SampleRequestSubmit_SharedComments_Body_PLT'
GO

DELETE FROM rDashFolderItem WHERE DashFolderItemServerReportName = 'Desktop_SampleRequestSubmit_SharedComments_Body_PLT'
GO

DECLARE @ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl'),
		@DashSampleFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 DashFolderID FROM rDashFolder WHERE DashFolderName = 'Sample'),
		@YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')


INSERT INTO rDashFolderItem(DashFolderItemID, DashFolderID, DashFolderItemName, DashFolderItemUrl, DashFolderItemIcon, DashFolderItemSort, DashFolderItemActive, DashFolderItemServerUrl, DashFolderItemServerFolderName, DashFolderItemServerReportName) 
VALUES (NEWID(), @DashSampleFolderID, 'New Sample Request Shared Comments', '/plmOnDashboards/Desktop_SampleRequestSubmit_SharedComments_Body_PLT', 'icon_chart_bar.gif', '002', 1, @ReportServer, @YuniqueBI, 'Desktop_SampleRequestSubmit_SharedComments_Body_PLT')
GO	

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04138', GetDate())
GO