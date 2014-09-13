IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCosting_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCosting_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleCosting_SELECT](
@StyleID UNIQUEIDENTIFIER,
@StyleSeasonYearID UNIQUEIDENTIFIER 
)
AS 

IF @StyleSeasonYearID  IS NULL 
BEGIN
	SELECT pStyleCosting.StyleCostingID, pStyleCosting.StyleID,
	pStyleCosting.StyleCostingTypeID, pStyleCostingType.StyleCostingType 
	FROM pStyleCosting 
	INNER JOIN pStyleCostingType ON pStyleCosting.StyleCostingTypeID = pStyleCostingType.StyleCostingTypeID
	WHERE pStyleCosting.StyleID = @StyleID
	AND StyleCostingHeaderId IS NULL	-- in order to show only costing added in old costing workflow
END 
ELSE 
BEGIN 
	SELECT pStyleCosting.StyleCostingID, pStyleCosting.StyleID,
	pStyleCosting.StyleCostingTypeID, pStyleCostingType.StyleCostingType 
	FROM pStyleCosting 
	INNER JOIN pStyleCostingType ON pStyleCosting.StyleCostingTypeID = pStyleCostingType.StyleCostingTypeID
	WHERE pStyleCosting.StyleID = @StyleID
	AND StyleSeasonYearID = @StyleSeasonYearID 
	AND StyleCostingHeaderId IS NULL	-- in order to show only costing added in old costing workflow
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05338', GetDate())
GO
