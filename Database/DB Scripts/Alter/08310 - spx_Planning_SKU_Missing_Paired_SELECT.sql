IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKU_Missing_Paired_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKU_Missing_Paired_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKU_Missing_Paired_SELECT]
(
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @PlanningSKUHeaderID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT
		pli.PlanningItemID
	FROM
		pPlanningItem pli
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
		INNER JOIN pPlanningSKUHeader psh ON pli.PlanningID = psh.PlanningID
		INNER JOIN vwx_PlanningSKUHeader_StyleSKU_Matching_SEL vsku ON psh.PlanningSKUHeaderID = vsku.PlanningSKUHeaderID AND pli.StyleID = vsku.StyleID
	WHERE
		pli.PlanningItemDrop = 'No'
		AND pli.PlanningID = @PlanningID
		AND psh.PlanningSKUHeaderID = @PlanningSKUHeaderID
	GROUP BY
		pli.PlanningItemID
	HAVING SUM(CASE WHEN vsku.StyleSKUHeaderID IS NOT NULL THEN 1 ELSE 0 END) = 0
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08310', GetDate())
GO

