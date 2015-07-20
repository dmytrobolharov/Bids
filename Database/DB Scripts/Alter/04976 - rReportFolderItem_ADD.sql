IF NOT EXISTS (SELECT * FROM rReportFolderItem WHERE ReportFormName = 'Dashboard_StyleRemoval')
BEGIN
	DECLARE @ReportFolder NVARCHAR(100) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlReportFolderName')
	DECLARE @ReportFolderID UNIQUEIDENTIFIER = (SELECT ReportFolderID FROM rReportFolder WHERE ReportFolderName = 'Style Folder')
	DECLARE @ItemSort INT = CAST((select top 1 ReportItemSort from rReportFolderItem where ReportFolderID = 'AB337955-87C7-4F22-AF50-ED0BE7F7ABBD' ORDER BY ReportItemSort desc) as INT)
	
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
		'Dashboard_StyleRemoval',
		'Style Deletion History Report',
		'Style Deletion History Report',
		'Report_Main.aspx?R=/' + @ReportFolder + '/Dashboard_StyleRemoval',
		RIGHT('00' + CAST(@ItemSort+1 AS NVARCHAR(3)),3),
		NULL,
		'PDF',
		NULL,
		NULL
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04976', GetDate())
GO
