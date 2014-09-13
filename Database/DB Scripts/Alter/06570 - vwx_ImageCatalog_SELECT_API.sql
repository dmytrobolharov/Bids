
/****** Object:  View [dbo].[vwx_ImageCatalog_SELECT_API]    Script Date: 11/12/2013 12:55:56 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ImageCatalog_SELECT_API]'))
DROP VIEW [dbo].[vwx_ImageCatalog_SELECT_API]
GO


/****** Object:  View [dbo].[vwx_ImageCatalog_SELECT_API]    Script Date: 11/12/2013 12:55:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[vwx_ImageCatalog_SELECT_API]
AS
	
WITH ImageCatalog AS (SELECT a.ImageCatalogID as ImageCatalogID2, b.CountOfType, p.ImageID as MostRecentlyModifiedImage,  p.mdate as LastModifiedDate, p.Version , 
					 ROW_NUMBER() OVER(PARTITION BY a.ImageCatalogID ORDER BY p.mdate DESC) AS rk
					 FROM pImageCatalogItem a inner join pimage p on p.ImageID=a.ImageID ,
(SELECT  ImageCatalogID,   COUNT(DISTINCT ImageID) as CountOfType
FROM pImageCatalogItem	GROUP BY ImageCatalogID) b WHERE a.ImageCatalogID = b.ImageCatalogID)
SELECT * 
	FROM pImageCatalog c
	INNER JOIN ImageCatalog i ON c.ImageCatalogID = i.ImageCatalogID2
	WHERE i.rk = 1
	

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06570', GetDate())
GO
