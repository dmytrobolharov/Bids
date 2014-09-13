UPDATE rReportStylePageItem SET ReportPageDescription = 'Style Process Details' WHERE ReportPageDescription = 'Style Construction Details'

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05718', GetDate())
GO
