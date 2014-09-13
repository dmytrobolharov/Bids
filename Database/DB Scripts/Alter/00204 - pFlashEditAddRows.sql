IF  NOT EXISTS (SELECT * FROM dbo.cDesktopFolder WHERE DeskFolderName = 'Flash Edit' )

BEGIN	
INSERT INTO dbo.cDesktopFolder VALUES(15,'Flash Edit','Control_User_FlashEdit.aspx',0,'Control_Group_FlashEdit.aspx')
END
GO

IF  NOT EXISTS (SELECT * FROM dbo.cDeskSide WHERE DeskSideName = 'Flash Edit' )

BEGIN	
INSERT INTO dbo.cDeskSide (DeskFolderId, DeskSideName, DeskSideDescription, DeskSideWindow, DeskSideURL, DeskSideIcon, DeskSideSort, DeskSideActive ) VALUES (15,'Flash Edit',null,'FlashEdit','../FlashEdit/FlashEdit_Folder.aspx','../System/Icons/icon_folder.gif','009',1)
END
GO


Insert into pFlashEditFolder (FlashEditFolderId, FlashEditFolderName,FlashEditFolderDesc, FlashEditFolderSort, FlashEditDefaultXML, FlashEditSearchXML) values ( '985b2f44-ef92-4d27-a606-91b90c579495', 'Style', 'Style_Quote_Pre costing','00001', 'FlashEditFolder_Default.xml', 'FlashEditFolder_Search.xml')
/* Insert into pFlashEditFolder (FlashEditFolderId,FlashEditFolderName,FlashEditFolderDesc,FlashEditFolderSort, FlashEditDefaultXML, FlashEditSearchXML) values ( '2414640b-d8aa-4f52-b4bf-d9f4446d50da','Material', 'Change_Color_PackageLabel ','00002', 'FlashEditFolder_Default.xml', 'FlashEditFolder_Search.xml') */


Insert into pFlashEditFolderItem (FlashEditFolderId, FlashEditFormName, FlashEditItemName, FlashEditItemDescription,FlashEditItemSort,FlashEditItemURL,
FlashEditItemXML,FlashEditItemSearchXML,FlashEditItemBatchXML) values ( '985b2f44-ef92-4d27-a606-91b90c579495', 'Style', 'Costing', 'Pre costing Edit','00001','FlashEdit_Search.aspx',
'FlashEdit_Style_Cost_Default.xml','FlashEdit_Style_Cost_Search.xml','FlashEdit_Style_Cost_Batch.xml')

/*
Insert into pFlashEditFolderItem (FlashEditFolderId, FlashEditFormName, FlashEditItemName, FlashEditItemDescription,FlashEditItemSort,FlashEditItemURL,
FlashEditItemXML,FlashEditItemSearchXML,FlashEditItemBatchXML) values ( '985b2f44-ef92-4d27-a606-91b90c579495', 'Style', 'Quote', 'Update Vendor Quote','00002','FlashEdit_Search.aspx',
'FlashEdit_Style_Quote_Default.xml','FlashEdit_Style_Quote_Search.xml','FlashEdit_Style_Quote_Batch.xml')

Insert into pFlashEditFolderItem (FlashEditFolderId, FlashEditFormName, FlashEditItemName, FlashEditItemDescription,FlashEditItemSort,FlashEditItemURL,
FlashEditItemXML,FlashEditItemSearchXML,FlashEditItemBatchXML) values ( '2414640b-d8aa-4f52-b4bf-d9f4446d50da', 'Material', 'Color', 'Core color Edit','00003','FlashEdit_Search.aspx',
'FlashEdit_Material_Color_Default.xml','FlashEdit_Material_Color_Search.xml','FlashEdit_Material_Color_Batch.xml')

Insert into pFlashEditFolderItem (FlashEditFolderId, FlashEditFormName, FlashEditItemName, FlashEditItemDescription,FlashEditItemSort,FlashEditItemURL,
FlashEditItemXML,FlashEditItemSearchXML,FlashEditItemBatchXML) values ( '2414640b-d8aa-4f52-b4bf-d9f4446d50da5', 'Material', 'PackingLabel', 'Change Pack labelling','00004','FlashEdit_Search.aspx',
'FlashEdit_Material_PackLabel_Default.xml','FlashEdit_Material_PackLabel_Search.xml','FlashEdit_Material_PackLabel_Batch.xml')

*/

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '204', GetDate())
GO	