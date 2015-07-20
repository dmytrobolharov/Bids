IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_StyleCostsheetHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_StyleCostsheetHeader_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_StyleCostsheetHeader_SELECT](
@StyleID				VARCHAR(50)
,@SeasonYearID		VARCHAR(50)
)
AS 

DECLARE @StyleSeasonYearID VARCHAR(50)
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID

BEGIN
	SELECT TOP 1
		StyleCostingCustomField8, 
		StyleCostingCustomField6, 
		StyleCostingCustomField7, 
		StyleCostingCustomField11, 
		StyleCostingCustomField1, 
		StyleCostingCustomField2, 
		StyleCostingCustomField13, 
		StyleCostingCustomField9, 
		StyleCostingCustomField12, 
		StyleCostingCustomField10,
		StyleCostingCustomField20,
		StyleCostingCustomField21,
		StyleCostingCustomField22
	FROM pStyleCostingHeader 
	WHERE StyleID = @StyleID 
	AND StyleSeasonYearID = @StyleSeasonYearID 
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05889', GetDate())
GO
