IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingHeaderLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingHeaderLogic_UPDATE]
GO



CREATE PROCEDURE [dbo].[spx_StyleCostingHeaderLogic_UPDATE](
	@StyleID UNIQUEIDENTIFIER
	,@ModifiedBy NVARCHAR(200)
	,@ModifiedDate DATETIME
	,@StyleSeasonYearID UNIQUEIDENTIFIER 
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
DECLARE @StyleCostingCustomField6 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField7 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField8 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField9 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField10 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField11 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField12 DECIMAL(18,4)    
DECLARE @StyleCostingCustomField13 DECIMAL(18,4)
DECLARE @StyleCostingCustomField20 DECIMAL(18,4)
DECLARE @StyleCostingCustomField21 DECIMAL(18,4)
DECLARE @StyleCostingCustomField22 DECIMAL(18,4)

SELECT 
	@StyleCostingHeaderId = StyleCostingHeaderID,
	@StyleCostingCustomField1 = ISNULL(StyleCostingCustomField1,0),
	@StyleCostingCustomField2 = ISNULL(StyleCostingCustomField2,0),
	@StyleCostingCustomField6 = ISNULL(StyleCostingCustomField6,0),
	@StyleCostingCustomField7 = ISNULL(StyleCostingCustomField7,0),
	@StyleCostingCustomField9 = ISNULL(StyleCostingCustomField9,0)

FROM pStyleCostingHeader
WHERE StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID


/************************/    
/****  Calculation  ****/    
/************************/    

--	Projected Units
SET @StyleCostingCustomField8 = @StyleCostingCustomField6 + @StyleCostingCustomField7
	
--	Target Total Cost
SET @StyleCostingCustomField10 = @StyleCostingCustomField1 - (@StyleCostingCustomField1 * @StyleCostingCustomField9)
	
--	Weighted Price/Unit
IF @StyleCostingCustomField8 <> 0
	SET @StyleCostingCustomField11 = ((@StyleCostingCustomField1 * @StyleCostingCustomField6) + (@StyleCostingCustomField2 * @StyleCostingCustomField7)) / @StyleCostingCustomField8
ELSE
	SET @StyleCostingCustomField11 = 0
	
--	Retail Margin
IF @StyleCostingCustomField2 <> 0
	SET @StyleCostingCustomField12 = (@StyleCostingCustomField2 - @StyleCostingCustomField10) / @StyleCostingCustomField2
ELSE
	SET @StyleCostingCustomField12 = 0

--	Weighted Margin
IF @StyleCostingCustomField11 <> 0
	SET @StyleCostingCustomField13 = (@StyleCostingCustomField11 - @StyleCostingCustomField10) / @StyleCostingCustomField11
ELSE
	SET @StyleCostingCustomField13 = 0

-- Weighted, Wholesale and Retail Markup
IF @StyleCostingCustomField10 <> 0
BEGIN
	SET @StyleCostingCustomField20 = (@StyleCostingCustomField11 - @StyleCostingCustomField10) / @StyleCostingCustomField10
	SET @StyleCostingCustomField21 = (@StyleCostingCustomField1 - @StyleCostingCustomField10) / @StyleCostingCustomField10
	SET @StyleCostingCustomField22 = (@StyleCostingCustomField2 - @StyleCostingCustomField10) / @StyleCostingCustomField10
END
ELSE
BEGIN
	SET @StyleCostingCustomField20 = 0
	SET @StyleCostingCustomField21 = 0
	SET @StyleCostingCustomField22 = 0
END


UPDATE pStyleCostingHeader
SET
	StyleCostingCustomField8 = @StyleCostingCustomField8,
	StyleCostingCustomField10 = @StyleCostingCustomField10,
	StyleCostingCustomField11 = @StyleCostingCustomField11,
	StyleCostingCustomField12 = @StyleCostingCustomField12,
	StyleCostingCustomField13 = @StyleCostingCustomField13,
	StyleCostingCustomField20 = @StyleCostingCustomField20,
	StyleCostingCustomField21 = @StyleCostingCustomField21,
	StyleCostingCustomField22 = @StyleCostingCustomField22,
	MUser = @ModifiedBy, MDate = @ModifiedDate

FROM pStyleCostingHeader
WHERE StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID


/* update Whole Price/Unit and Retail Price/Unit in related tables */
UPDATE pStyleCosting 
SET 
	StyleCostingCustomField15 = @StyleCostingCustomField1,
	StyleCostingCustomField16 = @StyleCostingCustomField2
WHERE StyleCostingHeaderId = @StyleCostingHeaderId

UPDATE pStyleCostingScenarioItems
SET 
	StyleCostingCustomField15 = @StyleCostingCustomField1,
	StyleCostingCustomField16 = @StyleCostingCustomField2
WHERE StyleCostingHeaderId = @StyleCostingHeaderId


/* calc converted Whole Price/Unit and Retail Price/Unit */
exec spx_StyleCostingHeaderLogic_CurrencyConvertion_UPDATE @StyleID, @SeasonYearID


/* update Wholesale UNITS, Retail UNITS and PROPOSED UNITS in System costsheet */
UPDATE pStyleCosting 
SET 
	StyleCostingCustomField3 = @StyleCostingCustomField6,
	StyleCostingCustomField4 = @StyleCostingCustomField7,
	StyleCostingCustomField19 = @StyleCostingCustomField6 + @StyleCostingCustomField7
WHERE StyleCostingHeaderId = @StyleCostingHeaderId



END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07061', GetDate())
GO
