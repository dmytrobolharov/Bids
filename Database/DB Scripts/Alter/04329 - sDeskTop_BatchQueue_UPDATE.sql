UPDATE sDeskTop SET DeskActive = 1 WHERE DeskTopID='26' AND DeskName='Batch Queue'

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04329', GetDate())
GO
