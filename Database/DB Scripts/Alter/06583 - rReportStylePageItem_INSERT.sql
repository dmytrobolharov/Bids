IF NOT EXISTS (SELECT * FROM rReportStylePageItem where ReportFormName = 'v5_Style_LookBook_Summary_Body_LLT')
BEGIN
	INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
	VALUES ('422FAFA6-2610-4F71-94B3-4567A4416BBE', '40000000-0000-0000-0000-000000000085', '00000000-0000-0000-0000-000000000000', 'v5_Style_Header_LLT', 'Style Look Book Summary 6 Images', 'Style Look Book Summary Report', 'SQL', 'v5_Style_LookBook_Summary_Body_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 0, 0)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06583', GetDate())
GO
