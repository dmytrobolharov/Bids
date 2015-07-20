IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ImageCatalog_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[rpx_ImageCatalog_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_ImageCatalog_SELECT]
	@ImageCatalogID AS varchar(255)
AS

DECLARE	@tbl TABLE(RowNumb int IDENTITY(0,1), ImageCode nvarchar(100), ImageDescription nvarchar(200), 
	OrgImageName nvarchar(100), Designer nvarchar(100), CadDesigner nvarchar(100), Component nvarchar(100), 
	FilePath varchar(1000), CatalogName nvarchar(100), CatalogDescription nvarchar(250), 
	CUser nvarchar(100), CDate varchar(20), ImageSort varchar(10), ImageNo varchar(10))

INSERT INTO @tbl (ImageCode, ImageDescription, OrgImageName, Designer, CadDesigner, 
		Component, FilePath, CatalogName, CatalogDescription, 
		CUser, CDate, ImageSort, ImageNo)
SELECT	hi.ImageCode, hi.ImageDescription, hi.ImageSubFolder20 AS OrgImageName, 
	hi.ImageSubFolder21 AS Designer, hi.ImageSubFolder22 AS CadDesigner, 
	hi.ImageSubFolder5 AS Component, 
	(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath,
	ic.CatalogName, ic.CatalogDescription, 
	ic.CUser, CONVERT(varchar(20), ic.CDate, 101) AS CDate, ci.ImageSort, hi.ImageNo
FROM	pImageCatalog ic, pImageCatalogItem ci, hImage hi 
WHERE ((ci.ImageCatalogID = ic.ImageCatalogID) AND (ci.ImageID = hi.ImageID) 
	AND (ci.ImageVersion = hi.Version) 
	AND (ic.ImageCatalogID = @ImageCatalogID))
ORDER BY ci.ImageSort, hi.ImageCode

SELECT	RowNumb % 3 AS TableColumn, RowNumb / 3 AS TableRow, 
ImageCode, ImageDescription, OrgImageName, Designer, CadDesigner, Component, 
	FilePath, CatalogName, CatalogDescription, CUser, CDate, ImageSort, ImageNo
FROM	@tbl  ORDER BY ImageSort, ImageCode
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01432', GetDate())
GO