IF NOT EXISTS (SELECT * FROM rReportStylePageItem where ReportFormName = 'v5_Style_BOMColorway_Body_LLT')
BEGIN
	INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
	VALUES (NEWID(), '40000000-0000-0000-0000-000000000080', '00000000-0000-0000-0000-000000000000', 'v5_Style_Header_LLT', 'Dimensional BOM Colorway', 'Dimensional BOM Colorway', 'SQL', 'v5_Style_BOMColorway_Body_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 1, 0)
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05620', GetDate())
GO
