IF NOT EXISTS (SELECT * FROM rReportTechPackPageItem WHERE UPPER(ReportPageName) = 'DIMENSIONAL MATERIAL LIST XML')
BEGIN

	 insert into rReportTechPackPageItem (ReportTechPackPageID, ReportTechPackFolderID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, 
	ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportPageBySet, ReportPageSort, ReportMapID, ReportSourcing)
	values (NEWID(), 'F1000000-0000-0000-0000-000000000014', '00000000-0000-0000-0000-000000000000', 'Style_Material_Header_LLT', 'Dimensional Material List XML', 'Style Dimensional Material List', 'ASPX', 
	'Style_Component.aspx', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleID', 1, 'PDF', 1, '005', '40000000-0000-0000-0000-000000000080', 0
	)
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04667', GetDate())
GO
