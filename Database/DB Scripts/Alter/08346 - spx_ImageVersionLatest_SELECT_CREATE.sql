/****** Object:  StoredProcedure [dbo].[spx_ImageVersionLatest_SELECT]    Script Date: 7/16/2014 12:06:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ImageVersionLatest_SELECT]
(@ImageID uniqueidentifier)
AS 



SELECT maxT.Version,ISNULL(pIm.Unversioned,0) AS Unversioned ,hI.ImageHistoryID
FROM pImage pIm
INNER JOIN(
SELECT MAX(Version) as Version, ImageID
FROM   hImage WITH (NOLOCK)
GROUP BY ImageID
HAVING ImageID = @ImageID
) maxT 
ON pIm.ImageID = maxT.ImageID
LEFT OUTER JOIN hImage hI 
ON hI.ImageID=maxT.ImageID AND hI.Version = maxT.Version
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08346', GetDate())
GO