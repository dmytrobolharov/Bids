UPDATE rReportFolderItem SET
	ReportFormName = 'v5_LineFolder_Global_4x2_Category_LLT'
	, ReportItemURL = '../Report/Report_Main.aspx?R=/plmOnReports/v5_LineFolder_Global_4x2_Category_LLT'
WHERE ReportItemName = 'Global Line Report (4x2)'

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05131', GetDate())
GO
