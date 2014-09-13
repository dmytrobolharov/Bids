
/****** Object:  StoredProcedure [dbo].[spx_User_AccessQuickBRFolder_SELECT]    Script Date: 06/07/2010 17:12:38 ******/

CREATE PROCEDURE [dbo].[spx_User_AccessQuickBRFolder_SELECT]
(@teamId uniqueidentifier)
AS 

SELECT     dbo.pQuickBatchReplaceType.QuickBRTypeName, dbo.pQuickBatchReplaceType.QuickBRTypeDescription, dbo.sAccessQuickBatchReplaceFolder.AccessQuickBRId, 
                      dbo.sAccessQuickBatchReplaceFolder.AccessRoleId, dbo.sAccessQuickBatchReplaceFolder.AccessView, dbo.sAccessQuickBatchReplaceFolder.AccessCreate, 
                      dbo.sAccessQuickBatchReplaceFolder.AccessModify, dbo.sAccessQuickBatchReplaceFolder.AccessDelete, dbo.sAccessQuickBatchReplaceFolder.AccessPrint, 
                      dbo.sAccessQuickBatchReplaceFolder.TeamId, dbo.sAccessQuickBatchReplaceFolder.CUser, dbo.sAccessQuickBatchReplaceFolder.CDate, 
                      dbo.sAccessQuickBatchReplaceFolder.MUser, dbo.sAccessQuickBatchReplaceFolder.MDate, dbo.pQuickBatchReplaceType.QuickBROrder
FROM         dbo.sAccessQuickBatchReplaceFolder WITH (NOLOCK) INNER JOIN
                      dbo.pQuickBatchReplaceType WITH (NOLOCK) ON dbo.sAccessQuickBatchReplaceFolder.QuickBRTypeId = dbo.pQuickBatchReplaceType.QuickBRTypeID
WHERE     (sAccessQuickBatchReplaceFolder.TeamId = @teamId)
ORDER BY pQuickBatchReplaceType.QuickBROrder , pQuickBatchReplaceType.QuickBRTypeName
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '131', GetDate())
GO