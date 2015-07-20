IF OBJECT_ID(N'[dbo].[spx_StyleColorway_Logic_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleColorway_Logic_INSERT]
GO


/*
'***********************************************************************
' Object name	   : spx_StyleColorway_Logic_INSERT
' Author           : Artemio Gomez
' Created          : 12-11-2009
'
' Last Modified By : Artemio Gomez
' Last Modified On : 12-11-2009
' Description      : Every time a colorway is added to a style, the Sourcing items are created automatically
'
' Copyright        : (c) Yunique Solutions, Inc. All rights reserved.
'***********************************************************************
*/

CREATE PROCEDURE [dbo].[spx_StyleColorway_Logic_INSERT](
	@StyleSeasonYearID UNIQUEIDENTIFIER, 
	@StyleColorID UNIQUEIDENTIFIER, 
	@CUser NVARCHAR(200),
	@CDate DATETIME
)
AS 

  -- update style Seasonal Colorway workflow status
  UPDATE pStyleWorkflow
  SET WorkStatus = 6, ActualStart = @CDate
  WHERE StyleId = (SELECT StyleID FROM pStyleSeasonYear WHERE StyleSeasonYearID = @StyleSeasonYearID) AND 
        WorkFlowID = '40000000-0000-0000-0000-000000000044' AND WorkStatus = 1

--DECLARE @ROW_ID INT
--DECLARE @TOTAL INT
--DECLARE @StyleSourcingID UNIQUEIDENTIFIER 
--DECLARE @TradePartnerID UNIQUEIDENTIFIER
--DECLARE @TradePartnerVendorID UNIQUEIDENTIFIER

--DECLARE @StyleID UNIQUEIDENTIFIER 
--DECLARE @DevelopmentID UNIQUEIDENTIFIER 

--SELECT @StyleID = a.StyleID, @DevelopmentID = a.DevelopmentID 
--FROM pStyleHeader a
--INNER JOIN pStyleColorway b ON a.StyleID = b.StyleID 
--WHERE b.StyleColorID = @StyleColorID


--/**
--** Get Style Sourcings
--**/
--CREATE TABLE #ss(
--ROW_ID INT IDENTITY(1,1),
--StyleSourcingID UNIQUEIDENTIFIER,
--TradePartnerID UNIQUEIDENTIFIER,
--TradePartnerVendorID UNIQUEIDENTIFIER
--)

--INSERT INTO #ss (StyleSourcingID, TradePartnerID, TradePartnerVendorID)
--SELECT StyleSourcingID, TradePartnerID, TradePartnerVendorID FROM pStyleSourcing WHERE StyleSeasonYearID = @StyleSeasonYearID 

--SELECT @TOTAL = COUNT(*) FROM #ss
--SET @ROW_ID = 1 


--WHILE @ROW_ID <= @TOTAL
--BEGIN 
--	SELECT @StyleSourcingID = StyleSourcingID, @TradePartnerID = TradePartnerID, @TradePartnerVendorID = TradePartnerVendorID
--	FROM #ss WHERE ROW_ID = @ROW_ID 

--	/**
--	** Call SP to insert StyleSourcingItems
--	**/
--	EXEC spx_StyleSourcingLogic_INSERT @StyleSourcingID = @StyleSourcingID,
--	@StyleColorID = @StyleColorID, @MDate = @CDate, @MUser = @CUser
	
--	/**
--	** Check for existing costing (Default costing type: FOB)
--	**/
--	CREATE TABLE #ct (
--		StyleCostingID UNIQUEIDENTIFIER, 
--		StyleID UNIQUEIDENTIFIER, 
--		StyleCostingType NVARCHAR(10),
--		Custon NVARCHAR(200), 
--		CustomIcon NVARCHAR(200), 
--		StyleCostingTypeID INT
--	)
		
--	INSERT INTO #ct 
--	EXEC spx_StyleSourcingCostingDropDownLogic_SELECT @TradePartnerID=@TradePartnerID,
--	@StyleID=@StyleID,@StyleSourcingID=@StyleSourcingID
	
--	DECLARE @StyleCostingTypeID INT 
--	DECLARE @StyleCostingID UNIQUEIDENTIFIER
	
--	SELECT @StyleCostingTypeID = StyleCostingTypeID, @StyleCostingID = StyleCostingID FROM #ct WHERE StylecostingType = 'FOB'
--	IF @StyleCostingTypeID IS NULL
--	BEGIN
--		SELECT TOP 1 @StyleCostingTypeID  = StyleCostingTypeID, @StyleCostingID = StyleCostingID FROM #ct 
--	END 
	
--	DROP TABLE #ct
	
	
--	IF @StyleCostingTypeID IS NULL
--		RETURN
	
--	/**
--	** Create the Stylequote item 
--	**/
	
--		-- Create RFQ Item
--		DECLARE @StyleQuoteID UNIQUEIDENTIFIER 
--		EXEC spx_StyleSourcingQuote_CHECK_INSERT @TradePartnerID = @TradePartnerID, @StyleDevelopmentID = @DevelopmentID, 
--		@CreatedDate = @CDate,  @CreatedBy = @CUser, @OUTPUT = 0, @StyleQuoteID = @StyleQuoteID output
				

--		-- Execute StyleQuote Logic Update				
--		EXEC spx_StyleQuoteLogic_UPDATE @StyleQuoteID = @StyleQuoteID, @ModifiedBy = @CUser, @ModifiedDate = @CDate

		
											
--		-- Insert StyleQuote Variation
--		DECLARE @StyleQuoteVariationID UNIQUEIDENTIFIER 
--		EXEC spx_StyleSourcingQuoteVariation_CHECK_INSERT
--		@StyleCostingID = @StyleCostingID ,
--		@StyleID = @StyleID,
--		@StyleQuoteID = @StyleQuoteID,
--		@StyleDevelopmentID = @DevelopmentID,
--		@TradePartnerID = @TradePartnerID,
--		@CreatedBy = @CUser,
--		@CreatedDate = @CDate,
--		@OUTPUT = 0,
--		@StyleQuoteVariationID = @StyleQuoteVariationID OUTPUT
				
--SELECT @StyleQuoteVariationID		 AS StyleQuoteVariationID

--		-- Insert StyleQuoteItem / Color 
--		DECLARE @StyleQuoteItemID UNIQUEIDENTIFIER 
--		SET @StyleQuoteItemID = NEWID()
		
--		EXEC spx_StyleSourcingQuoteItemTradePartner_INSERT
--		@StyleQuoteItemID = @StyleQuoteItemID,
--		@StyleQuoteVariationID = @StyleQuoteVariationID,
--		@TradePartnerVendorID = @TradePartnerVendorID,
--		@StyleColorID = @StyleColorID,
--		@StyleSourcingID = @StyleSourcingID,
--		@CreatedBy = @CUser,
--		@CreatedDate = @CDate
						
--		-- Execute Logic
--		EXEC spx_StyleSourcingQuoteItemNew_Logic_UPDATE @StyleQuoteItemID = @StyleQuoteItemID,
--		@MUser = @CUser,
--		@MDate = @CDate
	
--	SET @ROW_ID = @ROW_ID + 1 
--END 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09304', GetDate())
GO

