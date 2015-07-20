UPDATE rReportPageItem
SET ReportPageName = 'Line List Report w/ Main Material Color Chips'
WHERE ReportPageName = 'Line List Report w/ Main Material Images'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01259', GetDate())
GO