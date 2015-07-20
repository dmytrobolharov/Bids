/*Sample Request Submit - QA*/
IF not EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitFolder WHERE ReportSampleRequestSubmitFolderID='f1000000-0000-0000-0000-000000000010')  
  BEGIN
		INSERT INTO [rReportSampleRequestSubmitFolder]
           ([ReportSampleRequestSubmitFolderID]
           ,[ReportSampleRequestSubmitName]
           ,[ReportSampleRequestSubmitFormName]
           ,[ReportSampleRequestSubmitGroup]
           ,[ReportSampleRequestSubmitFinal]           
           ,[ReportSampleRequestSubmitSort]
           ,[Active]
           ,[srmOn])
     VALUES
           ('f1000000-0000-0000-0000-000000000010'
           ,'Sample Request Submit'
           ,'Sample Submit'
           ,'Q'
           ,1           
           ,'001'
           ,1
           ,1)
	END

IF not EXISTS(SELECT ReportSampleRequestSubmitPageID FROM rReportSampleRequestSubmitItem WHERE ReportSampleRequestSubmitFolderID='f1000000-0000-0000-0000-000000000010')  
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
				NEWID()
				,'f1000000-0000-0000-0000-000000000010'
				,'00000000-0000-0000-0000-000000000000'
				,'SampleRequestSubmit_QAImage_Header_LLT'
				,'Sample Header'
				,'Sample Request Header'
				,'SQL'
				,'SampleRequestSubmit_QAWorksheet_Body_LLT'
				,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
				,'StyleID'
				,1
				,'PDF'
				,0
				,'010'
			)
	END
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01526', GetDate())
GO