/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/


ALTER     PROCEDURE [dbo].[rpx_Style_MaterialArtwork_2_SELECT] 
	@StyleID AS varchar(255), 
	@StyleSet As int
AS

 
CREATE TABLE #tempArtworkImages
(
	TableRow int identity(0,1),
	MaterialDescription nvarchar(255),
	FilePath nvarchar(255)
)


/*Insert the images into the temp table so that they can be arranged for a matrix.*/
INSERT INTO #tempArtworkImages (MaterialDescription, FilePath)
SELECT ('(' + sm.MaterialNo + ') ' + sm.MaterialName) AS MaterialDescription, 
	(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath	--Comment #01
FROM	pStyleMaterials sm, hImage hi 
WHERE ((sm.MaterialImageID = hi.ImageID) 
	AND (sm.MaterialImageVersion = hi.Version) 
	AND (sm.StyleSet =  @StyleSet) 
	AND (sm.StyleID = @StyleID))
	AND (sm.Artwork = 1)
ORDER BY sm.MainMaterial DESC, sm.MaterialType, sm.MaterialSort, sm.MaterialNo

SELECT
	TableRow % 2 AS [Column],
	TableRow / 2 AS Row,
	MaterialDescription,
	FilePath
FROM #tempArtworkImages

DROP TABLE #tempArtworkImages
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '264', GetDate())
GO