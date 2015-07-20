INSERT INTO pLineFolderFlashEdit
(LineFolderFlashEditTableName, LineFolderFlashEditTablePKI, LineFolderFlashEditFormName,
LineFolderFlashEditDescription, LineFolderFlashEditSort, LineFolderFlashEditURL, LineFolderFlashEditXML,
LineFolderFlashEditSearchXML, LineFolderFlashEditBatchXML, LineFolderFlashEditBatchGridXML, LineFolderFlashEditActive)
VALUES ('pStyleBOM', 'StyleBOMDimensionID', 'Material', 
'Style Dimensional BOM', '0003', 'Line_List_FlashEdit_Material.aspx', 'FlashEdit_Material_Style_Default.xml',
'FlashEdit_Material_Style_Search.xml', 'FlashEdit_Material_RawMaterial_Default.xml', 'FlashEdit_Material_RawMaterial_Search.xml', 1)


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04697', GetDate())
GO
