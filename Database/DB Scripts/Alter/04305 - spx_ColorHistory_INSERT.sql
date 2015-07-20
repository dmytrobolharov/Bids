IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorHistory_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorHistory_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ColorHistory_INSERT]
(@ColorFolderId uniqueidentifier,
@TeamId uniqueidentifier,
@CreatedDate datetime)
AS 


IF (SELECT COUNT(*) FROM pColorHistory WITH (NOLOCK) WHERE TeamID = @TeamID AND ColorFolderId = @ColorFolderId) = 0
	BEGIN
		INSERT INTO pColorHistory  (ColorFolderId, TeamID, CDate) VALUES ( @ColorFolderId, @TeamID, @CreatedDate)
	END
Else
	BEGIN
		UPDATE pColorHistory SET  CDate = @CreatedDate WHERE ColorFolderID = @ColorFolderId AND TeamID = @TeamID
	END

BEGIN
	DELETE FROM pColorHistory WHERE TeamID = @TeamID AND  ColorFolderID NOT IN (SELECT TOP 9 ColorFolderID From pColorHistory WITH (NOLOCK) WHERE TeamID = @TeamID ORDER BY CDate DESC)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04305', GetDate())
GO
