UPDATE sDeskTop SET DeskUrl = 'parent.dbody.location = ''../Control/Control_Folder.aspx?'';' WHERE DeskName = 'Control'
UPDATE sDeskTop SET DeskUrl = 'parent.dbody.location = ''../Control/Control_AdminFolder.aspx?'';' WHERE DeskName = 'Admin'

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03280'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03280', GetDate())

END
GO