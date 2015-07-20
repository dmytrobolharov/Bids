UPDATE rDashFolderItem
SET DashFolderItemName = REPLACE(DashFolderItemName, ' Report', '')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09170', GetDate())
GO
