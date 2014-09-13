IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SelectStyleArtworkImage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SelectStyleArtworkImage]
GO

CREATE  PROCEDURE [dbo].[spx_SelectStyleArtworkImage]
(
@StyleID uniqueidentifier,
@StyleSet int,
@Workflow int,
@SeasonYearID uniqueidentifier = NULL
)
AS 

IF @Workflow = 1

BEGIN 

	SELECT	* 
	FROM	pStyleBOM 
		INNER JOIN pWorkFlowItem ON pStyleBOM.WorkflowItemId = pWorkFlowItem.WorkFlowItemID
		INNER JOIN pStyleSeasonYear ON pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
	WHERE	pStyleBOM.StyleSet = @StyleSet AND 
			pStyleBOM.StyleID = @StyleID AND 
			pStyleSeasonYear.SeasonYearID = @SeasonYearID AND
			pStyleBOM.MaterialImageID IS NOT NULL AND
			pStyleBOM.Artwork = 1  
	ORDER BY MainMaterial DESC, MaterialType, MaterialSort, MaterialNo 
		
END 
ELSE 
BEGIN 

	SELECT	* 
	FROM	pStyleMaterials 
	WHERE	StyleSet = @StyleSet AND 
			StyleID = @StyleID AND 
			MaterialImageID IS NOT NULL AND
			Artwork = 1  
	ORDER BY MainMaterial DESC, MaterialType, MaterialSort, MaterialNo 
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06756', GetDate())
GO
