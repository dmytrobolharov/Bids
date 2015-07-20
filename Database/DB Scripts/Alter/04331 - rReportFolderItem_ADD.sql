IF NOT EXISTS (SELECT * FROM rReportFolder WHERE ReportFolderName = 'Image Folder')
BEGIN
	INSERT INTO rReportFolder (ReportFolderID, ReportFolderName, ReportFolderSort)
	VALUES ('AB337955-87C7-4F22-AF50-ED0BE7F7ABBC', 'Image Folder', '00002')
END
GO

IF NOT EXISTS (SELECT * FROM rReportFolderItem WHERE ReportFormName = 'Dash_Image_Management_Report_LLT')
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
		'ADBF2711-777D-4B23-91B8-6A05665AAAD1',
		'AB337955-87C7-4F22-AF50-ED0BE7F7ABBC',
		'Dash_Image_Management_Report_LLT',
		'Image',
		'Image',
		'Report_Main.aspx?R=/' + @ReportFolder + '/Dash_Image_Management_Report_LLT',
		'001',
		NULL,
		'PDF',
		NULL,
		NULL
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04331', GetDate())
GO
