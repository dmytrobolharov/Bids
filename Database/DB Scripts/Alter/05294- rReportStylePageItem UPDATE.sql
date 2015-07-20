update rReportStylePageItem set ReportPageName='Dimensional Material List with Comments' where ReportPageName='Dimensional Material List XML with Comments'
update rReportStylePageItem set ReportPageName='Dimensional Material List' where ReportPageName='Dimensional Material List XML'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05294', GetDate())
