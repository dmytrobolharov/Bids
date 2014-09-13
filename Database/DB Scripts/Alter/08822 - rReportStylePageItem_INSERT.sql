IF NOT EXISTS (SELECT * FROM rReportStylePageItem WHERE ReportFormName = 'v5_Style_Freelance_Body_PLT')
BEGIN
	INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
	VALUES (NEWID(), '40000000-0000-0000-0000-000000000999', '00000000-0000-0000-0000-000000000000', 'v5_Style_Header_PLT', 'Freelance Design Single Image Portrait', 'Style Freelance Design', 'SQL', 'v5_Style_Freelance_Body_PLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 0, 0)
END
GO

IF NOT EXISTS (SELECT * FROM rReportStylePageItem WHERE ReportFormName = 'v5_Style_FreelanceDesign_2_Body_LLT')
BEGIN
	INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
	VALUES (NEWID(), '40000000-0000-0000-0000-000000000999', '00000000-0000-0000-0000-000000000000', 'v5_Style_Header_LLT', 'Freelance Design Images & Grid  (Two Images per Page)', 'Style Freelance Design Image & Grid', 'SQL', 'v5_Style_FreelanceDesign_2_Body_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 0, 0)
END
GO

IF NOT EXISTS (SELECT * FROM rReportStylePageItem WHERE ReportFormName = 'v5_Style_FreelanceDesign_Body_LLT')
BEGIN
	INSERT INTO rReportStylePageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, ReportIsWorkflow)
	VALUES (NEWID(), '40000000-0000-0000-0000-000000000999', '00000000-0000-0000-0000-000000000000', 'v5_Style_Header_LLT', 'Design Detail Images (One Image per Page)', 'Style Freelance Design', 'SQL', 'v5_Style_FreelanceDesign_Body_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleId', 1, 'PDF', 0, 0)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08822', GetDate())
GO
