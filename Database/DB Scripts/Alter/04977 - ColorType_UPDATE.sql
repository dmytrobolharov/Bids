UPDATE ColorType SET ColorTypeName = 'Color Library', ColorType = 'Color Library' WHERE ColorLibraryTypeID = '00000000-0000-0000-0000-000000000001'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04977', GetDate())
GO
