IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorHistory_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorHistory_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ColorHistory_INSERT]
(
	@ColorFolderId UNIQUEIDENTIFIER
	, @TeamId UNIQUEIDENTIFIER
	, @CreatedDate DATETIME
)
AS 
BEGIN
	DELETE FROM pColorHistory WHERE TeamID = @TeamID AND ColorFolderId = @ColorFolderId
	INSERT INTO pColorHistory (ColorFolderId, TeamID, CDate) VALUES (@ColorFolderId, @TeamID, @CreatedDate)

	DELETE FROM pColorHistory WHERE TeamID = @TeamID AND ColorFolderID NOT IN (SELECT TOP 10 ColorFolderID From pColorHistory WHERE TeamID = @TeamID ORDER BY CDate DESC)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07245', GetDate())
GO
