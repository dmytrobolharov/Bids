IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_AccessLinePaletteFolder_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_AccessLinePaletteFolder_UPDATE]
GO

  
CREATE PROCEDURE [dbo].[spx_AccessLinePaletteFolder_UPDATE] (
@LineTypeID UNIQUEIDENTIFIER,  
@TeamID UNIQUEIDENTIFIER,  
@FullName NVARCHAR (200),  
@CDate DATETIME
)  
AS  
DECLARE @DeskFolderID INT  
  
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
	AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 3
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

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07398', GetDate())
GO
