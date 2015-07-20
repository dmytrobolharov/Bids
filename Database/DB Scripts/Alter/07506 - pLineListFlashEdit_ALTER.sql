IF NOT EXISTS(SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='pLineListFlashEdit' AND COLUMN_NAME='LineListFlashEditSaveSPX')
	ALTER TABLE pLineListFlashEdit ADD LineListFlashEditSaveSPX NVARCHAR(200) NULL
GO

UPDATE pLineListFlashEdit SET LineListFlashEditSaveSPX = 'spx_LineListFlashEdit_StyleHeader_SAVE'
WHERE LineListFlashEditName = 'Style Header'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07506', GetDate())
GO