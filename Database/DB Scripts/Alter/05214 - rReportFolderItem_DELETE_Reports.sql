DELETE FROM rReportFolderItem
WHERE ReportItemName = 'Material'
	OR ReportItemName = 'Season/Year SKU Count (w/ Images)'
	OR ReportItemName = 'Season/Year SKU Count'	
	OR ReportItemName = 'Score Summary'
	OR ReportItemName = 'Score Summary Simple Bar'
	OR ReportItemName = 'Score Summary Stacked Bar'
	OR ReportItemName = 'Change Activity'
	OR ReportItemName = 'Change Activity Chart 1'
	OR ReportItemName = 'Change Activity Chart 2'
	OR ReportItemName = 'PD Shared Comment Summary'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05214', GetDate())
GO
