IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageComment_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageComment_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ImageComment_INSERT]
	@ImageID UNIQUEIDENTIFIER,
	@ImageVersion INT,
	@ImageCatalogID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@CreatedBy NVARCHAR(200),
	@CreatedDate DATETIME,
	@ImageComment NVARCHAR(MAX),
	@CTeamID UNIQUEIDENTIFIER
AS

INSERT INTO dbo.pImageComment (
	  ImageCatalogID
	, ImageID
	, ImageVersion
	, TeamID
	, CUser
	, CDate
	, MUser
	, MDate
	, ImageComment
	, CTeamID)
VALUES (
	  @ImageCatalogID
	, @ImageID
	, @ImageVersion
	, @TeamID
	, @CreatedBy
	, @CreatedDate
	, @CreatedBy
	, @CreatedDate
	, @ImageComment
	, @CTeamID)


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08441', GetDate())
GO
