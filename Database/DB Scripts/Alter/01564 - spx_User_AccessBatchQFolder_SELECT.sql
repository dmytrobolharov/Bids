IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_AccessBatchQFolder_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_User_AccessBatchQFolder_SELECT]
GO

 
CREATE PROCEDURE [dbo].[spx_User_AccessBatchQFolder_SELECT](
	@teamId UNIQUEIDENTIFIER
)  
AS   
  
  
SELECT pBatchQueueType.BatchQueueTypeID, pBatchQueueType.BatchQueueTypeName,   
 sAccessBatchQFolder.AccessBatchQId,   
 sAccessBatchQFolder.AccessRoleId, sAccessBatchQFolder.AccessView, sAccessBatchQFolder.AccessCreate,   
 sAccessBatchQFolder.AccessModify, sAccessBatchQFolder.AccessDelete, sAccessBatchQFolder.AccessPrint,   
 sAccessBatchQFolder.TeamId, sAccessBatchQFolder.CUser, sAccessBatchQFolder.CDate, sAccessBatchQFolder.MUser,   
 sAccessBatchQFolder.MDate  
FROM  pBatchQueueType WITH (NOLOCK) INNER JOIN  
    sAccessBatchQFolder WITH (NOLOCK) ON pBatchQueueType.BatchQueueTypeID = sAccessBatchQFolder.BatchQTypeID  
WHERE sAccessBatchQFolder.TeamId = @teamId  
ORDER BY pBatchQueueType.BatchQueueTypeName  
  
  


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01564'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01564', GetDate())
END	

GO

  