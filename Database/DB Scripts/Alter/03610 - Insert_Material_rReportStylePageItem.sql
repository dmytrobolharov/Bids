IF NOT EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportPageID='32B9A947-230A-4209-A253-D8196FFB35CC')
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
				   '32B9A947-230A-4209-A253-D8196FFB35CC'
				   ,'30000000-0000-0000-0000-000000000003'
				   ,'00000000-0000-0000-0000-000000000000'
				   ,'Style_Material_Header_LLT'
				   ,'Material List XML with Comments'
				   ,'Style Material List with comments'
				   ,'ASPX'
				   ,'Style_Component.aspx'
				   ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
				   ,'StyleID'
				   ,1
				   ,'PDF'
			   )

	END
	Go


		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '5.0.0000', '03610', GetDate())
GO