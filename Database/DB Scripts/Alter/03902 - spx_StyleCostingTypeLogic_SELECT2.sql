IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingTypeLogic_SELECT2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingTypeLogic_SELECT2]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleCostingTypeLogic_SELECT2](
	@StyleID UNIQUEIDENTIFIER
	,@StyleSeasonYearID UNIQUEIDENTIFIER 
)

AS 


IF(@StyleSeasonYearID IS NOT NULL)
	BEGIN 
		SELECT StyleCostingTypeID, StyleCostingType, StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteSchema, Active, ShowBOM, ShowBOL
		FROM   dbo.pStyleCostingType
		WHERE Active = 1
	END 
ELSE
	BEGIN
		SELECT StyleCostingTypeID, StyleCostingType, StyleCostingSchema, StyleCostingPrintSchema, StyleQuoteSchema, Active, ShowBOM, ShowBOL
		FROM   dbo.pStyleCostingType
		WHERE Active = 1
	END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03902', GetDate())
GO
