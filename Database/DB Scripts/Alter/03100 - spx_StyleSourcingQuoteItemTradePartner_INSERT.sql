IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingQuoteItemTradePartner_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSourcingQuoteItemTradePartner_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Comments:

#01 - Ryan Cabanas - August 19, 2009
	Burberry wants to set the value of 'pStyleQuoteItem.StyleQuoteItemCustomField26'
to 'pStyleCostingHeader.StyleCostingCustomField6'.  At the quote area, that field
currently is 'UK Wholesale'.  At the costing header, this field is currently
'Target Wholesale Price'.

#02 - Clayton Parker - August 25, 2009
	Burberry would like the Wholesale Target Margin(pStyleQuoteItem.StyleQuoteItemCustomField25)
in the quote to pull from the style costings Wholesale Margin at the costing header
(pStyleCostingHeader.StyleCostingCustomField5).

#03 - Oleg Pechenevsky - February 02, 2012
	Have added some fields (StyleSeasonYearID, BOMCost, BOLCost, BOLCurr).

*/


CREATE PROCEDURE [dbo].[spx_StyleSourcingQuoteItemTradePartner_INSERT] (
@StyleQuoteItemID uniqueidentifier,
@StyleQuoteVariationID uniqueidentifier,
@TradePartnerVendorID uniqueidentifier,
@StyleColorID uniqueidentifier,
@StyleSourcingID  uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime)
AS 

DECLARE @StyleQuoteId UNIQUEIDENTIFIER
SELECT @StyleQuoteId = StyleQuoteId FROM pStyleQuoteVariation WHERE StyleQuoteVariationId = @StyleQuoteVariationID  

DECLARE @StyleQuoteDueDate AS datetime
SELECT @StyleQuoteDueDate = StyleQuoteDueDate FROM pStyleQuote WHERE StyleQuoteID = @StyleQuoteId

DECLARE @StyleSeasonYearID AS UNIQUEIDENTIFIER
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleQuoteVariation WHERE StyleQuoteVariationID = @StyleQuoteVariationID

INSERT INTO dbo.pStyleQuoteItem (
		StyleQuoteItemID, StyleQuoteID, StyleQuotaDutyID, StyleQuoteItemStatusId, 
		TradePartnerID, TradePartnerVendorID, StyleCostingID, StyleCostingType, StyleID, 
        StyleDevelopmentID, StyleQuoteVariationId, 
		StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, 
        StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, 
        StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, 
        StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, 
        StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, 
        StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, 
        StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, 
        StyleCostingCustomField34, StyleCostingCustomField35, 
		CUser, CDate, MUser, MDate, StyleCostingFreightTypeID, 
		StyleQuoteItemCustomField1, 
        StyleQuoteItemCustomField2, StyleQuoteItemCustomField3, StyleQuoteItemCustomField4, StyleQuoteItemCustomField5, StyleQuoteItemCustomField6, 
        StyleQuoteItemCustomField7, StyleQuoteItemCustomField8, StyleQuoteItemCustomField9, StyleQuoteItemCustomField10, 
        StyleQuoteItemCustomField11, StyleQuoteItemCustomField12, StyleQuoteItemCustomField13, StyleQuoteItemCustomField14, 
        StyleQuoteItemCustomField15, StyleQuoteItemCustomField16, StyleQuoteItemCustomField17, StyleQuoteItemCustomField18, 
        StyleQuoteItemCustomField19, StyleQuoteItemCustomField20, StyleQuoteItemCustomField21, StyleQuoteItemCustomField22, 
        StyleQuoteItemCustomField23, StyleQuoteItemCustomField24, StyleQuoteItemCustomField25, StyleQuoteItemDueDate,
		StyleColorID, StyleSourcingID, StyleSeasonYearID, BOMCost, BOLCost, BOLCurr 
) 
SELECT  @StyleQuoteItemID, StyleQuoteID, StyleQuotaDutyID, 0, 
		TradePartnerID, @TradePartnerVendorID, StyleCostingID, StyleCostingType, StyleID, 
		StyleDevelopmentID, @StyleQuoteVariationId,
		StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, 
        StyleCostingCustomField5, StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, 
        StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, 
        StyleCostingCustomField15, StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, 
        StyleCostingCustomField20, StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, 
        StyleCostingCustomField25, StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, 
        StyleCostingCustomField30, StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, 
        StyleCostingCustomField35, 
		@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, StyleCostingFreightTypeID, 
		StyleQuoteItemCustomField1, 
        StyleQuoteItemCustomField2, StyleQuoteItemCustomField3, StyleQuoteItemCustomField4, StyleQuoteItemCustomField5, StyleQuoteItemCustomField6, 
        StyleQuoteItemCustomField7, StyleQuoteItemCustomField8, StyleQuoteItemCustomField9, StyleQuoteItemCustomField10, 
        StyleQuoteItemCustomField11, StyleQuoteItemCustomField12, StyleQuoteItemCustomField13, StyleQuoteItemCustomField14, 
        StyleQuoteItemCustomField15, StyleQuoteItemCustomField16, StyleQuoteItemCustomField17, StyleQuoteItemCustomField18, 
        StyleQuoteItemCustomField19, StyleQuoteItemCustomField20, StyleQuoteItemCustomField21, StyleQuoteItemCustomField22, 
        StyleQuoteItemCustomField23, StyleQuoteItemCustomField24, StyleQuoteItemCustomField25, @StyleQuoteDueDate,
		@StyleColorID, @StyleSourcingID, @StyleSeasonYearID, BOMCost, BOLCost, BOLCurr
FROM    pStyleQuoteVariation
WHERE  (StyleQuoteVariationID = @StyleQuoteVariationID)

INSERT INTO pStyleQuoteItemVersion (
	StyleQuoteItemVersionID, Version, StyleQuoteItemID, StyleQuoteItemNo, StyleQuoteItemShare, StyleQuoteItemStatusId, StyleQuoteVariationId, StyleQuoteID, 
	StyleQuotaDutyID, StyleDevelopmentID, StyleID, StyleQuoteTradePartnerID, StyleCostingID, StyleCostingType, StyleCostingFreightTypeID, TradePartnerID, 
	TradePartnerVendorID, StyleQuoteItemDueDate, StyleQuoteItemApprovedBy, StyleQuoteItemApprovedDate, StyleQuoteItemCustomField1, 
	StyleQuoteItemCustomField2, StyleQuoteItemCustomField3, StyleQuoteItemCustomField4, StyleQuoteItemCustomField5, StyleQuoteItemCustomField6, 
	StyleQuoteItemCustomField7, StyleQuoteItemCustomField8, StyleQuoteItemCustomField9, StyleQuoteItemCustomField10, StyleQuoteItemCustomField11, 
	StyleQuoteItemCustomField12, StyleQuoteItemCustomField13, StyleQuoteItemCustomField14, StyleQuoteItemCustomField15, StyleQuoteItemCustomField16, 
	StyleQuoteItemCustomField17, StyleQuoteItemCustomField18, StyleQuoteItemCustomField19, StyleQuoteItemCustomField20, StyleQuoteItemCustomField21, 
	StyleQuoteItemCustomField22, StyleQuoteItemCustomField23, StyleQuoteItemCustomField24, StyleQuoteItemCustomField25, StyleQuoteItemCustomField26, 
	StyleQuoteItemCustomField27, StyleQuoteItemCustomField28, StyleQuoteItemCustomField29, StyleQuoteItemCustomField30, StyleQuoteItemNotes, 
	StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, 
	StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, 
	StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, 
	StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, 
	StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, 
	StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, 
	StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, CUser, CDate, MUser, MDate, QuoteFolderSort, 
	AgentView, StyleColorID, StyleSourcingID)
SELECT NEWID(),1 ,StyleQuoteItemID, StyleQuoteItemNo, StyleQuoteItemShare, StyleQuoteItemStatusId, StyleQuoteVariationId, StyleQuoteID, 
      StyleQuotaDutyID, StyleDevelopmentID, StyleID, StyleQuoteTradePartnerID, StyleCostingID, StyleCostingType, StyleCostingFreightTypeID, TradePartnerID, 
      TradePartnerVendorID, StyleQuoteItemDueDate, StyleQuoteItemApprovedBy, StyleQuoteItemApprovedDate, StyleQuoteItemCustomField1, 
      StyleQuoteItemCustomField2, StyleQuoteItemCustomField3, StyleQuoteItemCustomField4, StyleQuoteItemCustomField5, StyleQuoteItemCustomField6, 
      StyleQuoteItemCustomField7, StyleQuoteItemCustomField8, StyleQuoteItemCustomField9, StyleQuoteItemCustomField10, StyleQuoteItemCustomField11, 
      StyleQuoteItemCustomField12, StyleQuoteItemCustomField13, StyleQuoteItemCustomField14, StyleQuoteItemCustomField15, StyleQuoteItemCustomField16, 
      StyleQuoteItemCustomField17, StyleQuoteItemCustomField18, StyleQuoteItemCustomField19, StyleQuoteItemCustomField20, StyleQuoteItemCustomField21, 
      StyleQuoteItemCustomField22, StyleQuoteItemCustomField23, StyleQuoteItemCustomField24, StyleQuoteItemCustomField25, StyleQuoteItemCustomField26, 
      StyleQuoteItemCustomField27, StyleQuoteItemCustomField28, StyleQuoteItemCustomField29, StyleQuoteItemCustomField30, StyleQuoteItemNotes, 
      StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, 
      StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, 
      StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, 
      StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, 
      StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, 
      StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, 
      StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, CUser, CDate, MUser, MDate, QuoteFolderSort, 
      AgentView, StyleColorID, StyleSourcingID FROM pStyleQuoteItem a
WHERE a.StyleQuoteItemID = @StyleQuoteItemID


--BEGIN

--	UPDATE a
--	SET a.StyleQuoteItemCustomField5 = b.Country
--	FROM pStyleQuoteItem a LEFT OUTER JOIN uTradePartnerVendor b ON
--	a.TradePartnerVendorID = b.TradePartnerVendorID
--	WHERE a.StyleQuoteItemID = @StyleQuoteItemID

--END


----Comment #01
--/*Set the 'UK Wholesale' at the quote to the 'Target Wholesale Price' at costing header.*/
--UPDATE pStyleQuoteItem
--SET pStyleQuoteItem.StyleQuoteItemCustomField26 = pStyleCostingHeader.StyleCostingCustomField6		--Comment #01
--	,pStyleQuoteItem.StyleQuoteItemCustomField25 = pStyleCostingHeader.StyleCostingCustomField5		--Comment #02
--FROM pStyleQuoteItem
--	LEFT OUTER JOIN pStyleCostingHeader ON	pStyleQuoteItem.StyleID = pStyleCostingHeader.StyleID
--WHERE pStyleQuoteItem.StyleQuoteItemID = @StyleQuoteItemID

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03100'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03100', GetDate())

END
GO