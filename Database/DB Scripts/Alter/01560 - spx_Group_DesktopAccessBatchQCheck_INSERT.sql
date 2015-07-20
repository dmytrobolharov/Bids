IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessBatchQCheck_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Group_DesktopAccessBatchQCheck_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessBatchQCheck_INSERT] (  
@GroupID uniqueidentifier,   
@CreatedBy nvarchar(200),  
@CreatedDate datetime,  
@TeamID uniqueidentifier   
)  
AS  
  
DECLARE @I as int  
DECLARE @Row_Count int  
DECLARE @BatchQueueTypeID uniqueidentifier   
DECLARE @DeskAccessId int  
DECLARE @DeskTableName varchar(100)  
DECLARE @DeskTableKey varchar(50)  
  
  
 BEGIN  
 CREATE TABLE #TempGroupAccess (  
  Id int IDENTITY (1, 1) NOT NULL ,   
  BatchQueueTypeID uniqueidentifier NOT NULL,  
  GroupID uniqueidentifier   
 )   
 END  
  
 BEGIN  
   
 INSERT INTO #TempGroupAccess( BatchQueueTypeID) SELECT BatchQueueTypeID FROM pBatchQueueType  
   
   
 SET @Row_Count = (SELECT COUNT(*) FROM #TempGroupAccess)  
   
 SET @I = 1  
  
 WHILE @I <= @Row_Count   
  BEGIN  
  
   SELECT @BatchQueueTypeID = BatchQueueTypeID FROM #TempGroupAccess WHERE ID = @I  
   IF (SELECT COUNT(*) FROM sAccessGroupBatchQueueFolder WITH (NOLOCK) WHERE BatchQueueTypeID = @BatchQueueTypeID  AND GroupID = @GroupID ) = 0  
   BEGIN  
    INSERT INTO sAccessGroupBatchQueueFolder  
     ( BatchQueueTypeID, GroupID, CUser, CDate, MUser, MDate, TeamID)  
    SELECT BatchQueueTypeID, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate ,  @TeamID  
    FROM  #TempGroupAccess WHERE Id = @I  
   END  
      
   SET @I = @I + 1  
  END  
  
  SELECT * FROM #tempGroupAccess  
  
 END  
  
  
  
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01560'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01560', GetDate())
END	

GO

  