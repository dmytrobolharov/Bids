IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Item_AccessBatchQFolder_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Item_AccessBatchQFolder_SELECT]
GO
  
CREATE PROCEDURE [dbo].[spx_Item_AccessBatchQFolder_SELECT] (     
	@GroupID uniqueidentifier,  
	@BatchQueueTypeID UNIQUEIDENTIFIER    
)    
AS     
    
    
SELECT a.BatchQueueDesc, a.BatchQueueID, a.BatchQueueName,    
 b.AccessBatchQItemID, b.AccessBatchQId,  b.AccessRoleId, b.AccessView, b.AccessCreate,     
 b.AccessModify, b.AccessDelete, b.AccessPrint, b.AccessRemove,     
 b.GroupID, b.CUser, b.CDate,  b.MUser,     
 b.MDate    
FROM  pBatchQueue a WITH (NOLOCK) INNER JOIN   sAccessBatchQItems  b WITH (NOLOCK) ON a.BatchQueueID = b.BatchQueueID    
WHERE b.GroupID = @GroupID  AND b.BatchQTypeId = @BatchQueueTypeID   
ORDER BY a.BatchQueueName   
  
  
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01562'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01562', GetDate())
END	

GO



