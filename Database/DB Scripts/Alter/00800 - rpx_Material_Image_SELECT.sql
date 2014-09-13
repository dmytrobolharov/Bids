/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/


ALTER PROCEDURE [dbo].[rpx_Material_Image_SELECT]
	@MaterialID varchar(255)	
AS


SELECT DISTINCT (dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath	--Comment #01
FROM	pMaterial pm, hImage hi 
WHERE ((pm.MaterialImageID = hi.ImageID) AND
	(pm.MaterialImageVersion = hi.Version) AND
	(pm.MaterialID = @MaterialID))
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '800', GetDate())
GO