UPDATE rReportStylePageItem SET ReportIsWorkflow = 1 WHERE ReportFormName IN ('Style_CostSheetItemsCompare_Body_LLT', 'Style_CostSheetItem_Body_LLT')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10403', GetUTCDate())
GO
