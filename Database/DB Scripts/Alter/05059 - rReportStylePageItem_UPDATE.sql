UPDATE rReportStylePageItem
SET ReportTemplateName = 'v5_Style_Header_LLT', ReportFormName = 'v5_Style_Seasonal_Colors_Body_LLT'
WHERE ReportFormName = 'Style_Seasonal_Colors_Body_LLT'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05059', GetDate())
GO
