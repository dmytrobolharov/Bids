update rReportFolderItem
set ReportItemURL = replace(ReportItemURL, 'Report_Main.aspx?','../Report/Report_Main.aspx?')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04989', GetDate())
GO