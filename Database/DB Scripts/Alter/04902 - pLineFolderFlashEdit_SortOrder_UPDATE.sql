UPDATE pLineFolderFlashEdit SET LineFolderFlashEditSort='0001'
WHERE LineFolderFlashEditFormName='Image'

UPDATE pLineFolderFlashEdit SET LineFolderFlashEditSort='0002'
WHERE LineFolderFlashEditFormName='Color'

UPDATE pLineFolderFlashEdit SET LineFolderFlashEditSort='0003'
WHERE LineFolderFlashEditFormName='Material'

UPDATE pLineFolderFlashEdit SET LineFolderFlashEditSort='0004'
WHERE LineFolderFlashEditFormName='Flash Costing'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04902', GetDate())
GO
