IF NOT EXISTS (SELECT * FROM rDashFolder WHERE DashFolderName = 'Dev Calendar')
	INSERT INTO rDashFolder (DashFolderID, DashFolderName, DashFolderSort, DashFolderActive)
	VALUES (NEWID(), 'Dev Calendar', '000', 0)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09077', GetDate())
GO
	