IF NOT EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportPageID='30596D10-21ED-40D1-AC4A-BC221ADC643B')
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
				   '30596D10-21ED-40D1-AC4A-BC221ADC643B'
				   ,'40000000-0000-0000-0000-000000000008'
				   ,'00000000-0000-0000-0000-000000000000'
				   ,'Style_Header_LLT'
				   ,'Style Graded Spec & Rules With Comments'
				   ,'Style Graded Spec & Rules With Comments'
				   ,'SQL'
				   ,'Style_GradedSpecRulesComments_Body_LLT'
				   ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
				   ,'StyleID'
				   ,1
				   ,'PDF'
			   )

	END

	Go


		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '5.0.0000', '03609', GetDate())
GO