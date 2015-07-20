UPDATE rReportStylePageItem
SET ReportFormName = 'Style_Home_Style_SizeConstruction_Body_LLT'
	,ReportTemplateName = 'Style_Header_LLT'
WHERE ReportFormName = 'DN_Home_Style_SizeConstruction_Body_LLT'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01460', GetDate())
GO