IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_StyleCostsheetHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_StyleCostsheetHeader_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_StyleCostsheetHeader_SELECT](
@StyleID				nVARCHAR(50)
,@SeasonYearID		nVARCHAR(50)
)
AS 

DECLARE @StyleSeasonYearID nVARCHAR(50)
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID

BEGIN
	SELECT TOP 1
		CurrencyType, 
		StyleCostingCustomField6, 
		StyleCostingCustomField1, 
		StyleCostingCustomField21, 
		StyleCostingCustomField9, 
		StyleCostingCustomField8, 
		StyleCostingCustomField10, 
		StyleCostingCustomField7, 
		StyleCostingCustomField2, 
		StyleCostingCustomField22,
		StyleCostingCustomField12,
		StyleCostingCustomField13,
		StyleCostingCustomField18,
		StyleCostingCustomField5,
		StyleCostingCustomField3,
		StyleCostingCustomField14,
		StyleCostingCustomField15,
		StyleCostingCustomField20
	FROM pStyleCostingHeader 
	WHERE StyleID = @StyleID 
	AND StyleSeasonYearID = @StyleSeasonYearID 
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08803', GetDate())
GO
