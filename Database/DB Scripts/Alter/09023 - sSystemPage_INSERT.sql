IF NOT EXISTS (SELECT sSystemFolderID FROM sSystemPage WHERE MappingPage='Line_List_Document_Edit.aspx')
BEGIN
	DECLARE @SystemFolderID UNIQUEIDENTIFIER = (SELECT sSystemFolderID FROM sSystemFolder WHERE sSystemFolder='Line List')
	INSERT INTO sSystemPage (sSystemPageID, MappingPage, CDate, CUser, sSystemFolderID)
	VALUES (NEWID(), 'Line_List_Document_Edit.aspx', GETDATE(), 'Administrator', @SystemFolderID)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09023', GetDate())
GO
