IF EXISTS (SELECT * FROM rReportFolderItem WHERE ReportItemName = 'Quotation Tracking')
	DELETE FROM rReportFolderItem WHERE ReportItemName = 'Quotation Tracking'

GO
---------------------------------------------
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01663'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01663', GetDate())
END
GO