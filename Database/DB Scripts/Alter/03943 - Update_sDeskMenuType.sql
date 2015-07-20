UPDATE sDeskMenuType SET DeskMenuTypeName='Partner Folder' where UPPER(DeskMenuTypeName)='VENDOR FOLDER'

GO
UPDATE sDeskMenu SET DeskName='Partner View' where UPPER(DeskName)='VENDOR VIEW'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03943', GetDate())
GO

