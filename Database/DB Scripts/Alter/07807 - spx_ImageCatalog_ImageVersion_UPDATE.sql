IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageCatalog_ImageVersion_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageCatalog_ImageVersion_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_ImageCatalog_ImageVersion_UPDATE]
	@ImageCatalogID UNIQUEIDENTIFIER,
	@ImageID UNIQUEIDENTIFIER,
	@ImageVersion NVARCHAR(10)
AS
BEGIN	
	IF (SELECT COUNT(*) FROM pImageCatalogItem WHERE ImageCatalogID = @ImageCatalogID AND ImageID = @ImageID AND ImageVersion <> @ImageVersion) > 0
		UPDATE pImageCatalogItem SET ImageVersion = @ImageVersion WHERE ImageCatalogID = @ImageCatalogID AND ImageID = @ImageID
END




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07807', GetDate())
GO
