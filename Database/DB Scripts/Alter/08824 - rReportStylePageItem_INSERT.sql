IF NOT EXISTS (SELECT * FROM rReportStylePageItem where ReportFormName = 'v5_Style_LookBook_Summary_Body_PLT')
BEGIN
	INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
	VALUES (NEWID(), '40000000-0000-0000-0000-000000000085', '00000000-0000-0000-0000-000000000000', 'v5_Style_Header_PLT', 'Style Look Book Summary 4 Images (Portrait)', 'Style Look Book Summary Report', 'SQL', 'v5_Style_LookBook_Summary_Body_PLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 0, 0)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08824', GetDate())
GO
