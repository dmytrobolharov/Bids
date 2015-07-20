IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_MissingMaterials_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_MissingMaterials_SEL]
GO

CREATE PROCEDURE [dbo].[spx_Planning_MissingMaterials_SEL]
(
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @MaterialID UNIQUEIDENTIFIER
)
AS

BEGIN
	SELECT sh.StyleID AS ItemID, sh.Description AS ItemName, sh.StyleNo AS ItemNo, sh.DesignSketchID AS ItemImageID, sh.DesignSketchVersion AS ItemImageVersion
	FROM pPlanningItem pli 
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
			AND ssy.SeasonYearID = @SeasonYearID
			AND pli.PlanningID = @PlanningID
		INNER JOIN pStyleBOM sb ON pli.StyleBOMDimensionID = sb.StyleBOMDimensionId
			AND sb.MaterialID = @MaterialID
		INNER JOIN pStyleHeader sh ON pli.StyleID = sh.StyleID		
	ORDER BY sh.StyleNo, sh.Description
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06728', GetDate())
GO
