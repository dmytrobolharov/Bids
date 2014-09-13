UPDATE rReportTechPackPageItem 
SET ReportFormName = 'v5_Style_ConstructionDetails_Body_Big_Img_LLT' 
WHERE ReportFormName = 'v5_Style_ConstructionDetails_Body_LLT'
GO

UPDATE rReportTechPackPageItem 
SET ReportFormName = 'v5_Style_ConstructionDetails_2_Body_Big_Img_LLT' 
WHERE ReportFormName = 'v5_Style_ConstructionDetails_2_Body_LLT'
GO

UPDATE rReportTechPackPageItem 
SET ReportFormName = 'v5_Style_ConstructionDetails_3_Body_Big_Img_LLT' 
WHERE ReportFormName = 'v5_Style_ConstructionDetails_3_Body_LLT'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04933', GetDate())
GO
