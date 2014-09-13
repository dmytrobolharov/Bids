insert into sSystemFolder(sSystemFolder,CDate,CUser) values ('Sample Request',GETDATE(), 'Administrator')
GO

	
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04003', GetDate())
GO
	
