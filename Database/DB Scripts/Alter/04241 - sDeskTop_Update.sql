UPDATE sDeskTop SET DeskUrl = 'parent.dbody.location = ''../Control/Control_Folder.aspx?TID=##TEAMID##'';' WHERE DeskName = 'Control'
UPDATE sDeskTop SET DeskUrl = 'parent.dbody.location = ''../Control/Control_AdminFolder.aspx?TID=##TEAMID##'';' WHERE DeskName = 'Admin'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04241', GetDate())
GO
