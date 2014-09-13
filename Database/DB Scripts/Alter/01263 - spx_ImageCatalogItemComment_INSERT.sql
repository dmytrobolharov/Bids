IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageCatalogItemComment_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ImageCatalogItemComment_INSERT]
GO

CREATE PROCEDURE dbo.spx_ImageCatalogItemComment_INSERT(
	@ImageCatalogID UNIQUEIDENTIFIER,
	@ImageCatalogItemID UNIQUEIDENTIFIER,
	@ImageComment NVARCHAR(4000),
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@CTeamID UNIQUEIDENTIFIER
)
AS

DECLARE 
	@ImageID UNIQUEIDENTIFIER, 
	@ImageVersion INT 

	SELECT @ImageID = ImageID, @ImageVersion = ImageVersion  
	FROM pImageCatalogItem WITH(NOLOCK) WHERE ImageCatalogItemID =  @ImageCatalogItemID
	

	 INSERT INTO dbo.pImageComment(
		ImageCatalogID, ImageID, ImageVersion, TeamID, CUser, CDate, MUser, MDate, ImageComment, CTeamID)
     VALUES(
		@ImageCatalogID, @ImageID, @ImageVersion, '00000000-0000-0000-0000-000000000000', 
		@CUser, @CDate, @CUser, @CDate, @ImageComment, @CTeamID )


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01263', GetDate())
GO
