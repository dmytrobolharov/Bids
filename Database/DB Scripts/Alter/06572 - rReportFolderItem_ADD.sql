IF NOT EXISTS (SELECT * FROM rReportFolderItem WHERE ReportFormName = 'Dash_Line_List_Fabric')
BEGIN
	DECLARE @ReportFolder NVARCHAR(100) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlReportFolderName')
	DECLARE @ReportFolderID UNIQUEIDENTIFIER = (SELECT ReportFolderID FROM rReportFolder WHERE ReportFolderName = 'Line List Folder')
	DECLARE @ItemSort INT = CAST((select top 1 ReportItemSort from rReportFolderItem where ReportFolderID = @ReportFolderID ORDER BY ReportItemSort desc) as INT)
	
	INSERT INTO rReportFolderItem 
	(
		ReportFolderItemID,
		ReportFolderID,
		ReportFormName,
		ReportItemName, 
		ReportItemDescription, 
		ReportItemURL, 
		ReportItemSort,
		ReportItemXML,
		ReportPageFormat, 
		ReportHeaderItemName,
		ReportHeaderItemXML
	)
	VALUES
	(
		NEWID(),
		@ReportFolderID,
		'Dash_Line_List_Fabric',
		'Line List by Fabric',
		'Line List by Fabric',
		'../Report/Report_Main.aspx?R=/' + @ReportFolder + '/Dash_Line_List_Fabric',
		RIGHT('00' + CAST(@ItemSort+1 AS NVARCHAR(3)),3),
		NULL,
		'PDF',
		NULL,
		NULL
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06572', GetDate())
GO
