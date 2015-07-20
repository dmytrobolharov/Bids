UPDATE sDeskTop SET DeskLabel1='Line Planning' WHERE DeskTopID = 10
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04123', GetDate())
GO