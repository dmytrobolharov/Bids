IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingGroup_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingGroup_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleCostingGroup_SELECT](
@StyleID UNIQUEIDENTIFIER,
@StyleSeasonYearID UNIQUEIDENTIFIER 
)
AS 


IF @StyleSeasonYearID IS NULL 
	SELECT pStyleCosting.StyleCostingID, pStyleCosting.StyleID, pStyleCosting.StyleCostingTypeID, pStyleCosting.StyleCostingDate,
	pStyleCosting.StyleCostingStatus, pStyleCostingType.StyleCostingType, StyleCostingFreightTypeID, pStyleCosting.CUser, pStyleCosting.CDate,
	pStyleCosting.MUser, pStyleCosting.MDate
	FROM pStyleCosting INNER JOIN 
	pStyleCostingType ON pStyleCosting.StyleCostingTypeID = pStyleCostingType.StyleCostingTypeID 
	WHERE pStyleCosting.StyleID = @StyleID 
	AND StyleCostingHeaderId IS NULL	-- in order to show only costing added in old costing workflow
	ORDER BY pStyleCosting.StyleCostingTypeID
ELSE
	SELECT pStyleCosting.StyleCostingID, pStyleCosting.StyleID, pStyleCosting.StyleCostingTypeID, pStyleCosting.StyleCostingDate,
	pStyleCosting.StyleCostingStatus, pStyleCostingType.StyleCostingType, StyleCostingFreightTypeID, pStyleCosting.CUser, pStyleCosting.CDate,
	pStyleCosting.MUser, pStyleCosting.MDate
	FROM pStyleCosting INNER JOIN 
	pStyleCostingType ON pStyleCosting.StyleCostingTypeID = pStyleCostingType.StyleCostingTypeID 
	WHERE pStyleCosting.StyleID = @StyleID 
	AND StyleCostingHeaderId IS NULL	-- in order to show only costing added in old costing workflow
	AND pStyleCosting.StyleSeasonYearID = @StyleSeasonYearID
	ORDER BY pStyleCosting.StyleCostingTypeID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05336', GetDate())
GO
