IF NOT EXISTS (SELECT * FROM rReportStylePageItem where ReportFormName = 'v5_Style_MaterialLicensedArtworkComments_Body_LLT.rdl')
BEGIN
	INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
	VALUES ('4CB4EA80-C34C-4BBD-8F35-E1DBCAA76A11', '40000000-0000-0000-0000-000000000009', '00000000-0000-0000-0000-000000000000', 'v5_Style_Header_LLT', 'Material Licensed Artwork with Comments', 'Style Material Licensed Artwork with Comments', 'SQL', 'v5_Style_MaterialLicensedArtworkComments_Body_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 0, 0)
END

IF NOT EXISTS (SELECT * FROM rReportStylePageItem where ReportFormName = 'v5_Style_MaterialLicensedArtwork_Body_LLT')
BEGIN
	INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
	VALUES ('4CB4EA80-C34C-4BBD-8F35-E1DBCAA76A12', '40000000-0000-0000-0000-000000000009', '00000000-0000-0000-0000-000000000000', 'v5_Style_Header_LLT', 'Material Licensed Artwork 1 per page', 'Style Material Licensed Artwork 1 per page', 'SQL', 'v5_Style_MaterialLicensedArtwork_Body_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 1, 0)
END

IF NOT EXISTS (SELECT * FROM rReportStylePageItem where ReportFormName = 'v5_Style_MaterialLicensedArtwork_2_Body_LLT')
BEGIN
	INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
	VALUES ('4CB4EA80-C34C-4BBD-8F35-E1DBCAA76A13', '40000000-0000-0000-0000-000000000009', '00000000-0000-0000-0000-000000000000', 'v5_Style_Header_LLT', 'Material Licensed Artwork 2 per page', 'Style Material Licensed Artwork 2 per page', 'SQL', 'v5_Style_MaterialLicensedArtwork_2_Body_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 1, 0)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05927', GetDate())
GO
