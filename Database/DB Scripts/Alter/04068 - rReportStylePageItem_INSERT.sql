IF EXISTS (SELECT * FROM rReportStylePageItem WHERE ReportFormName = 'Style_CostSheet_Body_LLT' AND ReportPageName = 'Style Costing')
BEGIN
	UPDATE rReportStylePageItem
	SET ReportPageName = 'Style Costing Summary', ReportPageDescription = 'Style Costing Summary'
	WHERE ReportFormName = 'Style_CostSheet_Body_LLT' AND ReportPageName = 'Style Costing'
END
GO

IF NOT EXISTS (SELECT * FROM rReportStylePageItem WHERE ReportFormName = 'Style_CostSheetItem_Body_LLT')
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
			   ,'Style Costsheet'
			   ,'Style Costsheet'
			   ,'SQL'
			   ,'Style_CostSheetItem_Body_LLT'
			   ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			   ,'StyleId'
			   ,1
			   ,'PDF'
			   ,1
			   ,NULL)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04068', GetDate())
GO
