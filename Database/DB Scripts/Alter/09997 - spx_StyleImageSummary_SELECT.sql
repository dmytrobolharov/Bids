/****** Object:  StoredProcedure [dbo].[spx_StyleImageSummary_SELECT]    Script Date: 13.03.2015 17:43:50 ******/
DROP PROCEDURE [dbo].[spx_StyleImageSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleImageSummary_SELECT]
	@StyleID uniqueidentifier,
	@SeasonYearID UNIQUEIDENTIFIER = NULL
AS
BEGIN

SELECT StyleImage.*, pImage.ImageNo AS OriginalImageNo
FROM
(
		SELECT     dbo.pStyleImageItem.ImageID, dbo.pStyleImageItem.ImageVersion, 'Detail' AS Folder, dbo.pImage.ImageCode AS ImageNo, dbo.pImage.ImageDescription
		FROM         dbo.pStyleImageItem WITH (NOLOCK) INNER JOIN
							  dbo.pImage WITH (NOLOCK) ON dbo.pStyleImageItem.ImageID = dbo.pImage.ImageID WHERE  StyleID = @StyleID AND ImageVersion <> 0
	UNION
		SELECT MaterialImageID, MaterialImageVersion, 'Material' AS Folder, MaterialNo, MaterialName  FROM pStyleMaterials WITH (NOLOCK) WHERE  StyleID = @StyleID AND MaterialImageVersion <> 0
	UNION
		SELECT MaterialImageID, MaterialImageVersion, 'Material' AS Folder, MaterialNo, MaterialName 
		FROM pStyleBOM 
                INNER JOIN pWorkflowItem ON pStyleBOM.WorkflowItemID = pWorkflowItem.WorkflowItemID
                INNER JOIN pStyleSeasonYear ON pWorkflowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
                WHERE pStyleBOM.StyleID = @StyleID AND pStyleSeasonYear.SeasonYearID = @SeasonYearID AND pStyleBOM.MaterialImageID IS NOT NULL 
	UNION
		SELECT MaterialImageID, MaterialImageVersion, 'Licensee' AS Folder, MaterialNo, MaterialName   FROM pStyleMaterials WITH (NOLOCK) WHERE  StyleID = @StyleID AND License = 1 AND MaterialImageVersion <> 0
	UNION
		SELECT	MaterialImageID, MaterialImageVersion, 'Licensee' AS Folder, MaterialNo, MaterialName FROM pStyleBOM 
                INNER JOIN pWorkflowItem ON pStyleBOM.WorkflowItemID = pWorkflowItem.WorkflowItemID
                INNER JOIN pStyleSeasonYear ON pWorkflowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
                WHERE pStyleBOM.StyleID = @StyleID AND pStyleSeasonYear.SeasonYearID = @SeasonYearID AND MaterialImageID IS NOT NULL AND License = 1
	UNION
		SELECT MaterialImageID, MaterialImageVersion, 'Artwork' AS Folder, MaterialNo, MaterialName   FROM pStyleMaterials WITH (NOLOCK) WHERE  StyleID = @StyleID AND Artwork = 1 AND MaterialImageVersion <> 0
	UNION
		SELECT MaterialImageID, MaterialImageVersion, 'Artwork' AS Folder, MaterialNo, MaterialName 
		FROM pStyleBOM
                INNER JOIN pWorkflowItem ON pStyleBOM.WorkflowItemID = pWorkflowItem.WorkflowItemID
                INNER JOIN pStyleSeasonYear ON pWorkflowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
                WHERE	pStyleBOM.StyleID = @StyleID AND pStyleSeasonYear.SeasonYearID = @SeasonYearID AND MaterialImageID IS NOT NULL AND Artwork = 1
	UNION
		SELECT  DesignSketchID, DesignSketchVersion, 'Design' AS Folder, 'Design Sketch' AS ImageNo, 'Design Sketch' As ImageDescription  FROM  pStyleHeader WITH (NOLOCK) WHERE  dbo.pStyleHeader.StyleID = @StyleID AND DesignSketchVersion <> 0
	UNION
		SELECT TechSketchID,  TechSketchVersion, 'Tech' AS Folder, 'Tech Sketch' AS ImageNo, 'Tech Sketch' As ImageDescription    FROM  pStyleHeader WITH (NOLOCK) WHERE  dbo.pStyleHeader.StyleID = @StyleID AND TechSketchVersion <> 0
	UNION
		SELECT ConceptSketchID, ConceptSketchVersion, 'Concept' AS Folder, 'Concept Sketch' AS ImageNo, 'Concept Sketch' As ImageDescription    FROM  pStyleHeader WITH (NOLOCK) WHERE  dbo.pStyleHeader.StyleID = @StyleID AND ConceptSketchVersion <> 0
	UNION
		SELECT SpecSketchID1, SpecSketchVersion1, 'Spec' AS Folder, 'Spec Sketch (1)' AS ImageNo, 'Spec Sketch (1)' As ImageDescription    FROM pStyleImage WITH (NOLOCK) WHERE  StyleID = @StyleID AND SpecSketchVersion1 <> 0
	UNION
		SELECT SpecSketchID2, SpecSketchVersion2, 'Spec' AS Folder, 'Spec Sketch (2)' AS ImageNo, 'Spec Sketch (2)' As ImageDescription    FROM pStyleImage WITH (NOLOCK) WHERE  StyleID = @StyleID AND SpecSketchVersion2 <> 0
	UNION
		SELECT SpecSketchID3, SpecSketchVersion3, 'Spec' AS Folder, 'Spec Sketch (3)' AS ImageNo, 'Spec Sketch (3)' As ImageDescription    FROM pStyleImage WITH (NOLOCK) WHERE  StyleID = @StyleID AND SpecSketchVersion3 <> 0
	UNION 
		SELECT SpecSketchID4, SpecSketchVersion4, 'Spec' AS Folder, 'Spec Sketch (4)' AS ImageNo, 'Spec Sketch (4)' As ImageDescription    FROM pStyleImage WITH (NOLOCK) WHERE  StyleID = @StyleID AND SpecSketchVersion4 <> 0
	UNION ALL
		SELECT V.ImageID, V.ImageVersion, 'Colorway Images' AS Folder, 
			CASE WHEN V.IsFront = 1 THEN 'Front' ELSE 'Back' END AS ImageNo,
			vsy.SeasonYear + '/' + sc.StyleColorNo + ' (' + sc.StyleColorName + ')' AS ImageDescription
		FROM pStyleColorwaySeasonYear scsy
		CROSS APPLY (VALUES (DesignImageFrontID, DesignImageFrontVersion, 1), 
							(DesignImageBackID, DesignImageBackVersion, 0)) 
						   V(ImageID, ImageVersion, IsFront)
		INNER JOIN pStyleSeasonYear ssy ON scsy.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN vwx_SeasonYear_SEL vsy ON ssy.SeasonYearID = vsy.SeasonYearID
		INNER JOIN pStyleColorway sc ON scsy.StyleColorwayID = sc.StyleColorID
		WHERE scsy.StyleID = @StyleID
			AND V.ImageID IS NOT NULL
			AND V.ImageID <> '00000000-0000-0000-0000-000000000000'
) AS StyleImage
LEFT OUTER JOIN pImage ON pImage.ImageID = StyleImage.ImageID

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09997', GetUTCDate())
GO
