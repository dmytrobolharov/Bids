IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pLineListFlashEdit' AND COLUMN_NAME = 'LineListFlashEditPage')
BEGIN
	ALTER TABLE pLineListFlashEdit ADD LineListFlashEditPage NVARCHAR(200)
END
GO

IF EXISTS (SELECT * FROM pLineListFlashEdit WHERE LineListFlashEditPage IS NULL)
BEGIN
	UPDATE pLineListFlashEdit SET LineListFlashEditPage = 'Line_List_Folder_FlashEditPage.aspx'
	UPDATE pLineListFlashEdit SET LineListFlashEditPage = 'Line_List_Folder_FlashEditCostingPage.aspx' WHERE LineListFlashEditName = 'Style Costing Property'
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08382', GetDate())
GO
