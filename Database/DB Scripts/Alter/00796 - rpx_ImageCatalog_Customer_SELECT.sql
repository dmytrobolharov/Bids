/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/


ALTER  PROCEDURE [dbo].[rpx_ImageCatalog_Customer_SELECT] 	 
	@ImageCatalogID AS varchar(255)
AS


SELECT identity(int,0,1) AS RowNumber, hi.ImageDescription, hi.ImageSubFolder3 AS Customer, 
	hi.ImageSubFolder4 AS Brand, hi.ImageSubFolder5 AS Component, hi.ImageCode AS ProjectNo, 
	(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath,	--Comment #01
	ic.CatalogName, ic.CUser, CONVERT(varchar(20), ic.CDate, 101) AS CDate, ci.ImageSort  
INTO	#TblTemp
FROM	pImageCatalog ic, pImageCatalogItem ci, hImage hi 
WHERE	((ci.ImageCatalogID = ic.ImageCatalogID) AND (ci.ImageID = hi.ImageID) 
	AND (ci.ImageVersion = hi.Version) 
	AND (ic.ImageCatalogID = @ImageCatalogID))
ORDER BY ci.ImageSort, hi.ImageCode 

SELECT	RowNumber % 4 AS [Column], RowNumber / 4 AS Row, ImageDescription, Customer, Brand, Component, ProjectNo, 
	FilePath, CatalogName, CUser, CDate, ImageSort 
FROM #TblTemp ORDER BY ImageSort, ProjectNo
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '796', GetDate())
GO