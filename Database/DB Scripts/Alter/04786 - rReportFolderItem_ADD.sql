IF NOT EXISTS (SELECT * FROM rReportFolderItem WHERE ReportFormName = 'Style_Development_Status_LLT')
BEGIN
	DECLARE @ReportFolder NVARCHAR(100) = (SELECT AppSettingValue FROM sAppSetting WHERE ConfigFileName = 'Report.config' AND AppSettingKey = 'SqlReportFolderName')

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
		'ADBF2711-777D-4B23-91B8-6A05665AAAAD',
		'AB337955-87C7-4F22-AF50-ED0BE7F7ABBD',
		'Style_Development_Status_LLT',
		'Style Status Report',
		'Style Status Report',
		'Report_Main.aspx?R=/' + @ReportFolder + '/Style_Development_Status_LLT',
		'002',
		NULL,
		'PDF',
		NULL,
		NULL
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04786', GetDate())
GO
