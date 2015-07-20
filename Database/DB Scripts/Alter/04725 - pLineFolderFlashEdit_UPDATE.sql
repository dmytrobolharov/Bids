update pLineFolderFlashEdit set LineFolderFlashEditFormName='Flash Costing' where UPPER(LineFolderFlashEditFormName)='COSTING'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04725', GetDate())
GO
