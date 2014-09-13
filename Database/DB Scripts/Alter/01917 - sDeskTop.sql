Update sDeskTop  set DeskFolderid = (select DeskFolderid from cDesktopFolder where DeskfolderName = 'Color Folder') where DeskName='Color'
Update sDeskTop  set DeskFolderid = (select DeskFolderid from cDesktopFolder where DeskfolderName = 'Image Folder') where DeskName='Image'
Update sDeskTop  set DeskFolderid = (select DeskFolderid from cDesktopFolder where DeskfolderName = 'Material Folder') where DeskName='Material'
Update sDeskTop  set DeskFolderid = (select DeskFolderid from cDesktopFolder where DeskfolderName = 'Body') where DeskName='Body'
Update sDeskTop  set DeskFolderid = (select DeskFolderid from cDesktopFolder where DeskfolderName = 'Style Folder') where DeskName='Style'
Update sDeskTop  set DeskFolderid = (select DeskFolderid from cDesktopFolder where DeskfolderName = 'Line List Folder') where DeskName='Line List'
Update sDeskTop  set DeskFolderid = (select DeskFolderid from cDesktopFolder where DeskfolderName ='Line Plan') where DeskName='Line Planning'
Update sDeskTop  set DeskFolderid = (select DeskFolderid from cDesktopFolder where DeskfolderName = 'BI Folder') where DeskName='BI'
Update sDeskTop  set DeskFolderid = (select DeskFolderid from cDesktopFolder where DeskfolderName = 'Compliance Folder') where DeskName='Compliance'
Update sDeskTop  set DeskFolderid = (select DeskFolderid from cDesktopFolder where DeskfolderName = 'Flash Edit') where DeskName='Flash Edit'
Update sDeskTop  set DeskFolderid = (select DeskFolderid from cDesktopFolder where DeskfolderName = 'Batch Queue') where DeskName='Batch Queue'
Update sDeskTop  set DeskFolderid = (select DeskFolderid from cDesktopFolder where DeskfolderName = 'Control Panel') where DeskName='Control'
Update sDeskTop  set DeskFolderid = 100 where DeskName='Log Off'
Update sDeskTop  set DeskFolderid = 101 where DeskName='Home'
Update sDeskTop  set DeskFolderid = 102 where DeskName='Administrator'

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01917'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01917', GetDate())
END	
GO