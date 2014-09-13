IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='pLineFolderItem' AND COLUMN_NAME='StyleBOMWorkflowItemID')
BEGIN
	ALTER TABLE pLineFolderItem ADD StyleBOMWorkflowItemID UNIQUEIDENTIFIER
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05473', GetDate())
GO
