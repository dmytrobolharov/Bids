IF NOT EXISTS (SELECT * FROM rReportStylePageItem where ReportFormName = 'v5_Style_mBOM_byDim_Body_LLT.rdl')
BEGIN
	INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
	VALUES ('422FFFF6-2610-4F71-94B3-456714416BBE', '40000000-0000-0000-0000-000000000080', '00000000-0000-0000-0000-000000000000', 'v5_Style_Header_LLT', 'Multi Dimensional BOM (by Dimensions)', 'Multi Dimensional BOM (by Dimensions)', 'SQL', 'v5_Style_mBOM_byDim_Body_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 0, 0)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06096', GetDate())
GO
