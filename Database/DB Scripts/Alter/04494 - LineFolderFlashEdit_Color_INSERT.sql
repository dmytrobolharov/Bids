INSERT INTO pLineFolderFlashEdit (LineFolderFlashEditId, LineFolderFlashEditTableName, LineFolderFlashEditTablePKI, LineFolderFlashEditFormName, 
			LineFolderFlashEditDescription, LineFolderFlashEditSort, LineFolderFlashEditURL, LineFolderFlashEditXML, LineFolderFlashEditSearchXML, 
			LineFolderFlashEditBatchXML, LineFolderFlashEditBatchGridXML, LineFolderFlashEditActive, CUser, CDate, MUser, MDate) 
VALUES (NEWID(), 'pStyleColorway', 'StyleID', 'Color', 'Style Seasonal Colorway', 
		'0002', 'Line_List_FlashEdit_Color.aspx', 'FlashEdit_Color_Style_Default.xml', 'FlashEdit_Color_Style_Search.xml', 
		'FlashEdit_Color_Palette_Default.xml', 'FlashEdit_Color_Palette_Search.xml', 1, NULL, NULL, NULL, NULL)

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04494', GetDate())
GO
