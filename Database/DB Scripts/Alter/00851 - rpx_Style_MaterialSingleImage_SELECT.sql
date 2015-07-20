/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/


ALTER PROCEDURE [dbo].[rpx_Style_MaterialSingleImage_SELECT]
	(@MaterialID AS varchar(50), @StyleID AS varchar(50), 	
	@StyleSet AS int)
AS 


SELECT (dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath	--Comment #01
FROM pStyleMaterials sm INNER JOIN pComponentType ct ON
	sm.MaterialType = ct.ComponentTypeID LEFT OUTER JOIN hImage hi ON
	sm.MaterialImageID = hi.ImageID AND sm.MaterialImageVersion = hi.Version 
WHERE ((sm.StyleSet = @StyleSet) AND
	(sm.StyleID = @StyleID) AND (sm.MaterialID = @MaterialID)) 
ORDER BY sm.MaterialSort, sm.MaterialNo
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '851', GetDate())
GO