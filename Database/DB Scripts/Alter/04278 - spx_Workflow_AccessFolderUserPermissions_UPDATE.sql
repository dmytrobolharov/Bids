/****** Object:  StoredProcedure [dbo].[spx_Workflow_AccessFolderUserPermissions_UPDATE]    Script Date: 11/02/2012 14:30:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_AccessFolderUserPermissions_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Workflow_AccessFolderUserPermissions_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_Workflow_AccessFolderUserPermissions_UPDATE]    Script Date: 11/02/2012 14:30:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


  
CREATE PROCEDURE [dbo].[spx_Workflow_AccessFolderUserPermissions_UPDATE] (
@StyleTypeID int,  
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
  
   
 --IF @FolderName = 'STYLE'    
 BEGIN  
  
  /********************************************************************************************************************************************************************/  
  -- STYLE FOLDER  
  DELETE FROM sAccessStyleWorkflowFolder where TeamID = @TeamID AND  StyleTypeID = @StyleTypeID   
  
  INSERT INTO sAccessStyleWorkflowFolder (AccessStyleId, StyleTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessRemove, AccessDelete , AccessPrint , WorkflowID,  TeamId, CUser, CDate, MUser, MDate, GroupID   )  
  SELECT  AccessStyleId, StyleTypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate ,   
  MAX ( AccessModify )  AS AccessModify  , MAX ( AccessRemove ) AS AccessRemove , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , WorkflowID, @TeamID as TeamId ,  
  @FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate , GroupID  
  FROM sAccessStyleWorkflow WITH (NOLOCK)  
  WHERE GroupID IN (   
   SELECT  a.GroupID   
   FROM uUserGroup a WITH (NOLOCK), uGroup b WITH (NOLOCK), cDeskGroupFolderAccess c WITH (NOLOCK)  
   WHERE a.GroupID = b.GroupID AND a.TeamID = @TeamID   
   AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 2  
  )   
 AND sAccessStyleWorkflow.StyleTypeId = @StyleTypeID
  GROUP BY  WorkflowID, AccessStyleId, StyleTypeId, GroupID    
  
  
  SET @DeskFolderID  =  2  
  IF ( SELECT count(*) FROM sAccessStyleWorkflowFolder WITH (NOLOCK) WHERE TeamId = @TeamID ) > 0    
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
   
 DELETE FROM sAccessStyleFolder where TeamID = @TeamID    
  
  
 FETCH NEXT FROM cursor_users2 INTO @TeamID  
  
END   
  
CLOSE cursor_users2  
DEALLOCATE cursor_users2  


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04278', GetDate())
GO
