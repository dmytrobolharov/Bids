IF NOT EXISTS (SELECT * FROM rReportPageItem WHERE ReportPageID = '99E52AF7-25F4-4666-A062-882D8C95BBF2')
BEGIN
	INSERT INTO rReportPageItem (
		ReportPageID
		, ReportMapID
		, ReportPageTypeID
		, ReportTemplateName
		, ReportPageName
		, ReportPageDescription
		, ReportServerType
		, ReportFormName
		, ReportPageURL
		, ReportPKIField
		, ReportPageActive
		, ReportPageFormat
	)
	VALUES (
		N'99E52AF7-25F4-4666-A062-882D8C95BBF2'
		, N'A1111000-0000-0000-0000-000000000000'
		, N'00000000-0000-0000-0000-000000000000'
		, N'POM_Library_Report'
		, N'POM Library Report'
		, N'POM Library Report'
		, N'SQL'
		, N'POM_Library_Report'
		, N'/MeasurementPomLibraryReport.aspx?RPID=##RPID##'
		, N'PomTemplateId'
		, 1
		, N'PDF'
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04443', GetDate())
GO
