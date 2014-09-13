
BEGIN TRANSACTION
GO

UPDATE sDeskTop SET DeskFolderID='19' WHERE DeskName='Home' and DeskTopID=1
GO

UPDATE sDeskTop SET DeskFolderID='7' WHERE DeskName='Color' and DeskTopID=3
GO

UPDATE sDeskTop SET DeskFolderID='6' WHERE DeskName='Image' and DeskTopID=4
GO

UPDATE sDeskTop SET DeskFolderID='8' WHERE DeskName='Material' and DeskTopID=5
GO

UPDATE sDeskTop SET DeskFolderID='14' WHERE DeskName='Body' and DeskTopID=7
GO

UPDATE sDeskTop SET DeskFolderID='2' WHERE DeskName='Style' and DeskTopID=8
GO

UPDATE sDeskTop SET DeskFolderID='3' WHERE DeskName='Line List' and DeskTopID=9
GO

UPDATE sDeskTop SET DeskFolderID='13' WHERE DeskName='Line Planning' and DeskTopID=10
GO

UPDATE sDeskTop SET DeskFolderID='17' WHERE DeskName='BI' and DeskTopID=11
GO

UPDATE sDeskTop SET DeskFolderID='9' WHERE DeskName='Compliance' and DeskTopID=15
GO

UPDATE sDeskTop SET DeskFolderID='15' WHERE DeskName='Flash Edit' and DeskTopID=25
GO

UPDATE sDeskTop SET DeskFolderID='16' WHERE DeskName='Batch Queue' and DeskTopID=26
GO

UPDATE sDeskTop SET DeskFolderID='10' WHERE DeskName='Control' and DeskTopID=30
GO

UPDATE sDeskTop SET DeskFolderID='40' WHERE DeskName='Administrator' and DeskTopID=40
GO

UPDATE sDeskTop SET DeskFolderID='20' WHERE DeskName='Log Off' and DeskTopID=100
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01620'))
BEGIN

	INSERT INTO sVersion (AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '01620', GetDate())

END
GO

COMMIT
GO