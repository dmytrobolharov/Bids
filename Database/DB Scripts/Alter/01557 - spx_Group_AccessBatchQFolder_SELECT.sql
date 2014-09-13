IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessBatchQFolder_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Group_AccessBatchQFolder_SELECT]
GO
  
CREATE PROCEDURE [dbo].[spx_Group_AccessBatchQFolder_SELECT] (   
@GroupID uniqueidentifier  
)  
AS   
  
  
SELECT a.BatchQueueTypeID, a.BatchQueueTypeName,   
 b.AccessBatchQueueId,  b.AccessRoleId, b.AccessView, b.AccessCreate,   
 b.AccessModify, b.AccessDelete, b.AccessPrint, b.AccessRemove,   
 b.GroupID, b.CUser, b.CDate,  b.MUser,   
 b.MDate
FROM  pBatchQueueType a WITH (NOLOCK) INNER JOIN   dbo.sAccessGroupBatchQueueFolder  b WITH (NOLOCK) ON a.BatchQueueTypeID = b.BatchQueueTypeID  
WHERE b.GroupID = @GroupID  
ORDER BY a.BatchQueueTypeName   


  
  
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01557'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01557', GetDate())
END	

GO

  