Update sDeskTop set DeskSort = '20' where DeskTopID = 80
GO 
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04076', GetDate())

GO
