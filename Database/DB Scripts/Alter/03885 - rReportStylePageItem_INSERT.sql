IF NOT EXISTS (SELECT * FROM rReportStylePageItem WHERE ReportFormName = 'Style_Seasonal_Colors_Body_LLT')
BEGIN
	INSERT INTO [rReportStylePageItem]
			   ([ReportPageID]
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
			   ,[ReportSrmOn]
			   ,[ReportIsWorkflow])
		 VALUES
			   ('4cb4ea80-c34c-4bbd-8f35-e1dbcaa76e55'
			   ,'40000000-0000-0000-0000-000000000044'
			   ,'00000000-0000-0000-0000-000000000000'
			   ,'Style_Header_LLT'
			   ,'Seasonal Colorway'
			   ,'Seasonal Colorway'
			   ,'SQL'
			   ,'Style_Seasonal_Colors_Body_LLT'
			   ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			   ,'StyleId'
			   ,1
			   ,'PDF'
			   ,1
			   ,NULL)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03885', GetDate())
GO
