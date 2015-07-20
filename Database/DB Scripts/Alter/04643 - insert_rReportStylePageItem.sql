IF NOT EXISTS (SELECT * FROM rReportStylePageItem WHERE UPPER(ReportPageName) = 'DIMENSIONAL MATERIAL LIST XML WITH COMMENTS')
BEGIN

	Insert into rReportStylePageItem (
	ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription,	
	ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat,	
	ReportSrmOn, ReportIsWorkflow)
	values ( NEWID(),'40000000-0000-0000-0000-000000000080', '00000000-0000-0000-0000-000000000000', 'Style_Material_Header_LLT', 'Dimensional Material List XML with Comments',
	'Style Dimensional Material List Comments', 'ASPX',	'Style_Component.aspx',	'/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleID', '1',	'PDF',	'1', NULL)
END

IF NOT EXISTS (SELECT * FROM rReportStylePageItem WHERE UPPER(ReportPageName) = 'DIMENSIONAL MATERIAL LIST XML')
BEGIN

	Insert into rReportStylePageItem (
	ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription,	
	ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat,	
	ReportSrmOn, ReportIsWorkflow)
	values ( NEWID(),'40000000-0000-0000-0000-000000000080', '00000000-0000-0000-0000-000000000000', 'Style_Material_Header_LLT', 'Dimensional Material List XML',
	'Style Dimensional Material List', 'ASPX',	'Style_Component.aspx',	'/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleID', '1',	'PDF',	'1', NULL)

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04643', GetDate())
GO
