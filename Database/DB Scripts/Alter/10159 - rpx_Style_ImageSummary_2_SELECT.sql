IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_ImageSummary_2_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_ImageSummary_2_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_ImageSummary_2_SELECT] 
	@StyleID AS nvarchar(255), 
	@StyleSet As int
AS

 
CREATE TABLE #tempArtworkImages
(
	TableRow int identity(0,1),
	MaterialDescription nvarchar(255),
	FilePath nvarchar(255)
)


/*Insert the images into the temp table so that they can be arranged for a matrix.*/

SELECT     dbo.pStyleImageItem.ImageID, dbo.pStyleImageItem.ImageVersion, 'Detail' AS Folder, dbo.pImage.ImageCode AS ImageNo, dbo.pImage.ImageDescription
FROM         dbo.pStyleImageItem INNER JOIN
                      dbo.pImage ON dbo.pStyleImageItem.ImageID = dbo.pImage.ImageID WHERE  StyleID = @StyleID AND ImageVersion <> 0
UNION
SELECT MaterialImageID, MaterialImageVersion, 'Material' AS Folder, MaterialNo, MaterialName  FROM pStyleMaterials WHERE  StyleID = @StyleID AND MaterialImageVersion <> 0
UNION
SELECT MaterialImageID, MaterialImageVersion, 'Licensee' AS Folder, MaterialNo, MaterialName   FROM pStyleMaterials WHERE  StyleID = @StyleID AND License = 1 AND MaterialImageVersion <> 0
UNION
SELECT MaterialImageID, MaterialImageVersion, 'Artwork' AS Folder, MaterialNo, MaterialName   FROM pStyleMaterials WHERE  StyleID = @StyleID AND Artwork = 1 AND MaterialImageVersion <> 0
UNION
SELECT  DesignSketchID, DesignSketchVersion, 'Design' AS Folder, 'Design Sketch' AS ImageNo, 'Design Sketch' As ImageDescription  FROM  pStyleHeader WHERE  dbo.pStyleHeader.StyleID = @StyleID AND DesignSketchVersion <> 0
UNION
SELECT TechSketchID,  TechSketchVersion, 'Tech' AS Folder, 'Tech Sketch' AS ImageNo, 'Tech Sketch' As ImageDescription    FROM  pStyleHeader WHERE  dbo.pStyleHeader.StyleID = @StyleID AND TechSketchVersion <> 0
UNION
SELECT ConceptSketchID, ConceptSketchVersion, 'Concept' AS Folder, 'Concept Sketch' AS ImageNo, 'Concept Sketch' As ImageDescription    FROM  pStyleHeader WHERE  dbo.pStyleHeader.StyleID = @StyleID AND ConceptSketchVersion <> 0
UNION
SELECT SpecSketchID1, SpecSketchVersion1, 'Spec' AS Folder, 'Spec Sketch (1)' AS ImageNo, 'Spec Sketch (1)' As ImageDescription    FROM pStyleImage WHERE  StyleID = @StyleID AND SpecSketchVersion1 <> 0
UNION
SELECT SpecSketchID2, SpecSketchVersion2, 'Spec' AS Folder, 'Spec Sketch (2)' AS ImageNo, 'Spec Sketch (2)' As ImageDescription    FROM pStyleImage WHERE  StyleID = @StyleID AND SpecSketchVersion2 <> 0
UNION
SELECT SpecSketchID3, SpecSketchVersion3, 'Spec' AS Folder, 'Spec Sketch (3)' AS ImageNo, 'Spec Sketch (3)' As ImageDescription    FROM pStyleImage WHERE  StyleID = @StyleID AND SpecSketchVersion3 <> 0
UNION 
SELECT SpecSketchID4, SpecSketchVersion4, 'Spec' AS Folder, 'Spec Sketch (4)' AS ImageNo, 'Spec Sketch (4)' As ImageDescription    FROM pStyleImage WHERE  StyleID = @StyleID AND SpecSketchVersion4 <> 0



INSERT INTO #tempArtworkImages (MaterialDescription, FilePath)
SELECT ('(' + sm.MaterialNo + ') ' + sm.MaterialName) AS MaterialDescription, 
	(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version], 2000)) AS FilePath	--Comment #01
FROM	pStyleMaterials sm, hImage hi 
WHERE ((sm.MaterialImageID = hi.ImageID) 
	AND (sm.MaterialImageVersion = hi.Version) 
	AND (sm.StyleSet =  @StyleSet) 
	AND (sm.StyleID = @StyleID))
	AND (sm.Artwork = 1)
ORDER BY sm.MainMaterial DESC, sm.MaterialType, sm.MaterialSort, sm.MaterialNo

SELECT
	TableRow % 2 AS [Column],
	MaterialDescription,
	FilePath
FROM #tempArtworkImages

DROP TABLE #tempArtworkImages


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10159', GetUTCDate())
GO