IF NOT EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportPageID='32E5BD07-19B5-4CAB-BC2C-E5E172D39661')
BEGIN
		INSERT INTO [rReportStylePageItem]
			   (
					[ReportPageID]
				   ,[ReportMapID]
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
			   )
		 VALUES
			   (
				   '32E5BD07-19B5-4CAB-BC2C-E5E172D39661'
				   ,'40000000-0000-0000-0000-000000000050'
				   ,'00000000-0000-0000-0000-000000000000'
				   ,'Style_Header_LLT'
				   ,'Measurement Sample with Comments'
				   ,'Measurement Sample with comments'
				   ,'SQL'
				   ,'Style_Measurement_SampleComments_Body_LLT'
				   ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
				   ,'StyleID'
				   ,1
				   ,'PDF'
			   )

END
ELSE
BEGIN
		UPDATE[rReportStylePageItem]
		SET	[ReportFormName]= 'Style_Measurement_SampleComments_Body_LLT'
		WHERE ReportPageID='32E5BD07-19B5-4CAB-BC2C-E5E172D39661'
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03641', GetDate())
GO