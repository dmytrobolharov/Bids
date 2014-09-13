IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCosting_INSERT2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCosting_INSERT2]
GO



CREATE PROCEDURE [dbo].[spx_StyleCosting_INSERT2](
	@StyleCostingId UNIQUEIDENTIFIER 
	,@StyleId UNIQUEIDENTIFIER 
	,@StyleCostingTypeId INT
	,@StyleCostingDate DATETIME
	,@StyleCostingStatus NVARCHAR(200)
	,@CreatedBy NVARCHAR(200)
	,@CreatedDate DATETIME
	,@StyleSeasonYearID UNIQUEIDENTIFIER
	,@BOMWorkflowItemID UNIQUEIDENTIFIER 
	,@BOLWorkflowItemID UNIQUEIDENTIFIER 
)

AS


/************************/
/*Declare variables.	*/
/************************/
--General
DECLARE @Count INT

--pStyleCostingHeader
DECLARE @StyleCostingHeaderId UNIQUEIDENTIFIER
DECLARE @StyleCostingCustomField3 INT
DECLARE @StyleCostingCustomField4 INT
DECLARE @StyleCosting_EcomUnits INT

DECLARE @StyleCostingCustomField15 DECIMAL(18, 5)
DECLARE @StyleCostingCustomField16 DECIMAL(18, 3)
DECLARE @StyleCosting_EcomPriceUnit DECIMAL(18,4)

DECLARE @StyleBOMDimensionId UNIQUEIDENTIFIER
DECLARE @StyleNBOLHeaderId UNIQUEIDENTIFIER

DECLARE @BOMCurrencyType NVARCHAR(5)
DECLARE @BOLCurrencyType NVARCHAR(5)
DECLARE @CostsheetCurrencyType NVARCHAR(5)
DECLARE @ExchangeRateItemID UNIQUEIDENTIFIER
DECLARE @SeasonYearID UNIQUEIDENTIFIER

SELECT @StyleBOMDimensionId = StyleBOMDimensionID FROM pStyleBOMDimension WHERE WorkFlowItemID = @BOMWorkflowItemID
SELECT @StyleNBOLHeaderId = StyleNBOLHeaderID FROM pStyleNBOLHeader WHERE WorkFlowItemID = @BOLWorkflowItemID

SELECT @BOMCurrencyType = sExchangeRateItem.CurrencyType FROM pStyleBOMDimension 
	INNER JOIN sExchangeRateItem ON pStyleBOMDimension.ExchangeRateItemID = sExchangeRateItem.ExchangeRateItemID
WHERE pStyleBOMDimension.WorkFlowItemID = @BOMWorkflowItemID

SELECT @BOLCurrencyType = sExchangeRateItem.CurrencyType FROM pStyleNBOLHeader
	INNER JOIN sExchangeRateItem ON pStyleNBOLHeader.ExchangeRateItemID = sExchangeRateItem.ExchangeRateItemID
WHERE pStyleNBOLHeader.WorkFlowItemID = @BOLWorkflowItemID
	
/****************************************************************/
/*Get some initial pulls of data from the costing header area.	*/
/****************************************************************/
SELECT @StyleCostingHeaderId = StyleCostingHeaderId
	,@StyleCostingCustomField3 = ISNULL(StyleCostingCustomField6, 0)	-- Wholesale Units
	,@StyleCostingCustomField4 = ISNULL(StyleCostingCustomField7, 0)	-- Retail Units
	,@StyleCosting_EcomUnits = ISNULL(StyleCostingCustomField5, 0)		-- Ecom Units
	,@StyleCostingCustomField15 = ISNULL(StyleCostingCustomField1, 0)	-- Wholesale Price / Unit
	,@StyleCostingCustomField16 = ISNULL(StyleCostingCustomField2, 0)	-- Retail Price / Unit
	,@StyleCosting_EcomPriceUnit = ISNULL(StyleCostingCustomField3, 0)	-- Ecom Price / Unit
	,@CostsheetCurrencyType = ISNULL(CurrencyType, '')
FROM pStyleCostingHeader
WHERE StyleID = @StyleID
	AND StyleSeasonYearID = @StyleSeasonYearID

SELECT @SeasonYearID = SeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleId AND StyleSeasonYearID = @StyleSeasonYearID

SELECT @ExchangeRateItemID = ExchangeRateItemID FROM sExchangeRate
	INNER JOIN sExchangeRateItem ON sExchangeRate.ExchangeRateID = sExchangeRateItem.ExchangeRateID
WHERE sExchangeRate.Season = (SELECT Season FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID)
AND sExchangeRate.Year = (SELECT Year FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID)
AND CurrencyType = @CostsheetCurrencyType


/************************************/
/*INSERT the pStyleCosting record 	*/
/************************************/
INSERT INTO pStyleCosting
	(StyleCostingID, StyleID, StyleCostingTypeID, StyleCostingDate, StyleCostingStatus, StyleCostingHeaderId, StyleCostingName,
	CUser, CDate, MUser, MDate, Active, StyleSeasonYearID, StyleBOMDimensionID, StyleNBOLHeaderID,
	StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField15, StyleCostingCustomField16,
	StyleCosting_EcomUnits, StyleCosting_EcomPriceUnit,
	BOMCurrencyType, BOLCurrencyType, ExchangeRateItemID)
VALUES
	(@StyleCostingId, @StyleId, @StyleCostingTypeId, @StyleCostingDate, @StyleCostingStatus, @StyleCostingHeaderId, 'SYSTEM COSTSHEET',
	@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 1, @StyleSeasonYearID, @StyleBOMDimensionId, @StyleNBOLHeaderId, 
	@StyleCostingCustomField3, @StyleCostingCustomField4, @StyleCostingCustomField15, @StyleCostingCustomField16,
	@StyleCosting_EcomUnits, @StyleCosting_EcomPriceUnit,
	@BOMCurrencyType, @BOLCurrencyType, @ExchangeRateItemID)
/************************************/


/*****************************************************/
/*INSERT the pStyleCostingScenarioItems records 	*/
/****************************************************/
DECLARE @CountScenarios INT = 3
DECLARE @i INT = 1

DECLARE @StyleCostingName NVARCHAR(100)

WHILE @i <= @CountScenarios
BEGIN

	DECLARE @StyleCostingScenarioItemsID UNIQUEIDENTIFIER = NEWID()
	
	SET @StyleCostingName = 'COSTSHEET NAME ' + CAST (@i AS NVARCHAR(2))

	INSERT INTO pStyleCostingScenarioItems
		(StytleCostingScenarioItemsID, StyleCostingScenarioNo, StyleCostingName, 
		StyleCostingID, StyleID, StyleCostingTypeID, StyleCostingDate, StyleCostingStatus, StyleCostingHeaderId, 
		CUser, CDate, MUser, MDate, Active, StyleSeasonYearID, StyleBOMDimensionID, StyleNBOLHeaderID, 
		StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField15, StyleCostingCustomField16, 
		StyleCosting_EcomUnits, StyleCosting_EcomPriceUnit,
		ExchangeRateItemID)
	VALUES
		(@StyleCostingScenarioItemsID, @i, @StyleCostingName, 
		@StyleCostingId, @StyleId, @StyleCostingTypeId, @StyleCostingDate, @StyleCostingStatus, @StyleCostingHeaderId, 
		@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 1, @StyleSeasonYearID, @StyleBOMDimensionId, @StyleNBOLHeaderId, 
		@StyleCostingCustomField3, @StyleCostingCustomField4, @StyleCostingCustomField15, @StyleCostingCustomField16,
		@StyleCosting_EcomUnits, @StyleCosting_EcomPriceUnit,
		@ExchangeRateItemID)
	
	-- insert to pstyleCostingBOM records for particular StytleCostingScenario
	IF @BOMWorkflowItemID IS NOT NULL
		EXEC spx_StyleCostingBOM_INSERT
				@StyleCostingScenarioItemsID,
				@StyleId,
				@BOMWorkflowItemID,
				@CreatedBy,
				@CreatedDate

	-- insert to pstyleCostingBOL records for particular StytleCostingScenario
	IF @BOLWorkflowItemID IS NOT NULL
		EXEC spx_StyleCostingBOL_INSERT
				@StyleCostingScenarioItemsID,
				@StyleId,
				@BOLWorkflowItemID,
				@CreatedBy,
				@CreatedDate


	SET @i = @i + 1

END

	IF @BOMWorkflowItemID IS NOT NULL
		EXEC spx_StyleCostingBOM_INSERT
				@StyleCostingId,
				@StyleId,
				@BOMWorkflowItemID,
				@CreatedBy,
				@CreatedDate

	-- insert to pstyleCostingBOL records for particular StytleCostingScenario
	IF @BOLWorkflowItemID IS NOT NULL
		EXEC spx_StyleCostingBOL_INSERT
				@StyleCostingId,
				@StyleId,
				@BOLWorkflowItemID,
				@CreatedBy,
				@CreatedDate
				
	-- set SystemCostsheet 
	UPDATE pStyleCosting SET StyleCostingScenarioItemsId = @StyleCostingId WHERE StyleCostingID = @StyleCostingId
		

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07758', GetDate())
GO
