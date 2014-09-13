IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessBatchQueueItemFolderCheck_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Group_DesktopAccessBatchQueueItemFolderCheck_INSERT]
GO

    
CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessBatchQueueItemFolderCheck_INSERT] (        
@AccessBatchQId uniqueidentifier,       
@AccessRoleId int,      
@BatchQTypeID UNIQUEIDENTIFIER,      
@GroupID uniqueidentifier,     
@TeamID uniqueidentifier,     
@CreatedBy nvarchar(200),        
@CreatedDate datetime        
)        
AS        
        
DECLARE @I as int        
DECLARE @Row_Count int        
DECLARE @BatchQueueTypeIDVal UNIQUEIDENTIFIER        
      
DECLARE @I_WF as int        
DECLARE @Row_Count_WF int        
DECLARE @BatchQueueIDVal uniqueidentifier       
       
DECLARE @DeskAccessId int        
DECLARE @DeskTableName varchar(100)        
DECLARE @DeskTableKey varchar(50)        
        
        
 BEGIN        
 CREATE TABLE #TempGroupAccess (        
  Id int IDENTITY (1, 1) NOT NULL ,         
  BatchQueueTypeID UNIQUEIDENTIFIER NOT NULL,        
  GroupID uniqueidentifier         
 )         
 END        
        
 BEGIN        
         
 INSERT INTO #TempGroupAccess( BatchQueueTypeID) SELECT BatchQueueTypeID FROM pBatchQueueType        
         
         
 SET @Row_Count = (SELECT COUNT(*) FROM #TempGroupAccess)        
         
 SET @I = 1        
        
 WHILE @I <= @Row_Count         
  BEGIN        
        
   SELECT @BatchQueueTypeIDVal = BatchQueueTypeID FROM #TempGroupAccess WHERE ID = @I        
   IF (SELECT COUNT(*) FROM sAccessGroupBatchQueueFolder WITH (NOLOCK) WHERE BatchQueueTypeId = @BatchQueueTypeIDVal  AND GroupID = @GroupID ) = 0        
   BEGIN        
    INSERT INTO sAccessGroupBatchQueueFolder        
     ( BatchQueueTypeID, GroupID, CUser, CDate, MUser, MDate)        
    SELECT BatchQueueTypeID, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate         
    FROM  #TempGroupAccess WHERE Id = @I        
   END        
            
   SET @I = @I + 1        
  END        
        
  SELECT * FROM #tempGroupAccess        
       
 CREATE TABLE #TempWorkflowAccess (        
  Id int IDENTITY (1, 1) NOT NULL ,         
  BatchQueueID uniqueidentifier        
 )         
 END        
        
 BEGIN        
         
 INSERT INTO #TempWorkflowAccess(BatchQueueID) SELECT BatchQueueID FROM pBatchQueue      WHERE BatchQueueTypeID =    @BatchQTypeID      
         
         
 SET @Row_Count_WF = (SELECT COUNT(*) FROM #TempWorkflowAccess)        
         
 SET @I_WF = 1        
        
 WHILE @I_WF <= @Row_Count_WF         
  BEGIN        
        
   SELECT @BatchQueueIDVal = BatchQueueID FROM #TempWorkflowAccess WHERE ID = @I_WF        
   IF (SELECT COUNT(*) FROM sAccessBatchQItems WITH (NOLOCK) WHERE BatchQTypeId = @BatchQTypeID  AND GroupID = @GroupID AND BatchQueueID = @BatchQueueIDVal) = 0        
   BEGIN        
    INSERT INTO sAccessBatchQItems        
     ( AccessBatchQId, AccessRoleId, BatchQTypeID, GroupID, BatchQueueID, CUser, CDate, MUser, MDate)        
    SELECT @AccessBatchQId, @AccessRoleId, @BatchQTypeID, @GroupID, BatchQueueID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate         
    FROM  #TempWorkflowAccess WHERE Id = @I_WF        
   END        
            
   SET @I_WF = @I_WF + 1        
  END        
        
  SELECT * FROM #TempWorkflowAccess        
    
    
------------New Changes------------------    
DECLARE @I_WF_2 as int        
DECLARE @Row_Count_WF_2 int        
DECLARE @BatchQueueFolderIDVal uniqueidentifier    
     
CREATE TABLE #TempWorkflowFolderAccess (        
  Id int IDENTITY (1, 1) NOT NULL ,         
  BatchQueueID uniqueidentifier        
 )         
 END        
        
 BEGIN        
         
 INSERT INTO #TempWorkflowFolderAccess(BatchQueueID) SELECT BatchQueueID FROM pBatchQueue     WHERE BatchQueueTypeID =    @BatchQTypeID 
         
         
 SET @Row_Count_WF_2 = (SELECT COUNT(*) FROM #TempWorkflowFolderAccess)        
         
 SET @I_WF_2 = 1        
        
 WHILE @I_WF_2 <= @Row_Count_WF_2         
  BEGIN        
        
   SELECT @BatchQueueFolderIDVal = BatchQueueID FROM #TempWorkflowFolderAccess WHERE ID = @I_WF_2        
   IF (SELECT COUNT(*) FROM sAccessBatchQFolderItems WITH (NOLOCK) WHERE BatchQTypeId = @BatchQTypeID  AND GroupID = @GroupID AND BatchQueueID = @BatchQueueFolderIDVal) = 0        
   BEGIN        
    INSERT INTO sAccessBatchQFolderItems        
     ( AccessBatchQId, AccessRoleId, BatchQTypeId, GroupID, BatchQueueID, CUser, CDate, MUser, MDate, TeamID)        
    SELECT @AccessBatchQId, @AccessRoleId, @BatchQTypeID, @GroupID, BatchQueueID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @TeamID         
    FROM  #TempWorkflowFolderAccess WHERE Id = @I_WF_2        
   END        
            
   SET @I_WF_2 = @I_WF_2 + 1        
  END        
        
  SELECT * FROM #TempWorkflowFolderAccess      
    
    
        
 END        
 
 
 GO
 
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01561'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01561', GetDate())
END	

GO


