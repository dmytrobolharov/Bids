IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlTradePartnerVendorRateItem_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ControlTradePartnerVendorRateItem_Logic_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_ControlTradePartnerVendorRateItem_Logic_UPDATE] (
@TradePartnerVendorRateItemID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200),
@MDate DATETIME
)
AS 

DECLARE 
	@StyleCategoryID UNIQUEIDENTIFIER,		-- pStyleHeader
	@SeasonYearID UNIQUEIDENTIFIER,			-- pStyleSeasonyear 
	@Season NVARCHAR(200),
	@Year NVARCHAR(200),
	@TradePartnerVendorID UNIQUEIDENTIFIER,  -- pStyleSourcing 
	@ExchangeRate NVARCHAR(40),		-- Custom2 in pStyleSourcing 
	@CurrencyType NVARCHAR(200)			-- StyleQuoteItemCustomField6 in pStyleQuoteItem


SELECT @StyleCategoryID = StyleCategoryID, @TradePartnerVendorID = TradePartnerVendorID, 
@ExchangeRate = CAST(ExchangeRate AS NVARCHAR(40)), @CurrencyType = CurrencyType, @SeasonYearID = c.SeasonYearID
FROM dbo.pTradePartnerVendorRateItem a
	INNER JOIN pTradePartnerVendorRate b ON a.TradePartnerVendorRateID =  b.TradePartnerVendorRateID 
	INNER JOIN dbo.pSeasonYear c ON c.Season =  b.Season AND c.Year = b.Year
WHERE a.TradePartnerVendorRateItemID = @TradePartnerVendorRateItemID 


CREATE TABLE #sqi(
	ROWID INT IDENTITY(1,1),
	StyleQuoteItemID UNIQUEIDENTIFIER,
	StyleID UNIQUEIDENTIFIER
)

DECLARE 
	@ROWID INT,
	@TOTAL INT,
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@StyleID  UNIQUEIDENTIFIER,
	@PreviousID UNIQUEIDENTIFIER ,
	@ChangeTransID UNIQUEIDENTIFIER,
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@StyleSeasonYearID UNIQUEIDENTIFIER, 
	@LinePlanID UNIQUEIDENTIFIER,
	@LinePlanRangeID UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID1 UNIQUEIDENTIFIER, 
	@LinePlanAttributeItemID2 UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID3 UNIQUEIDENTIFIER, 
	@LinePlanAttributeItemID4 UNIQUEIDENTIFIER


SELECT TOP 1 @ChangeTransUserID = TeamID FROM dbo.Users WHERE FirstName + ' ' + LastName  =  @MUser
	
INSERT INTO #sqi(StyleQuoteItemID, StyleID )
SELECT DISTINCT a.StyleQuoteItemID, a.StyleID 
FROM dbo.pStyleQuoteItem a
	INNER JOIN pStyleSourcing b ON a.StyleSourcingID =  b.StyleSourcingID
	INNER JOIN dbo.pStyleSeasonYear c ON c.StyleSeasonYearID = b.StyleSeasonYearID
	INNER JOIN dbo.pStyleHeader d ON c.StyleID = d.StyleID 
WHERE c.SeasonYearID = @SeasonYearID
AND b.TradePartnerVendorID = @TradePartnerVendorID
AND b.Custom2 = @ExchangeRate
--AND a.StyleQuoteItemCustomField6 = @CurrencyType
AND d.StyleCategory = @StyleCategoryID

SELECT @ROWID = 1, @PreviousID = NULL
SELECT @TOTAL  = COUNT(*) FROM #sqi 



WHILE  @ROWID <= @TOTAL 
BEGIN
	SELECT @StyleQuoteItemID= StyleQuoteItemID, @StyleID = StyleID 
	FROM #sqi WHERE ROWID = @ROWID
	
	IF @PreviousID IS NULL OR @StyleID <> @PreviousID
	BEGIN
		-- Define new transaction 
		SET @ChangeTransID = NEWID()
		
		--** Insert Transaction 
		INSERT INTO pChangeTransaction( ChangeTransID, ChangeTransPageName , 
			ChangeTransTableID, ChangeTransTablePKID, ChangeTransUserID, ChangeTransDate, ChangeTransTypeID) 
		VALUES( @ChangeTransID, '', 
			'D612FAAE-7ACD-DF11-AF06-005056C00008', @StyleID, @ChangeTransUserID, @MDate, 0 )  --pStyleHeader
	END 

	EXEC spx_StyleQuoteItemLogic_UPDATE 
		@StyleQuoteItemID = @StyleQuoteItemID,
		@ChangeTransID = @ChangeTransID,
		@ChangeTransUserID = @ChangeTransUserID,
		@MUser = @MUser,
		@MDate  = @MDate
	
		 
	SET @PreviousID = @StyleID 
	SET @ROWID = @ROWID + 1 
END 

	
	
-- Get different LinePlans 
CREATE TABLE #lp(
	ROWID INT IDENTITY (1,1),
	StyleSeasonYearID UNIQUEIDENTIFIER, 
	StyleID UNIQUEIDENTIFIER, 
	LinePlanID UNIQUEIDENTIFIER,
	LinePlanRangeID UNIQUEIDENTIFIER,
	LinePlanAttributeItemID1 UNIQUEIDENTIFIER, 
	LinePlanAttributeItemID2 UNIQUEIDENTIFIER,
	LinePlanAttributeItemID3 UNIQUEIDENTIFIER, 
	LinePlanAttributeItemID4 UNIQUEIDENTIFIER
)



INSERT INTO #lp (
	StyleSeasonYearID, StyleID, 
	LinePlanID, LinePlanRangeID,
	LinePlanAttributeItemID1, LinePlanAttributeItemID2, LinePlanAttributeItemID3, LinePlanAttributeItemID4)
SELECT DISTINCT b.StyleSeasonYearID, b.StyleID, 
	d.LinePlanID, d.LinePlanRangeID,
	d.LinePlanAttributeItemID1, d.LinePlanAttributeItemID2, d.LinePlanAttributeItemID3, d.LinePlanAttributeItemID4
FROM #sqi a
	INNER JOIN dbo.pStyleSeasonYear  b ON a.StyleID = b.StyleID
	INNER JOIN pLinePlanItem c ON c.LinePlanItemID = b.LinePlanItemID
	INNER JOIN dbo.pLinePlanRange d ON d.LinePlanRangeID = c.LinePlanRangeID
WHERE b.SeasonYearID = @SeasonYearID


SET @ROWID = 1
SELECT @TOTAL  = COUNT(*) FROM #lp

WHILE  @ROWID <= @TOTAL 
BEGIN
	SELECT @StyleSeasonYearID = StyleSeasonYearID, @StyleID = StyleID, 
	@LinePlanID = LinePlanID, @LinePlanRangeID =LinePlanRangeID,
	@LinePlanAttributeItemID1 = LinePlanAttributeItemID1, @LinePlanAttributeItemID2 = LinePlanAttributeItemID2,
	@LinePlanAttributeItemID3 = LinePlanAttributeItemID3, @LinePlanAttributeItemID4 = LinePlanAttributeItemID4
	FROM #lp WHERE ROWID = @ROWID
	

	EXEC spx_LinePlanBusinessItem_QUEUE 
		@StyleQuoteItemID = NULL,
		@StyleID = @StyleID,
		@LinePlanID = @LinePlanID, 
		@LinePlanRangeID = @LinePlanRangeID,
		@LinePlanAttributeItemID1 = @LinePlanAttributeItemID1, 
		@LinePlanAttributeItemID2 = @LinePlanAttributeItemID2,
		@LinePlanAttributeItemID3 = @LinePlanAttributeItemID3,
		@LinePlanAttributeItemID4 = @LinePlanAttributeItemID4,
		@StyleSeasonYearID = @StyleSeasonYearID,
		@Cmd  = ''


	SET @ROWID = @ROWID +1 
END 


SET @ROWID = 1
SELECT @TOTAL  = COUNT(*) FROM #sqi

WHILE  @ROWID <= @TOTAL 
BEGIN
	SELECT @StyleQuoteItemID= StyleQuoteItemID FROM #sqi WHERE ROWID = @ROWID

	EXEC dbo.spx_StyleSourcingQuoteItemVersion_UPDATE  @StyleQuoteItemID = @StyleQuoteItemID

	SET @ROWID = @ROWID +1 
END 


DROP TABLE #sqi
DROP TABLE #lp


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03145'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03145', GetDate())

END

GO	




