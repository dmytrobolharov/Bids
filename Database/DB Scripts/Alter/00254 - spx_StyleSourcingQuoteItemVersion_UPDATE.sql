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
ALTER PROCEDURE [dbo].[spx_StyleSourcingQuoteItemVersion_UPDATE](
@StyleQuoteItemID UNIQUEIDENTIFIER 
)
AS

	DECLARE @Version INT 
	
	SELECT @Version = MAX(Version) FROM pStyleQuoteItemVersion 
	WHERE StyleQuoteItemID = @StyleQuoteItemID

	IF @Version IS NULL 
	BEGIN 
		SET @Version = 1	
		
		INSERT INTO pStyleQuoteItemVersion (Version , StyleQuoteItemID ,  StyleQuoteItemNo, StyleQuoteItemShare , 
		StyleQuoteItemStatusId,  StyleQuoteVariationId, StyleQuoteID , StyleQuotaDutyID ,  StyleDevelopmentID ,  StyleID ,  StyleQuoteTradePartnerID , 
		StyleCostingID, StyleCostingType, StyleCostingFreightTypeID , TradePartnerID ,   TradePartnerVendorID,  
		StyleQuoteItemDueDate,  StyleQuoteItemApprovedBy , StyleQuoteItemApprovedDate, 
		StyleQuoteItemCustomField1, StyleQuoteItemCustomField2, StyleQuoteItemCustomField3, StyleQuoteItemCustomField4, StyleQuoteItemCustomField5,
		StyleQuoteItemCustomField6, StyleQuoteItemCustomField7, StyleQuoteItemCustomField8, StyleQuoteItemCustomField9, StyleQuoteItemCustomField10,
		StyleQuoteItemCustomField11, StyleQuoteItemCustomField12, StyleQuoteItemCustomField13, StyleQuoteItemCustomField14, StyleQuoteItemCustomField15,
		StyleQuoteItemCustomField16, StyleQuoteItemCustomField17, StyleQuoteItemCustomField18, StyleQuoteItemCustomField19, StyleQuoteItemCustomField20,
		StyleQuoteItemCustomField21, StyleQuoteItemCustomField22, StyleQuoteItemCustomField23, StyleQuoteItemCustomField24, StyleQuoteItemCustomField25,
		StyleQuoteItemCustomField26, StyleQuoteItemCustomField27, StyleQuoteItemCustomField28, StyleQuoteItemCustomField29, StyleQuoteItemCustomField30,
		StyleQuoteItemNotes, 
		StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, 
		StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, 
		StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, 
		StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, 
		StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, 
		StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, 
		StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, 
		CUser, CDate, MUser, MDate,  QuoteFolderSort, AgentView, StyleColorID, StyleSourcingID ) 
		SELECT 1, StyleQuoteItemID ,  StyleQuoteItemNo, StyleQuoteItemShare , 
		StyleQuoteItemStatusId,  StyleQuoteVariationId, StyleQuoteID , StyleQuotaDutyID ,  StyleDevelopmentID ,  StyleID ,  StyleQuoteTradePartnerID , 
		StyleCostingID, StyleCostingType, StyleCostingFreightTypeID , TradePartnerID ,   TradePartnerVendorID,  
		StyleQuoteItemDueDate,  StyleQuoteItemApprovedBy , StyleQuoteItemApprovedDate, 
		StyleQuoteItemCustomField1, StyleQuoteItemCustomField2, StyleQuoteItemCustomField3, StyleQuoteItemCustomField4, StyleQuoteItemCustomField5,
		StyleQuoteItemCustomField6, StyleQuoteItemCustomField7, StyleQuoteItemCustomField8, StyleQuoteItemCustomField9, StyleQuoteItemCustomField10,
		StyleQuoteItemCustomField11, StyleQuoteItemCustomField12, StyleQuoteItemCustomField13, StyleQuoteItemCustomField14, StyleQuoteItemCustomField15,
		StyleQuoteItemCustomField16, StyleQuoteItemCustomField17, StyleQuoteItemCustomField18, StyleQuoteItemCustomField19, StyleQuoteItemCustomField20,
		StyleQuoteItemCustomField21, StyleQuoteItemCustomField22, StyleQuoteItemCustomField23, StyleQuoteItemCustomField24, StyleQuoteItemCustomField25,
		StyleQuoteItemCustomField26, StyleQuoteItemCustomField27, StyleQuoteItemCustomField28, StyleQuoteItemCustomField29, StyleQuoteItemCustomField30,
		StyleQuoteItemNotes, 
		StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, 
		StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, 
		StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, 
		StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, 
		StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, 
		StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, 
		StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, 
		CUser, CDate, MUser, MDate,  QuoteFolderSort, AgentView, StyleColorID, StyleSourcingID
		FROM pStyleQuoteItem WHERE  StyleQuoteItemID = @StyleQuoteItemID
	END 
	ELSE
	BEGIN 

		UPDATE pStyleQuoteItemVersion
		SET pStyleQuoteItemVersion.StyleQuoteItemNo = pStyleQuoteItem.StyleQuoteItemNo , 
			pStyleQuoteItemVersion.StyleQuoteItemShare = pStyleQuoteItem.StyleQuoteItemShare,
			pStyleQuoteItemVersion.StyleQuoteItemStatusId = pStyleQuoteItem.StyleQuoteItemStatusId ,
			pStyleQuoteItemVersion.StyleQuoteVariationId  = pStyleQuoteItem.StyleQuoteVariationId  ,
			pStyleQuoteItemVersion.StyleQuoteID = pStyleQuoteItem.StyleQuoteID ,
			pStyleQuoteItemVersion.StyleQuotaDutyID = pStyleQuoteItem.StyleQuotaDutyID ,
			pStyleQuoteItemVersion.StyleDevelopmentID  = pStyleQuoteItem.StyleDevelopmentID ,
			pStyleQuoteItemVersion.StyleID = pStyleQuoteItem.StyleID,
			pStyleQuoteItemVersion.StyleQuoteTradePartnerID = pStyleQuoteItem.StyleQuoteTradePartnerID ,
			pStyleQuoteItemVersion.StyleCostingID = pStyleQuoteItem.StyleCostingID ,
			pStyleQuoteItemVersion.StyleCostingType = pStyleQuoteItem.StyleCostingType,
			pStyleQuoteItemVersion.StyleCostingFreightTypeID = pStyleQuoteItem.StyleCostingFreightTypeID ,
			pStyleQuoteItemVersion.TradePartnerID = pStyleQuoteItem.TradePartnerID,
			pStyleQuoteItemVersion.TradePartnerVendorID = pStyleQuoteItem.TradePartnerVendorID,
			pStyleQuoteItemVersion.StyleQuoteItemDueDate = pStyleQuoteItem.StyleQuoteItemDueDate ,
			pStyleQuoteItemVersion.StyleQuoteItemApprovedBy = pStyleQuoteItem.StyleQuoteItemApprovedBy,
			pStyleQuoteItemVersion.StyleQuoteItemApprovedDate = pStyleQuoteItem.StyleQuoteItemApprovedDate ,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField1 = pStyleQuoteItem.StyleQuoteItemCustomField1,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField2 = pStyleQuoteItem.StyleQuoteItemCustomField2,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField3 = pStyleQuoteItem.StyleQuoteItemCustomField3 ,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField4 = pStyleQuoteItem.StyleQuoteItemCustomField4,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField5 = pStyleQuoteItem.StyleQuoteItemCustomField5,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField6 = pStyleQuoteItem.StyleQuoteItemCustomField6,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField7 = pStyleQuoteItem.StyleQuoteItemCustomField7,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField8 = pStyleQuoteItem.StyleQuoteItemCustomField8,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField9 = pStyleQuoteItem.StyleQuoteItemCustomField9,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField10 = pStyleQuoteItem.StyleQuoteItemCustomField10,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField11 = pStyleQuoteItem.StyleQuoteItemCustomField11,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField12 = pStyleQuoteItem.StyleQuoteItemCustomField12,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField13 = pStyleQuoteItem.StyleQuoteItemCustomField13,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField14 = pStyleQuoteItem.StyleQuoteItemCustomField14,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField15 = pStyleQuoteItem.StyleQuoteItemCustomField15,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField16 = pStyleQuoteItem.StyleQuoteItemCustomField16,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField17 = pStyleQuoteItem.StyleQuoteItemCustomField17,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField18 = pStyleQuoteItem.StyleQuoteItemCustomField18,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField19 = pStyleQuoteItem.StyleQuoteItemCustomField19,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField20 = pStyleQuoteItem.StyleQuoteItemCustomField20,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField21 = pStyleQuoteItem.StyleQuoteItemCustomField21,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField22 = pStyleQuoteItem.StyleQuoteItemCustomField22,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField23 = pStyleQuoteItem.StyleQuoteItemCustomField23,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField24 = pStyleQuoteItem.StyleQuoteItemCustomField24,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField25 = pStyleQuoteItem.StyleQuoteItemCustomField25,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField26 = pStyleQuoteItem.StyleQuoteItemCustomField26,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField27 = pStyleQuoteItem.StyleQuoteItemCustomField27,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField28 = pStyleQuoteItem.StyleQuoteItemCustomField28,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField29 = pStyleQuoteItem.StyleQuoteItemCustomField29,
			pStyleQuoteItemVersion.StyleQuoteItemCustomField30 = pStyleQuoteItem.StyleQuoteItemCustomField30,
			pStyleQuoteItemVersion.StyleQuoteItemNotes = pStyleQuoteItem.StyleQuoteItemNotes,
			pStyleQuoteItemVersion.StyleCostingCustomField1 = pStyleQuoteItem.StyleCostingCustomField1,
			pStyleQuoteItemVersion.StyleCostingCustomField2 = pStyleQuoteItem.StyleCostingCustomField2,
			pStyleQuoteItemVersion.StyleCostingCustomField3 = pStyleQuoteItem.StyleCostingCustomField3,
			pStyleQuoteItemVersion.StyleCostingCustomField4 = pStyleQuoteItem.StyleCostingCustomField4,
			pStyleQuoteItemVersion.StyleCostingCustomField5 = pStyleQuoteItem.StyleCostingCustomField5,
			pStyleQuoteItemVersion.StyleCostingCustomField6 = pStyleQuoteItem.StyleCostingCustomField6,
			pStyleQuoteItemVersion.StyleCostingCustomField7 = pStyleQuoteItem.StyleCostingCustomField7,
			pStyleQuoteItemVersion.StyleCostingCustomField8 = pStyleQuoteItem.StyleCostingCustomField8,
			pStyleQuoteItemVersion.StyleCostingCustomField9 = pStyleQuoteItem.StyleCostingCustomField9,
			pStyleQuoteItemVersion.StyleCostingCustomField10 = pStyleQuoteItem.StyleCostingCustomField10,
			pStyleQuoteItemVersion.StyleCostingCustomField11 = pStyleQuoteItem.StyleCostingCustomField11,
			pStyleQuoteItemVersion.StyleCostingCustomField12 = pStyleQuoteItem.StyleCostingCustomField12,
			pStyleQuoteItemVersion.StyleCostingCustomField13 = pStyleQuoteItem.StyleCostingCustomField13,
			pStyleQuoteItemVersion.StyleCostingCustomField14 = pStyleQuoteItem.StyleCostingCustomField14,
			pStyleQuoteItemVersion.StyleCostingCustomField15 = pStyleQuoteItem.StyleCostingCustomField15,
			pStyleQuoteItemVersion.StyleCostingCustomField16 = pStyleQuoteItem.StyleCostingCustomField16,
			pStyleQuoteItemVersion.StyleCostingCustomField17 = pStyleQuoteItem.StyleCostingCustomField17,
			pStyleQuoteItemVersion.StyleCostingCustomField18 = pStyleQuoteItem.StyleCostingCustomField18,
			pStyleQuoteItemVersion.StyleCostingCustomField19 = pStyleQuoteItem.StyleCostingCustomField19,
			pStyleQuoteItemVersion.StyleCostingCustomField20 = pStyleQuoteItem.StyleCostingCustomField20,
			pStyleQuoteItemVersion.StyleCostingCustomField21 = pStyleQuoteItem.StyleCostingCustomField21,
			pStyleQuoteItemVersion.StyleCostingCustomField22 = pStyleQuoteItem.StyleCostingCustomField22,
			pStyleQuoteItemVersion.StyleCostingCustomField23 = pStyleQuoteItem.StyleCostingCustomField23,
			pStyleQuoteItemVersion.StyleCostingCustomField24 = pStyleQuoteItem.StyleCostingCustomField24,
			pStyleQuoteItemVersion.StyleCostingCustomField25 = pStyleQuoteItem.StyleCostingCustomField25,
			pStyleQuoteItemVersion.StyleCostingCustomField26 = pStyleQuoteItem.StyleCostingCustomField26,
			pStyleQuoteItemVersion.StyleCostingCustomField27 = pStyleQuoteItem.StyleCostingCustomField27,
			pStyleQuoteItemVersion.StyleCostingCustomField28 = pStyleQuoteItem.StyleCostingCustomField28,
			pStyleQuoteItemVersion.StyleCostingCustomField29 = pStyleQuoteItem.StyleCostingCustomField29,
			pStyleQuoteItemVersion.StyleCostingCustomField30 = pStyleQuoteItem.StyleCostingCustomField30,
			pStyleQuoteItemVersion.StyleCostingCustomField31 = pStyleQuoteItem.StyleCostingCustomField31,
			pStyleQuoteItemVersion.StyleCostingCustomField32 = pStyleQuoteItem.StyleCostingCustomField32,
			pStyleQuoteItemVersion.StyleCostingCustomField33 = pStyleQuoteItem.StyleCostingCustomField33,
			pStyleQuoteItemVersion.StyleCostingCustomField34 = pStyleQuoteItem.StyleCostingCustomField34,
			pStyleQuoteItemVersion.StyleCostingCustomField35 = pStyleQuoteItem.StyleCostingCustomField35,
			pStyleQuoteItemVersion.CUser = pStyleQuoteItem.CUser,
			pStyleQuoteItemVersion.CDate = pStyleQuoteItem.CDate ,
			pStyleQuoteItemVersion.MUser = pStyleQuoteItem.MUser,
			pStyleQuoteItemVersion.MDate = pStyleQuoteItem.MDate,
			pStyleQuoteItemVersion.QuoteFolderSort = pStyleQuoteItem.QuoteFolderSort ,
			pStyleQuoteItemVersion.AgentView = pStyleQuoteItem.AgentView ,
			pStyleQuoteItemVersion.StyleColorID = pStyleQuoteItem.StyleColorID ,
			pStyleQuoteItemVersion.StyleSourcingID = pStyleQuoteItem.StyleSourcingID
		FROM pStyleQuoteItem
			INNER JOIN pStyleQuoteItemVersion ON	pStyleQuoteItem.StyleQuoteItemID = pStyleQuoteItemVersion.StyleQuoteItemID
													AND pStyleQuoteItemVersion.Version = @Version
		WHERE pStyleQuoteItem.StyleQuoteItemID = @StyleQuoteItemID

	END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '254', GetDate())
GO