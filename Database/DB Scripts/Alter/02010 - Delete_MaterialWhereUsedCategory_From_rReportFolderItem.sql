IF EXISTS (SELECT * FROM rReportFolderItem WHERE ReportItemName = 'Material Where Used Category')
	DELETE FROM rReportFolderItem WHERE ReportItemName = 'Material Where Used Category'

GO
---------------------------------------------
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02010'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02010', GetDate())
END
GO