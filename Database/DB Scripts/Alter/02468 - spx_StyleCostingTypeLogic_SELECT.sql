IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingTypeLogic_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingTypeLogic_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleCostingTypeLogic_SELECT](
	@StyleID UNIQUEIDENTIFIER
	,@StyleSeasonYearID UNIQUEIDENTIFIER 
)

AS 


IF(@StyleSeasonYearID IS NOT NULL)
	BEGIN 
		SELECT StyleCostingTypeID, StyleCostingType, StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteSchema, Active
		FROM   dbo.pStyleCostingType
		WHERE StyleCostingTypeID NOT IN ( 
			SELECT StyleCostingTypeID FROM pStyleCosting WHERE StyleID = @StyleID  AND StyleSeasonYearID = @StyleSeasonYearID
		)
		AND Active = 1
		--AND StyleCostingTypeId = 1  -- Only Import
	END 
ELSE
	BEGIN
		SELECT StyleCostingTypeID, StyleCostingType, StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteSchema, Active
		FROM   dbo.pStyleCostingType
		WHERE StyleCostingTypeID NOT IN ( 
			SELECT StyleCostingTypeID FROM pStyleCosting WHERE StyleID = @StyleID  
		)
		AND Active = 1
		--AND StyleCostingTypeId = 1  -- Only Import
	END
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02468'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02468', GetDate())

END
GO