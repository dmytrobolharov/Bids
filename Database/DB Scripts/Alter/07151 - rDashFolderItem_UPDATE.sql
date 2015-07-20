DECLARE @ReportServer NVARCHAR(400) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlServerReportServerUrl')
DECLARE @YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')

UPDATE rDashFolderItem SET DashFolderItemServerUrl = @ReportServer, DashFolderItemServerFolderName = @YuniqueBI WHERE DashFolderItemServerReportName = 'Dash_Planning_LineFolder_MainMaterial'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07151', GetDate())
GO
