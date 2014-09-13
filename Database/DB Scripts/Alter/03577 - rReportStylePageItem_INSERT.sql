IF((SELECT COUNT(*) FROM rReportStylePageItem WHERE ReportFormName = 'Style_BOL_Details_LLT') = 0)
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
			   ,'40000000-0000-0000-0000-000000000078'
			   ,'00000000-0000-0000-0000-000000000000'
			   ,'Style_Header_LLT'
			   ,'Style BOL Details'
			   ,'Style BOL Details'
			   ,'SQL'
			   ,'Style_BOL_Details_LLT'
			   ,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			   ,'StyleId'
			   ,1
			   ,'PDF'
			   ,1
			   ,NULL)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03577', GetDate())
GO 