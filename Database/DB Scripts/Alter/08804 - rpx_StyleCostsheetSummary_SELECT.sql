IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_StyleCostsheetSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_StyleCostsheetSummary_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_StyleCostsheetSummary_SELECT](
@StyleID			nVARCHAR(50)
,@SeasonYearID		nVARCHAR(50)
)
AS

DECLARE @StyleSeasonYearID nVARCHAR(50)
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID
 
BEGIN
	SELECT
		StyleCostingType,
		BOMname,
		BOLname,
		StyleCostingName,
		Cost,
		CurrencyType,
		CUser,
		CONVERT(nvarchar, CDate, 101) as CDate,
		MUser,
		CONVERT(nvarchar, MDate, 101) as MDate,
		StyleCostingCustomField3,
		StyleCostingCustomField17,
		StyleCostingCustomField4,
		StyleCostingCustomField18,
		StyleCostingCustomField19,
		StyleCostingCustomField44
	FROM vwx_StyleCosting_SEL
	WHERE StyleID = @StyleID 
	AND StyleSeasonYearID = @StyleSeasonYearID 
	ORDER BY vwx_StyleCosting_SEL.CDate ASC, StyleCostingID, StyleCostingScenarioNo ASC

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08804', GetDate())
GO
