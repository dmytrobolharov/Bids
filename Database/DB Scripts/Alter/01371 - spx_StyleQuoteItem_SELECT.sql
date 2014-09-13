IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItem_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleQuoteItem_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleQuoteItem_SELECT](
	@StyleQuoteItemID UNIQUEIDENTIFIER
)
AS

	
	IF (SELECT StyleSeasonYearID
		FROM dbo.pStyleQuoteItem  WITH(NOLOCK) WHERE StyleQuoteItemID = @StyleQuoteItemID ) IS NULL 
	BEGIN 
		SELECT a.StyleQuoteItemID, a.StyleQuoteItemNo, a.StyleQuoteID, a.StyleDevelopmentID, a.StyleQuoteItemApprovedDate,
			a.StyleID, a.StyleQuoteTradePartnerID, a.StyleCostingID, a.StyleCostingType, a.StyleQuoteItemApprovedBy, 
			a.TradePartnerID, a.TradePartnerVendorID, a.StyleQuoteItemCustomField25, a.StyleQuoteItemNotes, a.StyleQuoteItemShare,
			a.StyleQuoteItemStatusId, a.StyleQuoteVariationId, a.StyleCostingFreightTypeID, a.StyleQuoteVariationId, 
			a.CDate, a.MDate, a.CUser, a.MUser,
			b.StyleSeasonYearID
		FROM dbo.pStyleQuoteItem a WITH(NOLOCK)
			LEFT OUTER JOIN dbo.pStyleSourcing b WITH(NOLOCK)  ON a.StyleSourcingID = b.StyleSourcingID 
		WHERE a.StyleQuoteItemID = @StyleQuoteItemID
		
	END 
	ELSE 
	BEGIN

		SELECT StyleQuoteItemID, StyleQuoteItemNo, StyleQuoteID, StyleDevelopmentID, StyleQuoteItemApprovedDate,
			StyleID, StyleQuoteTradePartnerID, StyleCostingID, StyleCostingType, StyleQuoteItemApprovedBy, 
			TradePartnerID, TradePartnerVendorID, StyleQuoteItemCustomField25, StyleQuoteItemNotes, StyleQuoteItemShare,
			StyleQuoteItemStatusId, StyleQuoteVariationId, StyleCostingFreightTypeID, StyleQuoteVariationId, 
			StyleSeasonYearID, CDate, MDate, CUser, MUser
		FROM dbo.pStyleQuoteItem WITH(NOLOCK)
		WHERE StyleQuoteItemID = @StyleQuoteItemID	

	END 
	

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01371', GETDATE())
GO



