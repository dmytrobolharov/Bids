
/****** Object:  View [dbo].[vwx_ImageCatalog_SELECT_API]    Script Date: 12/12/2013 19:20:50 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ImageCatalog_SELECT_API]'))
DROP VIEW [dbo].[vwx_ImageCatalog_SELECT_API]
GO


/****** Object:  View [dbo].[vwx_ImageCatalog_SELECT_API]    Script Date: 12/12/2013 19:20:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwx_ImageCatalog_SELECT_API]
AS
 WITH ImageCatalog AS 
(SELECT d.ImageCatalogID as  ImageCatalogID2,  b.CountOfType, COALESCE(p.ImageID,'00000000-0000-0000-0000-000000000000') as MostRecentlyModifiedImage,  p.mdate as LastModifiedDate, p.Version , 
					 ROW_NUMBER() OVER(PARTITION BY d.ImageCatalogID ORDER BY p.mdate DESC) AS rk
					 FROM pImageCatalog d 
					 LEFT OUTER JOIN  pImageCatalogItem a on d.ImageCatalogID=a.ImageCatalogID  left join pimage p on p.ImageID=a.ImageID ,
					 (SELECT  i.ImageCatalogID,   COUNT(DISTINCT g.ImageID) as CountOfType
FROM pImageCatalog	i left join  pImageCatalogItem e on i.ImageCatalogID=e.ImageCatalogID 
left join pimage g on e.ImageID=g.ImageID
GROUP BY i.ImageCatalogID) b WHERE d.ImageCatalogID = b.ImageCatalogID)
SELECT * from pImageCatalog l
INNER JOIN ImageCatalog s ON l.ImageCatalogID = s.ImageCatalogID2
	WHERE s.rk = 1




GO






INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06762', GetDate())
GO
