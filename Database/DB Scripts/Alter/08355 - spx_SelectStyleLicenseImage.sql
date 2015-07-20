IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SelectStyleLicenseImage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SelectStyleLicenseImage]
GO


CREATE  PROCEDURE [dbo].[spx_SelectStyleLicenseImage]
(
@StyleID uniqueidentifier,
@StyleSet int,
@Workflow int,
@SeasonYearID uniqueidentifier = null
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
			pStyleBOM.MaterialImageID IS NOT NULL AND
			pStyleBOM.License = 1 AND
			pStyleSeasonYear.SeasonYearID = @SeasonYearID
	ORDER BY MainMaterial DESC, MaterialType, MaterialSort, MaterialNo 
		
END 
ELSE 
BEGIN 

	SELECT	* 
	FROM	pStyleMaterials 
	WHERE	StyleSet = @StyleSet AND 
			StyleID = @StyleID AND 
			MaterialImageID IS NOT NULL AND
			License = 1  
	ORDER BY MainMaterial DESC, MaterialType, MaterialSort, MaterialNo 
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08355', GetDate())
GO
