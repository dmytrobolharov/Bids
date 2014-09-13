IF NOT EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportPageID='F875341A-4C2C-4A1E-AA46-D6F09E5AC1BF')
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
				   'F875341A-4C2C-4A1E-AA46-D6F09E5AC1BF'
				   ,'40000000-0000-0000-0000-000000000010'
				   ,'00000000-0000-0000-0000-000000000000'
				   ,'Style_Header_LLT'
				   ,'Material Artwork with Comments'
				   ,'Style Material Artwork with comments'
				   ,'SQL'
				   ,'Style_MaterialArtworkComments_Body_LLT'
				   ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
				   ,'StyleID'
				   ,1
				   ,'PDF'
			   )

	END
	
	Go


		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '5.0.0000', '03614', GetDate())
GO