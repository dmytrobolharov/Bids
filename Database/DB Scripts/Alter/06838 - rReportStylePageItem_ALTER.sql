IF NOT EXISTS (SELECT * FROM rReportStylePageItem WHERE ReportFormName = 'v5_Style_ConstructionDetails_1x3_Body_LLT')
	INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
	VALUES (NEWID(), '80000000-0000-0000-0000-000000000008', '00000000-0000-0000-0000-000000000000', 'v5_Style_Header_LLT', 'Process Details (1x3)', 'Style Process Details', 'SQL', 'v5_Style_ConstructionDetails_1x3_Body_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 1, 0)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06838', GetDate())
GO
