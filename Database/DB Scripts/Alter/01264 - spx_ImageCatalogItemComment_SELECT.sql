IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageCatalogItemComment_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ImageCatalogItemComment_SELECT]
GO

CREATE PROCEDURE dbo.spx_ImageCatalogItemComment_SELECT(
	@ImageCatalogID UNIQUEIDENTIFIER,
	@ImageID UNIQUEIDENTIFIER
)
AS

	SELECT * FROM pImageComment WITH(NOLOCK)
	WHERE ImageCatalogID = @ImageCatalogID 
		AND ImageID = @ImageID 
	ORDER BY MDate DESC

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01264', GetDate())
GO
