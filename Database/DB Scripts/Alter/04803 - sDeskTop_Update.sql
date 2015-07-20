update sDeskTop
set DeskMain = replace(DeskMain, '32867a50-474d-4132-bad0-89fbd510ce5c','')
where DeskDescription = 'Home Page'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04803', GetDate())
GO