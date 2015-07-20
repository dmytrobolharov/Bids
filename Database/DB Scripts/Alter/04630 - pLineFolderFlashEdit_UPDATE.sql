IF (SELECT COUNT(*) FROM pLineFolderFlashEdit WHERE LineFolderFlashEditFormName = 'Costing'	AND LineFolderFlashEditDescription = 'Style Costing')=0
	INSERT INTO pLineFolderFlashEdit
		(LineFolderFlashEditTableName
		,LineFolderFlashEditTablePKI
		,LineFolderFlashEditFormName
		,LineFolderFlashEditDescription
		,LineFolderFlashEditSort
		,LineFolderFlashEditURL
		,LineFolderFlashEditXML
		,LineFolderFlashEditSearchXML
		,LineFolderFlashEditBatchXML
		,LineFolderFlashEditBatchGridXML
		,LineFolderFlashEditActive)
	VALUES
		('pLineListFlashCosting'
		,'LineFolderItemID'
		,'Costing'
		,'Style Costing'
		,'0001'
		,'Line_List_FlashEdit_Search.aspx'
		,'FlashEdit_Style_Costing_Default.xml'
		,'FlashEdit_Style_Costing_Search.xml'
		,'FlashEdit_Style_Costing_Batch.xml'
		,'FlashEdit_Style_Costing_BatchGrid.xml'
		,1)
ELSE
	UPDATE
		pLineFolderFlashEdit
	SET
		LineFolderFlashEditTableName = 'pLineListFlashCosting'
		, LineFolderFlashEditTablePKI='LineFolderItemID'
	WHERE
		LineFolderFlashEditFormName = 'Costing'
		AND LineFolderFlashEditDescription = 'Style Costing'
		

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04630', GetDate())
GO
