UPDATE rReportStylePageItem
SET ReportTemplateName = 'Style_Material_Header_LLT'
WHERE ReportFormName = 'Style_Component.aspx'
	AND ReportTemplateName <> 'Style_Material_Header_LLT'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01198', GetDate())
GO