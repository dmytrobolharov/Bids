-- Certificate of Conformity (GroupID = 'X')

IF EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitFolder WHERE ReportSampleRequestSubmitGroup='X')
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
		'F1000000-0000-0000-0000-000000000060',
		'Sample Request Submit',
		'Sample Submit',
		'X',
		'1',
		'001',
		'1',
		'1'
		)
		
		--Fit Comments report
		IF NOT EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitItem WHERE ReportSampleRequestSubmitPageID='3CB4EA80-C34C-4BBD-8F35-E1DBCAA76F01')
		BEGIN
			INSERT INTO [rReportSampleRequestSubmitItem](
						[ReportSampleRequestSubmitPageID]
						,[ReportSampleRequestSubmitFolderID]
						,[ReportPageTypeID]
						,[ReportTemplateName]
						,[ReportPageName]
						,[ReportPageDescription]
						,[ReportServerType]
						,[ReportFormName]
						,[ReportPageURL]
						,[ReportPKIField]
						,[ReportPageActive]
						,[ReportPageFormat]
						,[ReportPageApproved]
						,[ReportPageSort]
					)
					VALUES(
						'3CB4EA80-C34C-4BBD-8F35-E1DBCAA76F01'
						,'F1000000-0000-0000-0000-000000000060'
						,'00000000-0000-0000-0000-000000000000'
						,'SampleRequestSubmit_Material_Header_LLT'
						,'Sample Header'
						,'Sample Request Header'
						,'SQL'
						,'SampleRequestSubmit_Material_VendorComments_Body_LLT'
						,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
						,'StyleID'
						,1
						,'PDF'
						,0
						,'001'
					)
		END
			
	END
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03764', GetDate())
GO