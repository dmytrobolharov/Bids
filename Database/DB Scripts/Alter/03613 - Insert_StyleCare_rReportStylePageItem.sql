IF NOT EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportPageID='572BBC65-7226-4B3A-AEFE-4A3290FAFABE')
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
				   '572BBC65-7226-4B3A-AEFE-4A3290FAFABE'
				   ,'40000000-0000-0000-0000-000000000013'
				   ,'00000000-0000-0000-0000-000000000000'
				   ,'Style_Header_LLT'
				   ,'Style Care with Comments'
				   ,'Style Care Instruction with comments'
				   ,'SQL'
				   ,'Style_CareComments_Body_LLT'
				   ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
				   ,'StyleID'
				   ,1
				   ,'PDF'
			   )

	END
	Go


		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '5.0.0000', '03613', GetDate())
GO