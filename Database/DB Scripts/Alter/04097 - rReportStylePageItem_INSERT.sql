IF NOT EXISTS (SELECT * FROM rReportStylePageItem WHERE ReportFormName = 'Style_CostSheetItemsCompare_Body_LLT')
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
			   (NEWID()
			   ,'10000000-0000-0000-0000-000000000010'
			   ,'00000000-0000-0000-0000-000000000000'
			   ,'Style_Header_LLT'
			   ,'Style Costsheet Comparison'
			   ,'Style Costsheet Comparison'
			   ,'SQL'
			   ,'Style_CostSheetItemsCompare_Body_LLT'
			   ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			   ,'StyleId'
			   ,1
			   ,'PDF'
			   ,1
			   ,NULL)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04097', GetDate())
GO
