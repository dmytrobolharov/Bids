alter table [sSystemPage]
alter column MappingPage nvarchar(100)
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03973', GetDate())
GO