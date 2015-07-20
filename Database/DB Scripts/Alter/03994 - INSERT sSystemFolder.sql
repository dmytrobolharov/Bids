insert into sSystemFolder(sSystemFolder,CDate,CUser) values ('TechPack',GETDATE(), 'Administrator')
GO

	
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03994', GetDate())
GO
	
