CREATE PROCEDURE [dbo].[spx_Group_AccessFlashEditFolder_SELECT] (
@GroupID uniqueidentifier
)
AS 

SELECT     b.FlashEditItemName, b.FlashEditItemDescription, a.AccessFlashEditId, 
                      a.AccessRoleId, a.AccessView, a.AccessCreate, 
                      a.AccessModify, a.AccessDelete, a.AccessPrint, 
                      a.GroupID , a.CUser, a.CDate, 
                      a.MUser, a.MDate, b.FlashEditItemSort
FROM	dbo.sAccessGroupFlashEditFolder a WITH (NOLOCK) INNER JOIN  dbo.pFlashEditFolderItem b WITH (NOLOCK) ON a.FlashEditFolderItemId = b.FlashEditFolderItemId
WHERE	a.GroupID = @GroupID 
ORDER BY b.FlashEditItemSort , b.FlashEditItemName

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '206', GetDate())
GO