UPDATE rDashFolderItem
SET DashFolderItemName = REPLACE(DashFolderItemName, ' Report', '')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09166', GetDate())
GO
