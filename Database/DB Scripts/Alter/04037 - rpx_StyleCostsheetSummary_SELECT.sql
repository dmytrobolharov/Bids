IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_StyleCostsheetSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_StyleCostsheetSummary_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[rpx_StyleCostsheetSummary_SELECT](
@StyleID			VARCHAR(50)
,@SeasonYearID		VARCHAR(50)
)
AS

DECLARE @StyleSeasonYearID VARCHAR(50)
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID
 
BEGIN
	SELECT
		StyleCostingType,
		BOMname,
		BOLname,
		StyleCostingName,
		Cost,
		CUser,
		CONVERT(varchar, CDate, 101) as CDate,
		MUser,
		CONVERT(varchar, MDate, 101) as MDate,
		StyleCostingCustomField3,
		StyleCostingCustomField17,
		StyleCostingCustomField4,
		StyleCostingCustomField18,
		StyleCostingCustomField19,
		StyleCostingCustomField44
	FROM vwx_StyleCosting_SEL
	WHERE StyleID = @StyleID 
	AND StyleSeasonYearID = @StyleSeasonYearID 
	ORDER BY CDate ASC, StyleCostingID, StyleCostingScenarioNo ASC

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04037', GetDate())
GO
