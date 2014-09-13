Update sDeskTop set DeskActive = 1 where DeskName = 'Flash Edit'
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06297', GetDate())
GO