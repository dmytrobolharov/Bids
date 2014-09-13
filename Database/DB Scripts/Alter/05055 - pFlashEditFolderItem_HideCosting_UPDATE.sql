UPDATE pFlashEditFolderItem SET Active = 0 WHERE FlashEditItemName='Costing'

DELETE sAccessGroupFlashEditFolder
FROM sAccessGroupFlashEditFolder a INNER JOIN pFlashEditFolderItem b
ON a.FlashEditFolderItemId = b.FlashEditFolderItemId
WHERE b.FlashEditItemName = 'Costing'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05055', GetDate())
GO
