
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcing_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSourcing_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_StyleSourcing_DELETE]  (
@StyleSourcingID uniqueidentifier 
)
AS


	DECLARE @StyleID UNIQUEIDENTIFIER 
	DECLARE @LinePlanID UNIQUEIDENTIFIER
	DECLARE @LinePlanItemID UNIQUEIDENTIFIER
	DECLARE @LinePlanRangeID UNIQUEIDENTIFIER
	DECLARE @LinePlanAttributeItemID1 UNIQUEIDENTIFIER
	DECLARE @LinePlanAttributeItemID2 UNIQUEIDENTIFIER
	DECLARE @LinePlanAttributeItemID3 UNIQUEIDENTIFIER
	DECLARE @LinePlanAttributeItemID4 UNIQUEIDENTIFIER
	DECLARE @TradePartnerVendorID UNIQUEIDENTIFIER
	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER

	SELECT @StyleID = StyleID  FROM pStyleSourcing WHERE StyleSourcingID = @StyleSourcingID

	--***
	--** Update pStyleSeasonYear / MostLikelyVendor
	--***
	SELECT @TradePartnerVendorID = TradePartnerVendorID, @StyleSeasonYearID = StyleSeasonYearID
	FROM pStyleSourcing WHERE StyleSourcingID = @StyleSourcingID 
	
	DECLARE @MostLikelyVendor UNIQUEIDENTIFIER 
	
	SELECT  @MostLikelyVendor = TradePartnerVendorID  FROM pStyleSeasonYear WHERE StyleSeasonYearID = @StyleSeasonYearID 
	IF @MostLikelyVendor = @TradePartnerVendorID
	BEGIN
		UPDATE pStyleSeasonYear SET TradePartnerVendorID = NULL,  MostLikelyVendor = 0 
		WHERE StyleSeasonYearID = @StyleSeasonYearID 
	END 
	
	
	--***
	--** Delete records
	--***
	DELETE FROM pStyleSourcing WHERE  StyleSourcingId = @StyleSourcingID
	DELETE FROM pStyleSourcingItem  WHERE  StyleSourcingId = @StyleSourcingID
	DELETE FROM pStyleQuoteItem WHERE  StyleSourcingId = @StyleSourcingID


	-- ROLL-UP  LINEPLAN 
	SELECT 
		@LinePlanID = pLinePlanItem.LinePlanID,
		@LinePlanItemID = pLinePlanItem.LinePlanItemID,
		@LinePlanRangeID = pLinePlanItem.LinePlanRangeID,
		@LinePlanAttributeItemID1 = pLinePlanRange.LinePlanAttributeItemID1, 
		@LinePlanAttributeItemID2 = pLinePlanRange.LinePlanAttributeItemID2, 
		@LinePlanAttributeItemID3 = pLinePlanRange.LinePlanAttributeItemID3, 
		@LinePlanAttributeItemID4 = pLinePlanRange.LinePlanAttributeItemID4
	FROM pLinePlanItem INNER JOIN
	  pLinePlanRange ON pLinePlanItem.LinePlanRangeID = pLinePlanRange.LinePlanRangeID
	WHERE pLinePlanItem.StyleID = @StyleID

	IF  @LinePlanID IS NOT NULL AND @LinePlanRangeID IS NOT NULL
	BEGIN

		SET @StyleSeasonYearID  = NULL 
		
		SELECT @StyleSeasonYearID = StyleSeasonYearID 
		FROM pStyleSeasonYear 
		WHERE LinePlanID = @LinePlanID 
		AND LinePlanItemID =  @LinePlanItemID
		AND StyleID = @StyleID 

/*

		exec spx_LinePlanBusinessItemLogic_UPDATE NULL, @StyleID, @LinePlanID, @LinePlanRangeID, 
		@LinePlanAttributeItemID1, @LinePlanAttributeItemID2, @LinePlanAttributeItemID3, @LinePlanAttributeItemID4, @StyleSeasonYearID

		exec spx_LinePlanBusinessItemRollup_INSERT 
		@LinePlanID = @LinePlanID, 
		@LinePlanAttributeItemID1 = @LinePlanAttributeItemID1, 
		@LinePlanAttributeItemID2 = @LinePlanAttributeItemID2, 
		@LinePlanAttributeItemID3 = @LinePlanAttributeItemID3, 
		@LinePlanAttributeItemID4 = @LinePlanAttributeItemID4, 
		@Cmd = 'DELETE', 
		@StyleSeasonYearID = @StyleSeasonYearID
*/

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
		@Cmd  = 'DELETE'


	END 

GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '040', GetDate())
GO









