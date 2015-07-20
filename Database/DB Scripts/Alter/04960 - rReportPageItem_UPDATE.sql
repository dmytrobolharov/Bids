update
	rReportPageItem
set
	ReportFormName = 'v5_' + ReportFormName
	, ReportTemplateName = 'v5_' + ReportTemplateName
where
	CHARINDEX ('v5',ReportFormName) = 0 AND CHARINDEX ('v5',ReportTemplateName) = 0 AND
	ReportMapID IN (
		'A3000000-0000-0000-0000-000000000000'
		, 'A4000000-0000-0000-0000-000000000000'
		, 'A6000000-0000-0000-0000-000000000000'
		, 'A7000000-0000-0000-0000-000000000000'
		, 'A8000000-0000-0000-0000-000000000000'
		, 'A1111000-0000-0000-0000-000000000000'
		, 'A1110000-0000-0000-0000-000000000000'
	)
	AND ReportPageActive = 1
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04960', GetDate())
GO
