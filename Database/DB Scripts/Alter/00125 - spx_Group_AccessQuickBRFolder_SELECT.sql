
/****** Object:  StoredProcedure [dbo].[spx_Group_AccessQuickBRFolder_SELECT]    Script Date: 06/07/2010 17:01:01 ******/

CREATE PROCEDURE [dbo].[spx_Group_AccessQuickBRFolder_SELECT] (
@GroupID uniqueidentifier
)
AS 

SELECT     b.QuickBRTypeName, b.QuickBRTypeDescription, a.AccessQuickBRId, 
                      a.AccessRoleId, a.AccessView, a.AccessCreate, 
                      a.AccessModify, a.AccessDelete, a.AccessPrint, 
                      a.GroupID , a.CUser, a.CDate, 
                      a.MUser, a.MDate, b.QuickBROrder
FROM	dbo.sAccessGroupQuickBatchReplaceFolder a WITH (NOLOCK) INNER JOIN  dbo.pQuickBatchReplaceType b WITH (NOLOCK) ON a.QuickBRTypeId = b.QuickBRTypeId
WHERE	a.GroupID = @GroupID 
ORDER BY b.QuickBROrder , b.QuickBRTypeName

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '125', GetDate())
GO