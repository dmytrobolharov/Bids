IF NOT EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportPageID='AE5A145D-499E-4F94-BBB9-53C687A18D62')
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
				   'AE5A145D-499E-4F94-BBB9-53C687A18D62'
				   ,'40000000-0000-0000-0000-000000000006'
				   ,'00000000-0000-0000-0000-000000000000'
				   ,'Style_Header_LLT'
				   ,'Design Detail Images & Grid with Comments'
				   ,'Design Detail Images & Grid with comments'
				   ,'SQL'
				   ,'Style_DesignDetailGrid_DesignDetailComments_Body_LLT'
				   ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
				   ,'StyleID'
				   ,1
				   ,'PDF'
			   )

	END
	Go


		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '5.0.0000', '03607', GetDate())
GO