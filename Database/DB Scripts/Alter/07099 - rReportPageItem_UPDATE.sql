UPDATE rReportPageItem SET ReportPageDescription = 'Line List Report Eight Per Page' WHERE ReportFormName = 'v5_LineFolder_4x2_Body_LLT'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07099', GetDate())
GO

