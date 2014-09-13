UPDATE rReportStylePageItem
SET ReportTemplateName = 'Style_Header_PLT'
	,ReportFormName = 'Style_Model_1x1_Body_PLT'
WHERE ReportFormName = 'Style_Model_1x1_Body_LLT'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01314', GetDate())
GO