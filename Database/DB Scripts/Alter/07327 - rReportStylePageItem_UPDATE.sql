IF EXISTS(SELECT * FROM rReportStylePageItem where ReportMapID = '40000000-0000-0000-0000-000000000021' AND ReportPageName = 'Seasonal')
BEGIN
	UPDATE rReportStylePageItem SET ReportPageName = 'Attribute' WHERE ReportMapID = '40000000-0000-0000-0000-000000000021'
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07327', GetDate())
GO
