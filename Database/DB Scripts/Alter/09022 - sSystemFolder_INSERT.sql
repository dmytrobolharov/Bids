IF NOT EXISTS (SELECT sSystemFolderID FROM sSystemFolder WHERE sSystemFolder='Line List')
	INSERT INTO sSystemFolder (sSystemFolderID, sSystemFolder, CDate, CUser)
	VALUES (NEWID(), 'Line List', GETDATE(), 'Administrator')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09022', GetDate())
GO
