IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Material_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Material_Image_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Material_Image_SELECT]
	@MaterialID nvarchar(255)	
AS


SELECT DISTINCT (dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version], 2000)) AS FilePath	--Comment #01
FROM	pMaterial pm, hImage hi 
WHERE ((pm.MaterialImageID = hi.ImageID) AND
	(pm.MaterialImageVersion = hi.Version) AND
	(pm.MaterialID = @MaterialID))


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10121', GetUTCDate())
GO