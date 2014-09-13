IF EXISTS(SELECT * FROM pLineFolderFlashEdit WHERE LineFolderFlashEditTableName = 'pStyleCostingHeader')
BEGIN
	UPDATE pLineFolderFlashEdit SET LineFolderFlashEditTablePKI = 'StyleCostingHeaderID' WHERE LineFolderFlashEditTableName = 'pStyleCostingHeader'
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03689', GetDate())
GO
