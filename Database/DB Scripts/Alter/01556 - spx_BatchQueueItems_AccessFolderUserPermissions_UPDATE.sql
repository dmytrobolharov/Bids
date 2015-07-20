IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQueueItems_AccessFolderUserPermissions_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_BatchQueueItems_AccessFolderUserPermissions_UPDATE]
GO
    
CREATE PROCEDURE [dbo].[spx_BatchQueueItems_AccessFolderUserPermissions_UPDATE] (  
@BatchQTypeID UNIQUEIDENTIFIER,    
@GroupID uniqueidentifier ,    
@FullName as nvarchar (200) ,    
@CDate  as DateTime  
)    
AS    
DECLARE @TeamID uniqueidentifier    
DECLARE @DeskFolderID INT    
    
-- GET USERS IN THE GROUP     
    
DECLARE cursor_users CURSOR FOR     
SELECT TeamID FROM uUserGroup WITH (NOLOCK) WHERE GroupID = @GroupID    
    
OPEN cursor_users    
    
FETCH NEXT FROM cursor_users INTO @TeamID    
    
    
WHILE @@FETCH_STATUS = 0     
BEGIN    
    
 --SELECT USUARIO = @TeamID    
    
     
 --IF @FolderName = 'BatchQ Folder'      
 BEGIN    
    
  /********************************************************************************************************************************************************************/    
  -- BatchQ FOLDER    
  DELETE FROM sAccessBatchQFolderItems where TeamID = @TeamID AND  BatchQTypeId = @BatchQTypeID     
    
  INSERT INTO sAccessBatchQFolderItems (AccessBatchQId, BatchQTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessRemove, AccessDelete , AccessPrint , BatchQueueID,  TeamId, CUser, CDate, MUser, MDate, GroupID   )    
  SELECT  AccessBatchQId,  BatchQTypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate ,     
  MAX ( AccessModify )  AS AccessModify  , MAX ( AccessRemove ) AS AccessRemove , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , BatchQueueID, @TeamID as TeamId ,    
  @FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate , GroupID    
  FROM sAccessBatchQItems WITH (NOLOCK)    
  WHERE GroupID IN (     
   SELECT  a.GroupID     
   FROM uUserGroup a WITH (NOLOCK), uGroup b WITH (NOLOCK), cDeskGroupFolderAccess c WITH (NOLOCK)    
   WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID     
   AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 18    
  )     
 AND sAccessBatchQItems.BatchQTypeId = @BatchQTypeID  
  GROUP BY  BatchQueueID, AccessBatchQId, BatchQTypeId, GroupID      
    
    
  SET @DeskFolderID  =  18    
  IF ( SELECT count(*) FROM sAccessBatchQFolder WITH (NOLOCK) WHERE TeamId = @TeamID ) > 0      
  BEGIN     
   IF ( SELECT Count(*) FROM cDeskUserFolderAccess WITH (NOLOCK) WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0     
    UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID      
   ELSE     
    INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )    
    VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )    
  END    
  ELSE    
    
   DELETE FROM  cDeskUserFolderAccess WHERE TeamID =@TeamID and DeskFolderId = @DeskFolderId     
 END    
        
     
     
 FETCH NEXT FROM cursor_users INTO @TeamID    
END     
    
    
CLOSE cursor_users    
DEALLOCATE cursor_users    
    
    
    
/****************************************************************************************************************************************************************************************************************************************/    
-- CHECK FOR USER WITHOUT A GROUP     
DECLARE cursor_users2 CURSOR FOR     
SELECT  TeamID from Users  WITH (NOLOCK) WHERE TeamID not in (  select  DISTINCT TeamID  from uUserGroup WITH (NOLOCK) )     
    
    
OPEN cursor_users2    
FETCH NEXT FROM cursor_users2 INTO @TeamID    
    
WHILE @@FETCH_STATUS = 0     
BEGIN    
     
 DELETE FROM sAccessBatchQFolder where TeamID = @TeamID      
    
    
 FETCH NEXT FROM cursor_users2 INTO @TeamID    
    
END     
    
CLOSE cursor_users2    
DEALLOCATE cursor_users2    
  
  
  
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01556'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01556', GetDate())
END	

GO

  