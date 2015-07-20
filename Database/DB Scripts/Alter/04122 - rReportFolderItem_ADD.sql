DELETE FROM rReportFolderItem WHERE ReportFolderItemID = 'ADBF2711-777D-4B23-91B8-6A05665AAAC5'
GO

DECLARE @YuniqueBI NVARCHAR(50) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'DashFolderItemServerFolderNameValue')
INSERT INTO rReportFolderItem(ReportFolderItemID, ReportFolderID, ReportFormName, ReportItemName, ReportItemDescription, ReportItemURL, ReportPageFormat, ReportItemSort) 
VALUES('ADBF2711-777D-4B23-91B8-6A05665AAAC5', N'ab337955-87c7-4f22-af50-ed0be7f7abbd', 'Dash_Style_Change', N'Style Change Log', N'Style Change Log', 'Report_Main.aspx?R=/' + @YuniqueBI +'/Dash_Style_Change', 'PDF', '010')
GO	

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04122', GetDate())
GO	