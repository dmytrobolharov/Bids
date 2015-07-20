/****** Object:  StoredProcedure [dbo].[spx_LinePlanStyleSourcingQuote_INSERT]    Script Date: 03/01/2012 14:34:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanStyleSourcingQuote_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanStyleSourcingQuote_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanStyleSourcingQuote_INSERT]    Script Date: 03/01/2012 14:34:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LinePlanStyleSourcingQuote_INSERT]
	@StyleID UNIQUEIDENTIFIER,
	@StyleColorwayID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- check sourcing
	DECLARE @StyleSourcingID UNIQUEIDENTIFIER = NEWID(),
			@StyleDevelopmentID UNIQUEIDENTIFIER,
			@SeasonYearID UNIQUEIDENTIFIER,
			@TradePartnerVendorID UNIQUEIDENTIFIER,
			@TradePartnerID UNIQUEIDENTIFIER,
			@LinePlanID UNIQUEIDENTIFIER,
			@StyleSeasonYearID UNIQUEIDENTIFIER

	SELECT @StyleDevelopmentID = StyleDevelopmentID FROM pStyleDevelopmentItem WHERE StyleID = @StyleID
	SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleColorwaySeasonYear WHERE StyleColorwayID = @StyleColorwayID
	SELECT @SeasonYearID = SeasonYearID, @LinePlanID = LinePlanID FROM pStyleSeasonYear  WHERE StyleSeasonyearID = @StyleSeasonYearID
	SELECT @TradePartnerVendorID = TradePartnerVendorID, @TradePartnerID = TradePartnerID FROM pLinePlanTradePartnerItem WHERE LinePlanID = @LinePlanID

	UPDATE pStyleSeasonYear SET TradePartnerID = @TradePartnerID, TradePartnerVendorID = @TradePartnerVendorID WHERE StyleSeasonYearID = @StyleSeasonYearID	

	-- insert sourcing
	EXEC spx_StyleSourcing_INSERT @StyleSourcingID = @StyleSourcingID,
		@StyleID = @StyleID,
		@CUser =  @CUser,
		@CDate = @CDate,
		@SeasonYearID = @SeasonYearID,
		@TradePartnerVendorID = @TradePartnerVendorID
		
	SELECT @StyleSourcingID = StyleSourcingID FROM pStyleSourcing 
	WHERE StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID
			AND (TradePartnerVendorID = @TradePartnerVendorID OR TradePartnerVendorID IS NULL)

	UPDATE pStyleSourcing SET TradePartnerVendorID = @TradePartnerVendorID, TradePartnerID = @TradePartnerID, Active = 1
	WHERE StyleSourcingID = @StyleSourcingID

	-- insert colorways to sourcing
	EXEC spx_StyleSourcingLogic_INSERT @StyleSourcingID = @StyleSourcingID,
		 @StyleColorID = @StyleColorwayID,
		 @MUser = @CUser,
		 @MDate = @CDate
		 
	CREATE TABLE #tmpCostingType (
		ROW INT IDENTITY(1, 1),
		StyleCostingID UNIQUEIDENTIFIER NOT NULL,
		StyleID UNIQUEIDENTIFIER NULL,
		StyleCostingType NVARCHAR(50),
		Custom NVARCHAR(200),
		CustomIcon NVARCHAR(200),
		StyleCostingTypeID INT NOT NULL
	)

	INSERT INTO #tmpCostingType(StyleCostingID, StyleID, StyleCostingType, Custom, CustomIcon, StyleCostingTypeID)
	EXEC spx_StyleSourcingCostingDropDownLogic_SELECT 
		@StyleID = @StyleID, @TradePartnerID = @TradePartnerID, @StyleSourcingID = @StyleSourcingID
		
	DECLARE @CURRENT INT = 1,
			@TOTAL INT,
			@StyleQuoteID UNIQUEIDENTIFIER,
			@StyleCostingID UNIQUEIDENTIFIER,
			@StyleQuoteVariationID UNIQUEIDENTIFIER,
			@StyleQuoteItemID UNIQUEIDENTIFIER;
			
	SELECT @TOTAL = COUNT(*) FROM #tmpCostingType

	WHILE @CURRENT <= @TOTAL
	BEGIN
		SELECT @StyleCostingID = StyleCostingID FROM #tmpCostingType WHERE ROW = @CURRENT

		EXEC spx_StyleSourcingQuote_CHECK_INSERT 
			@TradePartnerID =  @TradePartnerID, @StyleDevelopmentID = @StyleDevelopmentID, 
			@CreatedDate = @CDate, @CreatedBy = @CUser, @OUTPUT = 1, @StyleQuoteID = @StyleQuoteID OUTPUT
			
		EXEC spx_StyleQuoteLogic_UPDATE @StyleQuoteID = @StyleQuoteID, @ModifiedBy = @CUser, @ModifiedDate = @CDate
		
		EXEC spx_StyleSourcingQuoteVariation_CHECK_INSERT 
			@StyleCostingID = @StyleCostingID, @StyleID = @StyleID, @StyleQuoteID = @StyleQuoteID,
			@StyleDevelopmentID = @StyleDevelopmentID, @TradePartnerID = @TradePartnerID,
			@CreatedBy = @CUser, @CreatedDate = @CDate, 
			@OUTPUT = 1, @StyleQuoteVariationID = @StyleQuoteVariationID OUTPUT
			
		SET @StyleQuoteItemID = NEWID()
		EXEC spx_StyleSourcingQuoteItemTradePartner_INSERT 
			@StyleQuoteItemID = @StyleQuoteItemID, @StyleQuoteVariationID = @StyleQuoteVariationID,
			@TradePartnerVendorID = @TradePartnerVendorID, @StyleColorID = @StyleColorwayID, @StyleSourcingID = @StyleSourcingID,
			@CreatedBy = @CUser, @CreatedDate = @CDate
			
		EXEC spx_StyleSourcingQuoteItemNew_Logic_UPDATE @StyleQuoteItemID = @StyleQuoteItemID,
			@MUser = @CUser, @MDate = @CDate
			
		SET @CURRENT = @CURRENT + 1
	END

	DROP TABLE #tmpCostingType

END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03159'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03159', GetDate())

END
GO