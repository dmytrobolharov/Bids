IF NOT EXISTS (SELECT * FROM rReportStylePageItem where ReportFormName = 'v5_Style_Coversheet_LLT')
BEGIN
	INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
	VALUES ('C848F9F1-FFDD-4E82-B71E-1CB43F9CFBAC', '70000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000000', 'Blank', 'Style Cover', 'Style Cover', 'SQL', 'v5_Style_Coversheet_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 0, 0)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06760', GetDate())
GO
