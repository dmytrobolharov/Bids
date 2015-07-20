IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingHeaderLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingHeaderLogic_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleCostingHeaderLogic_UPDATE](
	@StyleID UNIQUEIDENTIFIER
	,@ModifiedBy VARCHAR(200)
	,@ModifiedDate DATETIME
	,@StyleSeasonYearID UNIQUEIDENTIFIER 
)

AS 
BEGIN

/************************/    
/*Declare variables. */    
/************************/   

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

SELECT 
	@StyleCostingHeaderId = StyleCostingHeaderID,
	@StyleCostingCustomField1 = StyleCostingCustomField1,
	@StyleCostingCustomField2 = StyleCostingCustomField2,
	@StyleCostingCustomField6 = StyleCostingCustomField6,
	@StyleCostingCustomField7 = StyleCostingCustomField7,
	@StyleCostingCustomField9 = StyleCostingCustomField9

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
	
--	Retail MU%
IF @StyleCostingCustomField2 <> 0
	SET @StyleCostingCustomField12 = (@StyleCostingCustomField2 - @StyleCostingCustomField10) / @StyleCostingCustomField2
ELSE
	SET @StyleCostingCustomField12 = 0

--	Weighted MU%
IF @StyleCostingCustomField11 <> 0
	SET @StyleCostingCustomField13 = (@StyleCostingCustomField11 - @StyleCostingCustomField10) / @StyleCostingCustomField11
ELSE
	SET @StyleCostingCustomField13 = 0


UPDATE pStyleCostingHeader
SET
	StyleCostingCustomField8 = @StyleCostingCustomField8,
	StyleCostingCustomField10 = @StyleCostingCustomField10,
	StyleCostingCustomField11 = @StyleCostingCustomField11,
	StyleCostingCustomField12 = @StyleCostingCustomField12,
	StyleCostingCustomField13 = @StyleCostingCustomField13,
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

	

END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04021', GetDate())
GO
