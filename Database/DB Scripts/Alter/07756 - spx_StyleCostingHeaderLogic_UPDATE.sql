IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingHeaderLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingHeaderLogic_UPDATE]
GO



CREATE PROCEDURE [dbo].[spx_StyleCostingHeaderLogic_UPDATE](
	@StyleID UNIQUEIDENTIFIER
	,@ModifiedBy NVARCHAR(200)
	,@ModifiedDate DATETIME
	,@StyleSeasonYearID UNIQUEIDENTIFIER 
	,@CalcType INT = 1  /* 0 - Fixed Markup, 1 - Fixed Price */
)
AS 
BEGIN

/************************/    
/*Declare variables. */    
/************************/   

DECLARE @SeasonYearID UNIQUEIDENTIFIER
SELECT @SeasonYearID = SeasonYearID FROM pStyleSeasonYear WHERE StyleSeasonYearID = @StyleSeasonYearID

DECLARE @StyleCostingHeaderId UNIQUEIDENTIFIER    
DECLARE @StyleCostingCustomField1 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField2 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField3 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField5 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField6 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField7 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField8 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField9 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField10 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField11 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField12 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField13 DECIMAL(18,4)
DECLARE @StyleCostingCustomField14 DECIMAL(18,4)
DECLARE @StyleCostingCustomField15 DECIMAL(18,4)
DECLARE @StyleCostingCustomField18 DECIMAL(18,4)
DECLARE @StyleCostingCustomField20 DECIMAL(18,4)
DECLARE @StyleCostingCustomField21 DECIMAL(18,4)
DECLARE @StyleCostingCustomField22 DECIMAL(18,4)

SELECT 
	@StyleCostingHeaderId = StyleCostingHeaderID,
	@StyleCostingCustomField1 = ISNULL(StyleCostingCustomField1,0),		-- Wholesale Price / Unit
	@StyleCostingCustomField2 = ISNULL(StyleCostingCustomField2,0),		-- Retail Price / Unit
	@StyleCostingCustomField3 = ISNULL(StyleCostingCustomField3,0),		-- Ecom Price / Unit
	@StyleCostingCustomField6 = ISNULL(StyleCostingCustomField6,0),		-- Wholesale Units
	@StyleCostingCustomField7 = ISNULL(StyleCostingCustomField7,0),		-- Retail Units
	@StyleCostingCustomField5 = ISNULL(StyleCostingCustomField5,0),		-- Ecom Units
--	@StyleCostingCustomField9 = ISNULL(StyleCostingCustomField9,0),		
	@StyleCostingCustomField10 = ISNULL(StyleCostingCustomField10,0),	-- Target Cost / Unit
	@StyleCostingCustomField21 = ISNULL(StyleCostingCustomField21,0),	-- Wholesale Markup %
	@StyleCostingCustomField22 = ISNULL(StyleCostingCustomField22,0),	-- Retail Markup %
	@StyleCostingCustomField14 = ISNULL(StyleCostingCustomField14,0)	-- Ecom Markup %
FROM pStyleCostingHeader
WHERE StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID


/************************/    
/****  Calculation  ****/    
/************************/    

IF @CalcType = 1 -- Fixed Price
BEGIN
	IF @StyleCostingCustomField10 = 0
	BEGIN
		SET @StyleCostingCustomField21 = 0
		SET @StyleCostingCustomField22 = 0
		SET @StyleCostingCustomField14 = 0
	END
	ELSE
	BEGIN
		-- Wholesale Markup % = (([Wholesale Price/Unit]-[Target Cost/Unit])/[Target Cost/Unit])
		SET @StyleCostingCustomField21 = (@StyleCostingCustomField1 - @StyleCostingCustomField10) / @StyleCostingCustomField10
		-- Retail Markup % = (([Retail Price/Unit]-[Target Cost/Unit])/[Target Cost/Unit])
		SET @StyleCostingCustomField22 = (@StyleCostingCustomField2 - @StyleCostingCustomField10) / @StyleCostingCustomField10
		-- Ecom Markup % = (([Ecom Price/Unit]-[Target Cost/Unit])/[Target Cost/Unit])
		SET @StyleCostingCustomField14 = (@StyleCostingCustomField3 - @StyleCostingCustomField10) / @StyleCostingCustomField10
	END
END
ELSE IF @CalcType = 0 -- Fixed Markup
BEGIN
	-- Wholesale Price / Unit = [Target Cost/Unit]*[ Wholesale Markup %] + [Target Cost/Unit]
	SET @StyleCostingCustomField1 = @StyleCostingCustomField10 * @StyleCostingCustomField21 + @StyleCostingCustomField10
	-- Retail Price / Unit = [Target Cost/Unit]*[ Retail Markup %] + [Target Cost/Unit]
	SET @StyleCostingCustomField2 = @StyleCostingCustomField10 * @StyleCostingCustomField22 + @StyleCostingCustomField10
	-- Ecom Price / Unit = [Target Cost/Unit]*[ Ecom Markup %] + [Target Cost/Unit]
	SET @StyleCostingCustomField3 = @StyleCostingCustomField10 * @StyleCostingCustomField14 + @StyleCostingCustomField10
END


--	Wholesale Margin = (([Wholesale Price/Unit]-[Target Cost/Unit])/[ Wholesale Price/Unit])
IF @StyleCostingCustomField1 <> 0
	SET @StyleCostingCustomField9 = (@StyleCostingCustomField1 - @StyleCostingCustomField10) / @StyleCostingCustomField1
ELSE
	SET @StyleCostingCustomField9 = 0

--	Retail Margin = (([Retail Price/Unit]-[Target Cost/Unit])/[ Retail Price/Unit])
IF @StyleCostingCustomField2 <> 0
	SET @StyleCostingCustomField12 = (@StyleCostingCustomField2 - @StyleCostingCustomField10) / @StyleCostingCustomField2
ELSE
	SET @StyleCostingCustomField12 = 0

--	Ecom Margin = (([Ecom Price/Unit]-[Target Cost/Unit])/[ Ecom Price/Unit])
IF @StyleCostingCustomField3 <> 0
	SET @StyleCostingCustomField15 = (@StyleCostingCustomField3 - @StyleCostingCustomField10) / @StyleCostingCustomField3
ELSE
	SET @StyleCostingCustomField15 = 0

--	Total Projected Units = [Wholesale Units]+[Retail Units]+[Ecom Units]
SET @StyleCostingCustomField8 = @StyleCostingCustomField6 + @StyleCostingCustomField7 + @StyleCostingCustomField5
		
--	Target Extended Cost = ([Wholesale Units]+[Retail Units]+[Ecom Units])*[Target Cost / Unit]
SET @StyleCostingCustomField18 = @StyleCostingCustomField8 * @StyleCostingCustomField10


-- Total Revenue = (([Wholesale Price/Unit]*[Wholesale Units])+([Retail Price/Unit]*[RetialUnits])+([Ecom Price/Unit]*[Ecom Units]))
DECLARE @TotalRevenue DECIMAL(18,4)
SET @TotalRevenue = (@StyleCostingCustomField1 * @StyleCostingCustomField6) + (@StyleCostingCustomField2 * @StyleCostingCustomField7) + (@StyleCostingCustomField3 * @StyleCostingCustomField5)

--	Weighted Margin = (([Total Revenue]-[Total Extended Cost])/ [Total Revenue])
IF @TotalRevenue <> 0
	SET @StyleCostingCustomField13 = (@TotalRevenue - @StyleCostingCustomField18) / @TotalRevenue
ELSE
	SET @StyleCostingCustomField13 = 0
	
--	Weighted Markup = (([Total Revenue]-[Total Extended Cost])/ [Total Extended Cost])
IF @StyleCostingCustomField18 <> 0
	SET @StyleCostingCustomField20 = (@TotalRevenue - @StyleCostingCustomField18) / @StyleCostingCustomField18
ELSE
	SET @StyleCostingCustomField20 = 0



IF @CalcType = 1
BEGIN
	UPDATE pStyleCostingHeader
	SET
		StyleCostingCustomField8 = @StyleCostingCustomField8,	-- Total Projected Units
		StyleCostingCustomField9 = @StyleCostingCustomField9,	-- Wholesale Margin
		StyleCostingCustomField12 = @StyleCostingCustomField12,	-- Retail Margin
		StyleCostingCustomField15 = @StyleCostingCustomField15,	-- Ecom Margin
		StyleCostingCustomField18 = @StyleCostingCustomField18,	-- Target Extended Cost
		StyleCostingCustomField21 = @StyleCostingCustomField21,	-- Wholesale Markup %
		StyleCostingCustomField22 = @StyleCostingCustomField22,	-- Retail Markup %
		StyleCostingCustomField14 = @StyleCostingCustomField14,	-- Ecom Markup %
		StyleCostingCustomField13 = @StyleCostingCustomField13, -- Weighted Margin
		StyleCostingCustomField20 = @StyleCostingCustomField20,	-- Weighted Markup
		MUser = @ModifiedBy, MDate = @ModifiedDate
	FROM pStyleCostingHeader
	WHERE StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID
END
ELSE
BEGIN
	UPDATE pStyleCostingHeader
	SET
		StyleCostingCustomField1 = @StyleCostingCustomField1,	-- Wholesale Price / Unit
		StyleCostingCustomField2 = @StyleCostingCustomField2,	-- Retail Price / Unit
		StyleCostingCustomField3 = @StyleCostingCustomField3,	-- Ecom Price / Unit
		StyleCostingCustomField8 = @StyleCostingCustomField8,	-- Total Projected Units
		StyleCostingCustomField9 = @StyleCostingCustomField9,	-- Wholesale Margin
		StyleCostingCustomField12 = @StyleCostingCustomField12,	-- Retail Margin
		StyleCostingCustomField15 = @StyleCostingCustomField15,	-- Ecom Margin
		StyleCostingCustomField18 = @StyleCostingCustomField18,	-- Target Extended Cost
		StyleCostingCustomField13 = @StyleCostingCustomField13, -- Weighted Margin
		StyleCostingCustomField20 = @StyleCostingCustomField20,	-- Weighted Markup
		MUser = @ModifiedBy, MDate = @ModifiedDate
	FROM pStyleCostingHeader
	WHERE StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID
END

/* update Whole Price/Unit, Retail Price/Unit and Ecom Price/Unit in related tables */
UPDATE pStyleCosting 
SET 
	StyleCostingCustomField15 = @StyleCostingCustomField1,
	StyleCostingCustomField16 = @StyleCostingCustomField2,
	StyleCosting_EcomPriceUnit = @StyleCostingCustomField3
WHERE StyleCostingHeaderId = @StyleCostingHeaderId

UPDATE pStyleCostingScenarioItems
SET 
	StyleCostingCustomField15 = @StyleCostingCustomField1,
	StyleCostingCustomField16 = @StyleCostingCustomField2,
	StyleCosting_EcomPriceUnit = @StyleCostingCustomField3
WHERE StyleCostingHeaderId = @StyleCostingHeaderId


/* calc converted Whole Price/Unit and Retail Price/Unit */
exec spx_StyleCostingHeaderLogic_CurrencyConvertion_UPDATE @StyleID, @SeasonYearID


/* update Wholesale UNITS, Retail UNITS, Ecom UNITS and PROPOSED UNITS in System costsheet */
UPDATE pStyleCosting 
SET 
	StyleCostingCustomField3 = @StyleCostingCustomField6,
	StyleCostingCustomField4 = @StyleCostingCustomField7,
	StyleCosting_EcomUnits = @StyleCostingCustomField5,
	StyleCostingCustomField19 = @StyleCostingCustomField6 + @StyleCostingCustomField7 + @StyleCostingCustomField5
WHERE StyleCostingHeaderId = @StyleCostingHeaderId


END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07756', GetDate())
GO
