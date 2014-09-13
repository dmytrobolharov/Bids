UPDATE rReportTechPackFolder 
SET ReportTechPackFormName = 'v5_Style_Coversheet_LLT' 
WHERE ReportTechPackFormName = 'Style_Coversheet_LLT'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04954', GetDate())
GO
