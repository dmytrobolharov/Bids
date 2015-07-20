IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='pLineFolderItem' AND COLUMN_NAME='StyleBOMWorkflowItemID')
BEGIN
	ALTER TABLE pLineFolderItem DROP COLUMN StyleBOMWorkflowItemID
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05505', GetDate())
GO
