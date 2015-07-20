IF NOT EXISTS (SELECT * FROM rReportStylePageItem where ReportPageID = '4CB4EA80-C34C-4BBD-8F35-E1DBCAA76E60')
BEGIN
	INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
	VALUES ('4CB4EA80-C34C-4BBD-8F35-E1DBCAA76E60', '40000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000000', 'v5_Style_Header_PLT', 'Design Detail Single Image Portrait', 'Style Design Detail', 'SQL', 'v5_Style_DesignDetail_Body_PLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 0, 0)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08410', GetDate())
GO
