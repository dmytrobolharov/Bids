CREATE PROCEDURE [dbo].[spx_User_AccessFlashEditFolder_SELECT]
(@teamId uniqueidentifier)
AS 

SELECT     dbo.pFlashEditFolderItem.FlashEditItemName, dbo.pFlashEditFolderItem.FlashEditItemDescription, dbo.sAccessFlashEditFolder.AccessFlashEditId, 
                      dbo.sAccessFlashEditFolder.AccessRoleId, dbo.sAccessFlashEditFolder.AccessView, dbo.sAccessFlashEditFolder.AccessCreate, 
                      dbo.sAccessFlashEditFolder.AccessModify, dbo.sAccessFlashEditFolder.AccessDelete, dbo.sAccessFlashEditFolder.AccessPrint, 
                      dbo.sAccessFlashEditFolder.TeamId, dbo.sAccessFlashEditFolder.CUser, dbo.sAccessFlashEditFolder.CDate, 
                      dbo.sAccessFlashEditFolder.MUser, dbo.sAccessFlashEditFolder.MDate, dbo.pFlashEditFolderItem.FlashEditItemSort
FROM         dbo.sAccessFlashEditFolder WITH (NOLOCK) INNER JOIN
                      dbo.pFlashEditFolderItem WITH (NOLOCK) ON dbo.sAccessFlashEditFolder.FlashEditFolderItemId = dbo.pFlashEditFolderItem.FlashEditFolderItemID
WHERE     (sAccessFlashEditFolder.TeamId = @teamId)
ORDER BY pFlashEditFolderItem.FlashEditItemSort , pFlashEditFolderItem.FlashEditItemName
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '213', GetDate())
GO	