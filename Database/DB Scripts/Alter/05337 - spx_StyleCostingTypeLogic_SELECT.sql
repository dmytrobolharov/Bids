IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingTypeLogic_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingTypeLogic_SELECT]
GO



CREATE PROCEDURE [dbo].[spx_StyleCostingTypeLogic_SELECT](
	@StyleID UNIQUEIDENTIFIER
	,@StyleSeasonYearID UNIQUEIDENTIFIER 
)

AS 


IF(@StyleSeasonYearID IS NOT NULL)
	BEGIN 
		SELECT StyleCostingTypeID, StyleCostingType, StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteSchema, Active, ShowBOM, ShowBOL
		FROM   dbo.pStyleCostingType
		WHERE StyleCostingTypeID NOT IN ( 
			SELECT StyleCostingTypeID FROM pStyleCosting WHERE StyleID = @StyleID  AND StyleSeasonYearID = @StyleSeasonYearID AND StyleCostingHeaderId IS NULL
		)
		AND Active = 1
		--AND StyleCostingTypeId = 1  -- Only Import
	END 
ELSE
	BEGIN
		SELECT StyleCostingTypeID, StyleCostingType, StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteSchema, Active, ShowBOM, ShowBOL
		FROM   dbo.pStyleCostingType
		WHERE StyleCostingTypeID NOT IN ( 
			SELECT StyleCostingTypeID FROM pStyleCosting WHERE StyleID = @StyleID  AND StyleCostingHeaderId IS NULL
		)
		AND Active = 1
		--AND StyleCostingTypeId = 1  -- Only Import
	END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05337', GetDate())
GO
