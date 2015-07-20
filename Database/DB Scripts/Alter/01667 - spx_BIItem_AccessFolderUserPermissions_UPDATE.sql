
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 27 July 2011                                                                               */
-- * WorkItem #4091                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_BIItem_AccessFolderUserPermissions_UPDATE]    Script Date: 07/27/2011 14:42:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BIItem_AccessFolderUserPermissions_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BIItem_AccessFolderUserPermissions_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_BIItem_AccessFolderUserPermissions_UPDATE]    Script Date: 07/27/2011 14:42:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BIItem_AccessFolderUserPermissions_UPDATE] (
@BITypeID int,  
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
  
   
 --IF @FolderName = 'BI'    
 BEGIN  
  
  /********************************************************************************************************************************************************************/  
  -- BI FOLDER  
  DELETE FROM sAccessBIItemsFolder where TeamId = @TeamID AND  BITypeID = @BITypeID   
  
  SET @DeskFolderID  =  17
  
  INSERT INTO sAccessBIItemsFolder (AccessBIId, BITypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessRemove, AccessDelete , AccessPrint , ItemID,  TeamId, CUser, CDate, MUser, MDate, GroupID, [Description]   )  
  SELECT  AccessBIId, BITypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate ,   
  MAX ( AccessModify )  AS AccessModify  , MAX ( AccessRemove ) AS AccessRemove , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , ItemID, @TeamID as TeamId ,  
  @FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate , GroupID, [Description]  
  FROM sAccessBIItems WITH (NOLOCK)  
  WHERE GroupID IN (   
   SELECT  a.GroupID   
   FROM uUserGroup a WITH (NOLOCK), uGroup b WITH (NOLOCK), cDeskGroupFolderAccess c WITH (NOLOCK)  
   WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID   
   AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = @DeskFolderID  
  )   
 AND sAccessBIItems.BITypeId = @BITypeID
  GROUP BY  ItemID, AccessBIId, BITypeId, GroupID, [Description]    
  
  
    
  IF ( SELECT count(*) FROM sAccessBIFolder WITH (NOLOCK) WHERE TeamId = @TeamID ) > 0    
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
   
 DELETE FROM sAccessBIFolder where TeamID = @TeamID    
  
  
 FETCH NEXT FROM cursor_users2 INTO @TeamID  
  
END   
  
CLOSE cursor_users2  
DEALLOCATE cursor_users2  

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01667'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01667', GetDate())

END

GO 

