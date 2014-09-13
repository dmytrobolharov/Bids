update sDeskTop
set DeskURL= 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=10&TID=##TEAMID##'';'
where DeskTopID = 10

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01197', GetDate())