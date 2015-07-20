/****** Object:  View [dbo].[vwx_ImageCatalogItem_Select]    Script Date: 04/26/2013 15:01:48 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ImageCatalogItem_Select]'))
DROP VIEW [dbo].[vwx_ImageCatalogItem_Select]
GO
/****** Object:  View [dbo].[vwx_ImageCatalogItem_Select]    Script Date: 03/22/2013 15:01:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Comments:

General - Rajul Radadia - April 26, 2013

*/
CREATE VIEW [dbo].[vwx_ImageCatalogItem_Select]
AS
SELECT  
	pImageCatalogItem.ImageCatalogItemID, 
	pImageCatalogItem.ImageCatalogID, 
	pImageCatalogItem.ImageID, 
	pImageCatalogItem.ImageVersion, 
	pImage.ImageNo, 
	pImage.ImageDescription, 
	pImageCatalogItem.CUser, 
	pImageCatalogItem.CDate, 
	pImageCatalogItem.MUser, 
	pImageCatalogItem.MDate, 
	pImage.ImageFile, 
	pImageCatalogItem.ImageSort
FROM        
	pImageCatalogItem WITH (NOLOCK) 
	INNER JOIN
	pImage WITH (NOLOCK) ON pImageCatalogItem.ImageID = pImage.ImageID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05622', GetDate())
GO