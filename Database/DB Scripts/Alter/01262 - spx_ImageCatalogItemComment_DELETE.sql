IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageCatalogItemComment_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ImageCatalogItemComment_DELETE]
GO

CREATE PROCEDURE dbo.spx_ImageCatalogItemComment_DELETE(
	@ImageCommentID UNIQUEIDENTIFIER,
	@MTeamID UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS

	DELETE FROM dbo.pImageComment WHERE ImageCommentID = @ImageCommentID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01262', GetDate())
GO
