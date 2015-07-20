UPDATE rReportStylePageItem
SET ReportPageActive = 0
	,ReportSrmOn = 0
WHERE ReportFormName = 'Style_MaterialImageGrid_Body_LLT'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01076', GetDate())
GO