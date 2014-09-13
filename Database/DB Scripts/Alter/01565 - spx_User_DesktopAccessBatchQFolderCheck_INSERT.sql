IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_DesktopAccessBatchQFolderCheck_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_User_DesktopAccessBatchQFolderCheck_INSERT]
GO

  
CREATE PROCEDURE [dbo].[spx_User_DesktopAccessBatchQFolderCheck_INSERT]  
(  
@GroupID uniqueidentifier,
@TeamId uniqueidentifier,  
@CreatedBy nvarchar(200),  
@CreatedDate datetime  
)  
AS  
  
DECLARE @I as int  
DECLARE @Row_Count int  
DECLARE @BatchQueueTypeID UNIQUEIDENTIFIER   
DECLARE @DeskAccessId int  
DECLARE @DeskTableName varchar(100)  
DECLARE @DeskTableKey varchar(50)  
  
  
 BEGIN  
 CREATE TABLE #TempUserAccess (  
  Id int IDENTITY (1, 1) NOT NULL ,   
  BatchQueueTypeID UNIQUEIDENTIFIER NOT NULL,    
  TeamId uniqueidentifier  
 )   
 END  
  
 BEGIN  
   
 INSERT INTO #TempUserAccess( BatchQueueTypeID ) SELECT BatchQueueTypeID FROM pBatchQueueType WITH (NOLOCK)  
   
   
 SET @Row_Count = (SELECT COUNT(*) FROM #TempUserAccess)  
   
 SET @I = 1  
  
 WHILE @I <= @Row_Count   
  BEGIN  
  
   SELECT @BatchQueueTypeID = BatchQueueTypeID FROM #TempUserAccess WHERE ID = @I  
   IF (SELECT COUNT(*) FROM sAccessBatchQFolder WITH (NOLOCK) WHERE BatchQTypeId = @BatchQueueTypeID  AND TeamId = @TeamId) = 0  
   BEGIN  
    INSERT INTO sAccessBatchQFolder  
     ( BatchQTypeId, TeamId, CUser, CDate, MUser, MDate, GroupID)  
    SELECT BatchQueueTypeID, @TeamId, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate,  @GroupID  
    FROM  #TempUserAccess WHERE Id = @I  
   END  
      
   SET @I = @I + 1  
  END  
  
  SELECT * FROM #tempUserAccess  
  
 END  
  
  
  


GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01565'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01565', GetDate())
END	

GO

  