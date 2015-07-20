IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ImageCatalog_Customer_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_ImageCatalog_Customer_SELECT]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[rpx_ImageCatalog_Customer_SELECT] 	 
	@ImageCatalogID AS nvarchar(255)
AS


SELECT IDENTITY(INT,0,1) AS RowNumber, 
hi.ImageDescription, 
hi.ImageSubFolder3 AS Customer, 
hi.ImageSubFolder4 AS Brand, 
hi.ImageSubFolder5 AS Component, 
hi.ImageCode AS ProjectNo, 
ip.ImageNo AS ImageNo,
(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version], 2000)) AS FilePath,	--Comment #01
ic.CatalogName, ic.CUser, CONVERT(nvarchar(20), ic.CDate, 101) AS CDate, 
ci.ImageSort,ip.ImageSubFolder1 AS ImageType,ip.ImageSubFolder2 as Division
INTO	#TblTemp
FROM	pImageCatalog ic, pImageCatalogItem ci, hImage hi,pImage ip
WHERE	((ci.ImageCatalogID = ic.ImageCatalogID) 
	AND (ci.ImageID = hi.ImageID) 
	AND (ci.ImageID = ip.ImageID) 
	AND (ci.ImageVersion = hi.Version) 
	AND (ic.ImageCatalogID = @ImageCatalogID))
ORDER BY ci.ImageSort, ip.ImageNo 

SELECT	RowNumber % 4 AS [Column], RowNumber / 4 AS Row, ImageDescription, Customer, Brand, 
Component, ProjectNo,FilePath, CatalogName, CUser, CDate, ImageSort,ImageType,Division
FROM #TblTemp ORDER BY ImageSort, ImageNo



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10101', GetUTCDate())
GO