IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ShareStatus_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ShareStatus_UPDATE]
GO



CREATE PROCEDURE [dbo].[spx_ShareStatus_UPDATE]
(
	@QuoteItemID uniqueidentifier,
	@TradePartnerID uniqueidentifier,
	@IsADD bit,
	@MUser nvarchar(200),
	@MDate datetime
)
AS 

BEGIN

IF @IsADD = 1
	BEGIN 
		IF (SELECT COUNT(*) FROM pStyleQuoteItemShare WHERE StyleQouteItemID = @QuoteItemID AND TradePartnerId = @TradePartnerID) = 0
		INSERT INTO pStyleQuoteItemShare(StyleQouteItemID, TradePartnerId, MUser, MDate) VALUES(@QuoteItemID, @TradePartnerID, @MUser, @MDate)
		
		/* share style for srmOn user */
		DECLARE @StyleID UNIQUEIDENTIFIER,
				@StyleDevelopmentID UNIQUEIDENTIFIER,
				@SourcingTradePartnerID UNIQUEIDENTIFIER,
				@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER,
				@SeasonYearID UNIQUEIDENTIFIER
		SELECT @StyleID = StyleID, @StyleDevelopmentID = StyleDevelopmentID, @SourcingTradePartnerID = StyleQuoteTradePartnerID FROM pStyleQuoteItem WHERE StyleQuoteItemID = @QuoteItemID
		SELECT @TradePartnerRelationshipLevelID = TradePartnerLevelID FROM pSourcingTradePartner WHERE SourcingTradePartnerID = @SourcingTradePartnerID
		SELECT @SeasonYearID = SeasonYearID FROM pStyleQuoteItem
			INNER JOIN pStyleSeasonYear ON pStyleQuoteItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		WHERE StyleQuoteItemID = @QuoteItemID
		
		IF (SELECT COUNT(*)  FROM pStyleTeam WITH (NOLOCK) WHERE  StyleID = @StyleID AND SeasonYearID = @SeasonYearID AND TeamID = @TradePartnerID AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID) = 0
		BEGIN
			INSERT INTO pStyleTeam (TeamID, StyleDevelopmentID, StyleID, TradePartner, RequestStatus, TradePartnerRelationshipLevelID, SeasonYearID)
			VALUES (@TradePartnerID, @StyleDevelopmentID, @StyleID, 1, 0, @TradePartnerRelationshipLevelID, @SeasonYearID)
		END
		
	END
ELSE
	BEGIN
		DELETE FROM pStyleQuoteItemShare WHERE StyleQouteItemID = @QuoteItemID AND TradePartnerId = @TradePartnerID
	END
END

--update share status of quote and commitment
Declare 
@SharedCount integer,
@IsShared integer

SELECT @SharedCount=COUNT(*) FROM pStyleQuoteItemShare WHERE StyleQouteItemID = @QuoteItemID

IF @SharedCount = 0 begin
			SET @IsShared = 0
			end
		else begin
			SET @IsShared = 1
			end
		
			
			
UPDATE pStyleQuoteItem SET StyleQuoteItemShare = @IsShared WHERE StyleQuoteItemID = @QuoteItemID
UPDATE pSourcingCommitmentItem SET StyleQuoteItemShare = @IsShared WHERE StyleQuoteItemID = @QuoteItemID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07603', GetDate())
GO
