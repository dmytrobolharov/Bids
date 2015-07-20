
update pFlashEditFolderItem set Active=0 where Upper(FlashEditFormName)='MATERIAL'
update pFlashEditFolder set Active=0 where Upper(FlashEditFolderName)='MATERIAL'


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05379', GetDate())
GO