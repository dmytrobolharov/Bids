update sDeskTop set DeskName='Resource', DeskDescription='Resource Folder', DeskLabel1='Resource' where DeskTopID=15

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04981', GetDate())

GO
