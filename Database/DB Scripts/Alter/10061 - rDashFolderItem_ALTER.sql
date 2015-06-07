IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'rDashFolderItem' AND COLUMN_NAME = 'DashFolderItemUrl')
ALTER TABLE rDashFolderItem DROP COLUMN DashFolderItemUrl
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'rDashFolderItem' AND COLUMN_NAME = 'DashFolderItemServerUrl')
ALTER TABLE rDashFolderItem DROP COLUMN DashFolderItemServerUrl
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'rDashFolderItem' AND COLUMN_NAME = 'DashFolderItemServerFolderName')
ALTER TABLE rDashFolderItem DROP COLUMN DashFolderItemServerFolderName
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10061', GetUTCDate())
GO
