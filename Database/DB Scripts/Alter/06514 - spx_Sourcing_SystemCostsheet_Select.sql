IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_SystemCostsheet_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_SystemCostsheet_Select]
GO


CREATE PROCEDURE [dbo].[spx_Sourcing_SystemCostsheet_Select]
(
	@StyleID uniqueidentifier, 
	@StyleCostingTypeID int, 
	@SeasonYearID uniqueidentifier
)
AS 

BEGIN

SELECT costsheet.StytleCostingScenarioItemsID as StyleCostingScenarioItemsID, costsheet.StyleCostingName 
FROM pStyleCosting costing 
	INNER JOIN pStyleCostingScenarioItems costsheet
	ON costing.StyleCostingScenarioItemsId = costsheet.StytleCostingScenarioItemsID
	INNER JOIN pStyleSeasonYear ssy ON costing.StyleSeasonYearID = ssy.StyleSeasonYearID 
	WHERE costing.StyleCostingTypeID = @StyleCostingTypeID AND costing.StyleID = @StyleID AND ssy.SeasonYearID = @SeasonYearID 
UNION 
	SELECT StyleCostingID as StyleCostingScenarioItemsID, StyleCostingName FROM pStyleCosting costing 
	INNER JOIN pStyleSeasonYear ssy ON costing.StyleSeasonYearID = ssy.StyleSeasonYearID 
	WHERE costing.StyleCostingID = costing.StyleCostingScenarioItemsId 
	AND costing.StyleCostingTypeID = @StyleCostingTypeID AND costing.StyleID = @StyleID AND ssy.SeasonYearID = @SeasonYearID
 	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06514', GetDate())
GO
