IF NOT EXISTS (SELECT * FROM pLineFolderFlashEdit WHERE LineFolderFlashEditFormName = 'Image')
BEGIN
insert into pLineFolderFlashEdit(LineFolderFlashEditId, LineFolderFlashEditTableName, LineFolderFlashEditTablePKI, LineFolderFlashEditFormName, LineFolderFlashEditDescription, 
  LineFolderFlashEditSort, LineFolderFlashEditURL, LineFolderFlashEditXML, LineFolderFlashEditSearchXML, LineFolderFlashEditBatchXML, 
  LineFolderFlashEditBatchGridXML, LineFolderFlashEditActive, CUser, CDate, MUser, MDate) values(NEWID(),'pStyleHeader','StyleID','Image','Image','0001','Line_List_FlashEdit_Image.aspx','FlashEdit_Style_Image_Default.xml','FlashEdit_Style_Image_Search.xml','FlashEdit_Style_Image_Batch.xml','FlashEdit_Style_Image_BatchGrid.xml',1,NULL,NULL,NULL,NULL)
  END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04475', GetDate())
GO
