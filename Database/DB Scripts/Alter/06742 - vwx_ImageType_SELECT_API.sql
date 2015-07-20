/****** Object:  View [dbo].[vwx_ImageType_SELECT_API]    Script Date: 12/09/2013 11:48:53 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ImageType_SELECT_API]'))
DROP VIEW [dbo].[vwx_ImageType_SELECT_API]
GO

/****** Object:  View [dbo].[vwx_ImageType_SELECT_API]    Script Date: 12/09/2013 11:48:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwx_ImageType_SELECT_API]
AS
	WITH summary AS (SELECT a.ImageSubFolder1 as ImageType2, b.CountOfType, a.ImageID as MostRecentlyModifiedImage, a.Version,
					 ROW_NUMBER() OVER(PARTITION BY a.ImageSubFolder1 ORDER BY a.ImageID DESC) AS rk
					 FROM pImage a, (SELECT ImageSubFolder1, max(mdate) as max_date, COUNT(DISTINCT ImageID) as CountOfType
									 FROM pImage
									 WHERE ImageSubFolder1 IS NOT NULL
									 GROUP BY ImageSubFolder1) b
					 WHERE a.ImageSubFolder1 = b.ImageSubFolder1)
	SELECT * 
	FROM pImageType it
	INNER JOIN summary s ON it.ImageType = s.ImageType2
	WHERE s.rk = 1


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06742', GetDate())
GO
