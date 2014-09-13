IF NOT EXISTS (SELECT * FROM rReportStylePageItem where ReportPageID = 'DCFD6435-E77A-48B5-81C2-E0B5D42750E4')
	INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
	VALUES ('DCFD6435-E77A-48B5-81C2-E0B5D42750E4', '40000000-0000-0000-0000-000000000050', '00000000-0000-0000-0000-000000000000', 'v5_Style_Header_LLT', 'Measurement - How To Measure 4 Images', 'Style Measurement', 'SQL', 'v5_Style_Measurement_HowToMeasure_4ImagesPerPage_Body_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 1, 0)
	
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05077', GetDate())
GO
