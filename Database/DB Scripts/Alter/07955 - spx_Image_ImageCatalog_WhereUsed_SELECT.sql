IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Image_ImageCatalog_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Image_ImageCatalog_WhereUsed_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Image_ImageCatalog_WhereUsed_SELECT]
	@ImageID UNIQUEIDENTIFIER
	, @WhereClause NVARCHAR(MAX)

AS
BEGIN
		SELECT pImageCatalog.*, pImageCatalogItem.ImageID AS CatalogImageID, pImageCatalogItem.ImageVersion As CatalogImageVersion 
		INTO #tmp0
		FROM pImageCatalog 
			INNER JOIN pImageCatalogItem ON pImageCatalog.ImageCatalogID = pImageCatalogItem.ImageCatalogID
		WHERE pImageCatalogItem.ImageID = @ImageID AND pImageCatalogItem.ImageID != '00000000-0000-0000-0000-000000000000'
			
		EXEC('SELECT * FROM #tmp0 ' + @WhereClause)
			
		DROP TABLE #tmp0

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07955', GetDate())
GO
