IF EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitFolder WHERE ReportSampleRequestSubmitGroup='E')
   BEGIN
        PRINT 'Sample Request Report already exists'
   END
ELSE
	BEGIN
		INSERT INTO rReportSampleRequestSubmitFolder
		(
		ReportSampleRequestSubmitFolderID,
		ReportSampleRequestSubmitName,
		ReportSampleRequestSubmitFormName,
		ReportSampleRequestSubmitGroup,
		ReportSampleRequestSubmitFinal,
		ReportSampleRequestSubmitSort,
		Active,
		srmOn
		)
		VALUES 
		(
		'F1000000-0000-0000-0000-000000000050',
		'Sample Request Submit',
		'Sample Submit',
		'E',
		'1',
		'001',
		'1',
		'1'
		)
	END
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03580', GetDate())
GO