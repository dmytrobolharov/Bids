IF EXISTS (SELECT * FROM sDeskTop WHERE DeskName = 'Line List' AND DeskFolderID IS NULL)
BEGIN
	UPDATE sDeskTop SET DeskFolderID = 3 WHERE DeskName = 'Line List'
END



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02280'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02280', GetDate())
END
GO