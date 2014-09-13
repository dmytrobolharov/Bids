update rReportFolderItem set ReportFolderItemActive=1 where ReportFolderItemActive is null

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05461', GetDate())
GO
