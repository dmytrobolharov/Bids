IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingScenariosLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingScenariosLogic_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_StyleCostingScenariosLogic_UPDATE](
	@StyleCostingId UNIQUEIDENTIFIER,
	@StyleSeasonYearID UNIQUEIDENTIFIER = NULL,
	@FromFlashEdit NVarChar(1) = NULL
)
AS
BEGIN    

/*********************/
/*Declare variables. */
/*********************/
--General
DECLARE @StyleId UNIQUEIDENTIFIER

--pStyleCostingHeader
DECLARE @pStyleCostingHeader_StyleCostingHeaderId UNIQUEIDENTIFIER

--pStyleCosting
DECLARE @pStyleCosting_StyleCostingTypeId INT

DECLARE @pStyleCosting_StyleCostingCustomField3 INT
DECLARE @pStyleCosting_StyleCostingCustomField4 INT
DECLARE @pStyleCosting_StyleCostingCustomField6 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField7 DECIMAL(18,5)
DECLARE @pStyleCosting_StyleCostingCustomField8 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField9 DECIMAL(18,5)
DECLARE @pStyleCosting_StyleCostingCustomField10 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField11 DECIMAL(18,5)
DECLARE @pStyleCosting_StyleCostingCustomField12 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField13 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField14 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField15 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField16 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField17 DECIMAL(18,5)
DECLARE @pStyleCosting_StyleCostingCustomField18 DECIMAL(18,5)
DECLARE @pStyleCosting_StyleCostingCustomField19 INT
DECLARE @pStyleCosting_StyleCostingCustomField20 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField21 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField22 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField23 DECIMAL(18,5)

DECLARE @pStyleCosting_BOMCost DECIMAL(18,3)
DECLARE @pStyleCosting_BOLCost DECIMAL(18,3)
DECLARE @pStyleCosting_AdditionalCost DECIMAL(18,3)

DECLARE @pStyleCosting_StyleCostingCustomField36 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField37 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField38 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField39 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField40 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField41 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField42 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField43 DECIMAL(18,3)
DECLARE @pStyleCosting_StyleCostingCustomField44 DECIMAL(18,3)


/**********************************************************/
/*Get some initial data for field pulls for calculations. */
/**********************************************************/
/*Get the 'StyleId' and the 'StyleSeasonYearId', in case the 'StyleSeasonYearId' wasn't passed in the parameters.*/
SELECT @StyleId = StyleId
 ,@StyleSeasonYearId = StyleSeasonYearId
FROM pStyleCosting
WHERE StyleCostingId = @StyleCostingId


/*Get the 'StyleCostingHeaderId'.*/
SELECT @pStyleCostingHeader_StyleCostingHeaderId = StyleCostingHeaderId
FROM pStyleCostingHeader
WHERE StyleId = @StyleId
 AND StyleSeasonYearId = @StyleSeasonYearId
 
 
 
 
 /* UPDATE all related costing scenarios */

DECLARE @StyleCostingScenarioItemID UNIQUEIDENTIFIER

DECLARE cursor_CostingScenarios CURSOR FOR 
SELECT StytleCostingScenarioItemsID FROM pStyleCostingScenarioItems WITH (NOLOCK) WHERE StyleCostingID = @StyleCostingId
OPEN cursor_CostingScenarios
FETCH NEXT FROM cursor_CostingScenarios INTO @StyleCostingScenarioItemID  
  
WHILE @@FETCH_STATUS = 0   
BEGIN
 

	-- calc BOMCost, BOLCost, AdditionalCost
	SELECT @pStyleCosting_BOMCost = SUM(MaterialCost) 
	FROM pStyleCostingBOM 
	WHERE pStyleCostingBOM.StytleCostingScenarioItemsID = @StyleCostingScenarioItemId

	SELECT @pStyleCosting_BOLCost = SUM(OperationCost) 
	FROM pStyleCostingBOL
	WHERE pStyleCostingBOL.StytleCostingScenarioItemsID = @StyleCostingScenarioItemId

	SELECT @pStyleCosting_AdditionalCost = SUM(AdditionalItemCost) 
	FROM pstyleCostingAdditionalItems
	WHERE pstyleCostingAdditionalItems.StytleCostingScenarioItemsID = @StyleCostingScenarioItemId

	--pStyleCosting
	SELECT @pStyleCosting_StyleCostingTypeId = StyleCostingTypeId
	 ,@pStyleCosting_StyleCostingCustomField3 = ISNULL(StyleCostingCustomField3, 0)   --Wholesale UNITS
	 ,@pStyleCosting_StyleCostingCustomField4 = ISNULL(StyleCostingCustomField4, 0)   --Retail UNITS
	 ,@pStyleCosting_StyleCostingCustomField7 = ISNULL(StyleCostingCustomField7, 0)   --Duty %
	 ,@pStyleCosting_StyleCostingCustomField9 = ISNULL(StyleCostingCustomField9, 0)   --Commission %
	 ,@pStyleCosting_StyleCostingCustomField11 = ISNULL(StyleCostingCustomField11, 0) --Agent %
	 ,@pStyleCosting_StyleCostingCustomField13 = ISNULL(StyleCostingCustomField13, 0) --Freight
	 ,@pStyleCosting_StyleCostingCustomField15 = ISNULL(StyleCostingCustomField15, 0) --Wholesale / Unit
	 ,@pStyleCosting_StyleCostingCustomField16 = ISNULL(StyleCostingCustomField16, 0) --Retail / Unit
	FROM pStyleCostingScenarioItems
	WHERE StytleCostingScenarioItemsID = @StyleCostingScenarioItemId


	/****************/
	/*Calculations. */
	/****************/

	/*pStyleCosting.StyleCostingCustomField6 (First Cost)*/
	SET @pStyleCosting_StyleCostingCustomField6 = ISNULL(@pStyleCosting_BOMCost,0) + ISNULL(@pStyleCosting_BOLCost,0) + ISNULL(@pStyleCosting_AdditionalCost,0)

	/*pStyleCosting.StyleCostingCustomField8 (Duty $)*/
	SET @pStyleCosting_StyleCostingCustomField8 = @pStyleCosting_StyleCostingCustomField6 * @pStyleCosting_StyleCostingCustomField7

	/*pStyleCosting.StyleCostingCustomField10 (Commission $)*/
	SET @pStyleCosting_StyleCostingCustomField10 = @pStyleCosting_StyleCostingCustomField6 * @pStyleCosting_StyleCostingCustomField9

	/*pStyleCosting.StyleCostingCustomField12 (AGENT $)*/
	SET @pStyleCosting_StyleCostingCustomField12 = @pStyleCosting_StyleCostingCustomField6 * @pStyleCosting_StyleCostingCustomField11

	/*pStyleCosting.StyleCostingCustomField14 (LDP $)*/
	SET @pStyleCosting_StyleCostingCustomField14 = @pStyleCosting_StyleCostingCustomField6 + @pStyleCosting_StyleCostingCustomField8 + @pStyleCosting_StyleCostingCustomField10 + @pStyleCosting_StyleCostingCustomField12 + @pStyleCosting_StyleCostingCustomField13

	/*pStyleCosting.StyleCostingCustomField19 (PROPOSED UNITS)*/
	SET @pStyleCosting_StyleCostingCustomField19 = @pStyleCosting_StyleCostingCustomField3 + @pStyleCosting_StyleCostingCustomField4

	/*pStyleCosting.StyleCostingCustomField20 (COST / LDP Extended)*/
	SET @pStyleCosting_StyleCostingCustomField20 = @pStyleCosting_StyleCostingCustomField14 * @pStyleCosting_StyleCostingCustomField19

	/*pStyleCosting.StyleCostingCustomField21 (Wholesale Extended)*/
	SET @pStyleCosting_StyleCostingCustomField21 = @pStyleCosting_StyleCostingCustomField15 * @pStyleCosting_StyleCostingCustomField3

	/*pStyleCosting.StyleCostingCustomField22 (COST / LDP Extended)*/
	SET @pStyleCosting_StyleCostingCustomField22 = @pStyleCosting_StyleCostingCustomField16 * @pStyleCosting_StyleCostingCustomField4

	/*pStyleCosting.StyleCostingCustomField17 (Wholesale Mark Up %)*/
	IF (@pStyleCosting_StyleCostingCustomField21 = 0 OR @pStyleCosting_StyleCostingCustomField21 IS NULL) OR (@pStyleCosting_StyleCostingCustomField15 = 0 OR @pStyleCosting_StyleCostingCustomField15 IS NULL)
		SET @pStyleCosting_StyleCostingCustomField17 = 0
	ELSE
		SET @pStyleCosting_StyleCostingCustomField17 = (@pStyleCosting_StyleCostingCustomField15 - @pStyleCosting_StyleCostingCustomField14) / @pStyleCosting_StyleCostingCustomField15

	/*pStyleCosting.StyleCostingCustomField18 (Retail Mark Up %)*/
	IF (@pStyleCosting_StyleCostingCustomField22 = 0 OR @pStyleCosting_StyleCostingCustomField22 IS NULL) OR (@pStyleCosting_StyleCostingCustomField16 = 0 OR @pStyleCosting_StyleCostingCustomField16 IS NULL)
		SET @pStyleCosting_StyleCostingCustomField18 = 0
	ELSE
		SET @pStyleCosting_StyleCostingCustomField18 = (@pStyleCosting_StyleCostingCustomField16 - @pStyleCosting_StyleCostingCustomField14) / @pStyleCosting_StyleCostingCustomField16

	/*pStyleCosting.StyleCostingCustomField36 (Wholesale Margin Unit)*/
	SET @pStyleCosting_StyleCostingCustomField36 = @pStyleCosting_StyleCostingCustomField15 - @pStyleCosting_StyleCostingCustomField14

	/*pStyleCosting.StyleCostingCustomField37 (Retail Margin Unit)*/
	SET @pStyleCosting_StyleCostingCustomField37 = @pStyleCosting_StyleCostingCustomField16 - @pStyleCosting_StyleCostingCustomField14

	/*pStyleCosting.StyleCostingCustomField38 (Wholesale Margin Extended)*/
	SET @pStyleCosting_StyleCostingCustomField38 = @pStyleCosting_StyleCostingCustomField21 - (@pStyleCosting_StyleCostingCustomField14 * @pStyleCosting_StyleCostingCustomField3)

	/*pStyleCosting.StyleCostingCustomField39 (Retail Margin Extended)*/
	SET @pStyleCosting_StyleCostingCustomField39 = @pStyleCosting_StyleCostingCustomField22 - (@pStyleCosting_StyleCostingCustomField14 * @pStyleCosting_StyleCostingCustomField4)

	/*pStyleCosting.StyleCostingCustomField40 (Total Sales $ Extended)*/
	SET @pStyleCosting_StyleCostingCustomField40 = @pStyleCosting_StyleCostingCustomField21 + @pStyleCosting_StyleCostingCustomField22

	/*pStyleCosting.StyleCostingCustomField41 (Total Margin $ Extended)*/
	SET @pStyleCosting_StyleCostingCustomField41 = @pStyleCosting_StyleCostingCustomField38 + @pStyleCosting_StyleCostingCustomField39

	/*pStyleCosting.StyleCostingCustomField42 (Weighted Price/Unit)*/
	IF @pStyleCosting_StyleCostingCustomField19 = 0 OR @pStyleCosting_StyleCostingCustomField19 IS NULL 
		SET @pStyleCosting_StyleCostingCustomField42 = 0
	ELSE
		SET @pStyleCosting_StyleCostingCustomField42 = @pStyleCosting_StyleCostingCustomField40 / @pStyleCosting_StyleCostingCustomField19

	/*pStyleCosting.StyleCostingCustomField43 (Weighted Margin Unit)*/
	IF @pStyleCosting_StyleCostingCustomField19 = 0 OR @pStyleCosting_StyleCostingCustomField19 IS NULL 
		SET @pStyleCosting_StyleCostingCustomField43 = 0
	ELSE
		SET @pStyleCosting_StyleCostingCustomField43 = @pStyleCosting_StyleCostingCustomField41 / @pStyleCosting_StyleCostingCustomField19

	/*pStyleCosting.StyleCostingCustomField44 (Weighted Mark Up %)*/
	IF @pStyleCosting_StyleCostingCustomField42 = 0 OR @pStyleCosting_StyleCostingCustomField42 IS NULL 
		SET @pStyleCosting_StyleCostingCustomField44 = 0
	ELSE
		SET @pStyleCosting_StyleCostingCustomField44 = @pStyleCosting_StyleCostingCustomField43 / @pStyleCosting_StyleCostingCustomField42


	/**********/
	/*Update. */
	/**********/
	UPDATE pStyleCostingScenarioItems
	SET StyleCostingCustomField6 = @pStyleCosting_StyleCostingCustomField6
	 ,StyleCostingCustomField8 = @pStyleCosting_StyleCostingCustomField8
	 ,StyleCostingCustomField10 = @pStyleCosting_StyleCostingCustomField10
	 ,StyleCostingCustomField12 = @pStyleCosting_StyleCostingCustomField12
	 ,StyleCostingCustomField14 = @pStyleCosting_StyleCostingCustomField14
	 ,StyleCostingCustomField17 = @pStyleCosting_StyleCostingCustomField17
	 ,StyleCostingCustomField18 = @pStyleCosting_StyleCostingCustomField18
	 ,StyleCostingCustomField19 = @pStyleCosting_StyleCostingCustomField19
	 ,StyleCostingCustomField20 = @pStyleCosting_StyleCostingCustomField20
	 ,StyleCostingCustomField21 = @pStyleCosting_StyleCostingCustomField21
	 ,StyleCostingCustomField22 = @pStyleCosting_StyleCostingCustomField22
	 ,StyleCostingCustomField36 = @pStyleCosting_StyleCostingCustomField36
	 ,StyleCostingCustomField37 = @pStyleCosting_StyleCostingCustomField37
	 ,StyleCostingCustomField38 = @pStyleCosting_StyleCostingCustomField38
	 ,StyleCostingCustomField39 = @pStyleCosting_StyleCostingCustomField39
	 ,StyleCostingCustomField40 = @pStyleCosting_StyleCostingCustomField40
	 ,StyleCostingCustomField41 = @pStyleCosting_StyleCostingCustomField41
	 ,StyleCostingCustomField42 = @pStyleCosting_StyleCostingCustomField42
	 ,StyleCostingCustomField43 = @pStyleCosting_StyleCostingCustomField43
	 ,StyleCostingCustomField44 = @pStyleCosting_StyleCostingCustomField44
	WHERE StytleCostingScenarioItemsID = @StyleCostingScenarioItemId


 FETCH NEXT FROM cursor_CostingScenarios INTO @StyleCostingScenarioItemID 
 
END   
  
CLOSE cursor_CostingScenarios  
DEALLOCATE cursor_CostingScenarios  

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '06244', GetDate())
GO
