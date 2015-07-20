-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 22 July 2010                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
ALTER PROCEDURE [dbo].[spx_StyleSourcingQuoteItemTradePartner_INSERT] (
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
		StyleColorID , StyleSourcingID 
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
		@StyleColorID AS StyleColorID, @StyleSourcingID AS StyleSourcingID
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


BEGIN

	UPDATE a
	SET a.StyleQuoteItemCustomField5 = b.Country
	FROM pStyleQuoteItem a LEFT OUTER JOIN uTradePartnerVendor b ON
	a.TradePartnerVendorID = b.TradePartnerVendorID
	WHERE a.StyleQuoteItemID = @StyleQuoteItemID

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '255', GetDate())
GO