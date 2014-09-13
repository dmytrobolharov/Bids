/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/


ALTER   PROCEDURE [dbo].[rpx_Style_MaterialImageGrid_SELECT]
	(@StyleID AS varchar(50), 	
	@StyleSet AS int)
AS 


SELECT RTRIM(ct.ComponentDescription) AS ComponentDescription, sm.MainMaterial, sm.MaterialNo, 
	 sm.MaterialName, sm.G AS Content, sm.H AS Construction, sm.I AS YarnSizeCount, sm.K AS Weight, 
	 sm.L AS WashFabr, sm.Placement, sm.Qty, sm.MaterialSize, 
	 (dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath,	--Comment #01
	 ct.ComponentOrder
FROM pStyleMaterials sm INNER JOIN pComponentType ct ON
	sm.MaterialType = ct.ComponentTypeID LEFT OUTER JOIN hImage hi ON
	sm.MaterialImageID = hi.ImageID AND sm.MaterialImageVersion = hi.Version 
WHERE ((sm.StyleSet = @StyleSet) AND
	(sm.StyleID = @StyleID))
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '629', GetDate())
GO