/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/



ALTER PROCEDURE [dbo].[rpx_ImageCatalog_Single_SELECT] 
	@ImageCatalogID varchar(255)
AS


SELECT pi.ImageKeywords, 
	(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath	--Comment #01
FROM	pImageCatalog ic INNER JOIN pImageCatalogItem ci ON
	ic.ImageCatalogID = ci.ImageCatalogID INNER JOIN pImage pi ON
	ci.ImageID = pi.ImageID INNER JOIN hImage hi ON
	ci.ImageID = hi.ImageID AND ci.ImageVersion = hi.Version
WHERE (ic.ImageCatalogID = @ImageCatalogID)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '797', GetDate())
GO