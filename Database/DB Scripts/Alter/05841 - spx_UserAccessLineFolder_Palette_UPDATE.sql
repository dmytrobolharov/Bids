/****** Object:  StoredProcedure [dbo].[spx_UserAccessLineFolder_Palette_UPDATE]    Script Date: 06/11/2013 15:32:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_UserAccessLineFolder_Palette_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_UserAccessLineFolder_Palette_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_UserAccessLineFolder_Palette_UPDATE]    Script Date: 06/11/2013 15:32:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



  
CREATE PROCEDURE [dbo].[spx_UserAccessLineFolder_Palette_UPDATE] (
@LineTypeID UNIQUEIDENTIFIER,  
@GroupID UNIQUEIDENTIFIER,  
@FullName NVARCHAR (200),  
@CDate DATETIME
)  
AS  
DECLARE @TeamID UNIQUEIDENTIFIER  
DECLARE @DeskFolderID INT  
  
-- GET USERS IN THE GROUP   
DECLARE cursor_users CURSOR FOR   
SELECT TeamID FROM uUserGroup WITH (NOLOCK) WHERE GroupID = @GroupID  
OPEN cursor_users  
FETCH NEXT FROM cursor_users INTO @TeamID  
  
WHILE @@FETCH_STATUS = 0   
BEGIN  
	DELETE FROM sAccessLineFolderPalette where TeamID = @TeamID AND  LineTypeID = @LineTypeID

	INSERT INTO sAccessLineFolderPalette (AccessLineID, LineTypeID, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, LinePaletteID, TeamID, CUser, CDate, MUser, MDate,GroupID)
	SELECT  AccessLineID, LineTypeID , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate ,   
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , LinePaletteID, @TeamID as TeamId ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate , GroupID  
	FROM sAccessGroupLineFolderPalette WITH (NOLOCK)  
	WHERE GroupID IN (   
		SELECT  a.GroupID   
		FROM uUserGroup a WITH (NOLOCK), uGroup b WITH (NOLOCK), cDeskGroupFolderAccess c WITH (NOLOCK)  
		WHERE a.GroupID = b.GroupID AND a.TeamID = @TeamID   
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 2  
	)   
	AND sAccessGroupLineFolderPalette.LineTypeID = @LineTypeID
	GROUP BY  LinePaletteID, AccessLineID, LineTypeID, GroupID 

	SET @DeskFolderID  =  3
	IF ( SELECT count(*) FROM sAccessLineFolderPalette WITH (NOLOCK) WHERE TeamId = @TeamID ) > 0    
	BEGIN   
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess WITH (NOLOCK) WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0   
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID    
		ELSE   
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )  
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )  
	END

	FETCH NEXT FROM cursor_users INTO @TeamID  
END   
 
CLOSE cursor_users  
DEALLOCATE cursor_users  
  
/***************************************************************************************/  
-- CHECK FOR USER WITHOUT A GROUP   
DECLARE cursor_users2 CURSOR FOR   
SELECT  TeamID from Users  WITH (NOLOCK) WHERE TeamID not in (  select  DISTINCT TeamID  from uUserGroup WITH (NOLOCK) )   
OPEN cursor_users2  
FETCH NEXT FROM cursor_users2 INTO @TeamID  
  
WHILE @@FETCH_STATUS = 0   
BEGIN  
 DELETE FROM sAccessLineFolderPalette where TeamID = @TeamID   
  
 FETCH NEXT FROM cursor_users2 INTO @TeamID  
END   
  
CLOSE cursor_users2  
DEALLOCATE cursor_users2  

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05841', GetDate())
GO
