alter table pcolorpalette
add [Status] nvarchar(100)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05204', GetDate())
GO