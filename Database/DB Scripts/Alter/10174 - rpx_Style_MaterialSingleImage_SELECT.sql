IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_MaterialSingleImage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_MaterialSingleImage_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_MaterialSingleImage_SELECT]
	(@MaterialID AS nvarchar(50), @StyleID AS nvarchar(50), 	
	@StyleSet AS int)
AS 


SELECT (dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version], 2000)) AS FilePath	--Comment #01
FROM pStyleMaterials sm INNER JOIN pComponentType ct ON
	sm.MaterialType = ct.ComponentTypeID LEFT OUTER JOIN hImage hi ON
	sm.MaterialImageID = hi.ImageID AND sm.MaterialImageVersion = hi.Version 
WHERE ((sm.StyleSet = @StyleSet) AND
	(sm.StyleID = @StyleID) AND (sm.MaterialID = @MaterialID)) 
ORDER BY sm.MaterialSort, sm.MaterialNo


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10174', GetUTCDate())
GO