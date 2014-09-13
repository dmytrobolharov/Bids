UPDATE rReportTechPackPageItem
SET ReportFormName = 'Style_SeasonalMaterialColorway_Body_LLT'
WHERE ReportFormName = 'Style_MaterialColorway_Body_LLT'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01266', GetDate())
GO