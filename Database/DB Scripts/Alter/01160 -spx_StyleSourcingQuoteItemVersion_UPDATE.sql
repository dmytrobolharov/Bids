

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

		UPDATE pStyleQuoteItemVersion SET 
		StyleQuoteItemNo = pStyleQuoteItem.StyleQuoteItemNo , 
		StyleQuoteItemShare = pStyleQuoteItem.StyleQuoteItemShare,
		StyleQuoteItemStatusId = pStyleQuoteItem.StyleQuoteItemStatusId ,
		StyleQuoteVariationId  = pStyleQuoteItem.StyleQuoteVariationId  ,
		StyleQuoteID = pStyleQuoteItem.StyleQuoteID ,
		StyleQuotaDutyID = pStyleQuoteItem.StyleQuotaDutyID ,
		StyleDevelopmentID  = pStyleQuoteItem.StyleDevelopmentID ,
		StyleID = pStyleQuoteItem.StyleID,
		StyleQuoteTradePartnerID = pStyleQuoteItem.StyleQuoteTradePartnerID ,
		StyleCostingID = pStyleQuoteItem.StyleCostingID ,
		StyleCostingType = pStyleQuoteItem.StyleCostingType,
		StyleCostingFreightTypeID = pStyleQuoteItem.StyleCostingFreightTypeID ,
		TradePartnerID = pStyleQuoteItem.TradePartnerID,
		TradePartnerVendorID = pStyleQuoteItem.TradePartnerVendorID,
		StyleQuoteItemDueDate = pStyleQuoteItem.StyleQuoteItemDueDate ,
		StyleQuoteItemApprovedBy = pStyleQuoteItem.StyleQuoteItemApprovedBy,
		StyleQuoteItemApprovedDate = pStyleQuoteItem.StyleQuoteItemApprovedDate ,
		StyleQuoteItemCustomField1 = pStyleQuoteItem.StyleQuoteItemCustomField1,
		StyleQuoteItemCustomField2 = pStyleQuoteItem.StyleQuoteItemCustomField2,
		StyleQuoteItemCustomField3 = pStyleQuoteItem.StyleQuoteItemCustomField3 ,
		StyleQuoteItemCustomField4 = pStyleQuoteItem.StyleQuoteItemCustomField4,
		StyleQuoteItemCustomField5 = pStyleQuoteItem.StyleQuoteItemCustomField5,
		StyleQuoteItemCustomField6 = pStyleQuoteItem.StyleQuoteItemCustomField6,
		StyleQuoteItemCustomField7 = pStyleQuoteItem.StyleQuoteItemCustomField7,
		StyleQuoteItemCustomField8 = pStyleQuoteItem.StyleQuoteItemCustomField8,
		StyleQuoteItemCustomField9 = pStyleQuoteItem.StyleQuoteItemCustomField9,
		StyleQuoteItemCustomField10 = pStyleQuoteItem.StyleQuoteItemCustomField10,
		StyleQuoteItemCustomField11 = pStyleQuoteItem.StyleQuoteItemCustomField11,
		StyleQuoteItemCustomField12 = pStyleQuoteItem.StyleQuoteItemCustomField12,
		StyleQuoteItemCustomField13 = pStyleQuoteItem.StyleQuoteItemCustomField13,
		StyleQuoteItemCustomField14 = pStyleQuoteItem.StyleQuoteItemCustomField14,
		StyleQuoteItemCustomField15 = pStyleQuoteItem.StyleQuoteItemCustomField15,
		StyleQuoteItemCustomField16 = pStyleQuoteItem.StyleQuoteItemCustomField16,
		StyleQuoteItemCustomField17 = pStyleQuoteItem.StyleQuoteItemCustomField17,
		StyleQuoteItemCustomField18 = pStyleQuoteItem.StyleQuoteItemCustomField18,
		StyleQuoteItemCustomField19 = pStyleQuoteItem.StyleQuoteItemCustomField19,
		StyleQuoteItemCustomField20 = pStyleQuoteItem.StyleQuoteItemCustomField20,
		StyleQuoteItemCustomField21 = pStyleQuoteItem.StyleQuoteItemCustomField21,
		StyleQuoteItemCustomField22 = pStyleQuoteItem.StyleQuoteItemCustomField22,
		StyleQuoteItemCustomField23 = pStyleQuoteItem.StyleQuoteItemCustomField23,
		StyleQuoteItemCustomField24 = pStyleQuoteItem.StyleQuoteItemCustomField24,
		StyleQuoteItemCustomField25 = pStyleQuoteItem.StyleQuoteItemCustomField25,
		StyleQuoteItemCustomField26 = pStyleQuoteItem.StyleQuoteItemCustomField26,
		StyleQuoteItemCustomField27 = pStyleQuoteItem.StyleQuoteItemCustomField27,
		StyleQuoteItemCustomField28 = pStyleQuoteItem.StyleQuoteItemCustomField28,
		StyleQuoteItemCustomField29 = pStyleQuoteItem.StyleQuoteItemCustomField29,
		StyleQuoteItemCustomField30 = pStyleQuoteItem.StyleQuoteItemCustomField30,
		StyleQuoteItemNotes = pStyleQuoteItem.StyleQuoteItemNotes,
		StyleCostingCustomField1 = pStyleQuoteItem.StyleCostingCustomField1,
		StyleCostingCustomField2 = pStyleQuoteItem.StyleCostingCustomField2,
		StyleCostingCustomField3 = pStyleQuoteItem.StyleCostingCustomField3,
		StyleCostingCustomField4 = pStyleQuoteItem.StyleCostingCustomField4,
		StyleCostingCustomField5 = pStyleQuoteItem.StyleCostingCustomField5,
		StyleCostingCustomField6 = pStyleQuoteItem.StyleCostingCustomField6,
		StyleCostingCustomField7 = pStyleQuoteItem.StyleCostingCustomField7,
		StyleCostingCustomField8 = pStyleQuoteItem.StyleCostingCustomField8,
		StyleCostingCustomField9 = pStyleQuoteItem.StyleCostingCustomField9,
		StyleCostingCustomField10 = pStyleQuoteItem.StyleCostingCustomField10,
		StyleCostingCustomField11 = pStyleQuoteItem.StyleCostingCustomField11,
		StyleCostingCustomField12 = pStyleQuoteItem.StyleCostingCustomField12,
		StyleCostingCustomField13 = pStyleQuoteItem.StyleCostingCustomField13,
		StyleCostingCustomField14 = pStyleQuoteItem.StyleCostingCustomField14,
		StyleCostingCustomField15 = pStyleQuoteItem.StyleCostingCustomField15,
		StyleCostingCustomField16 = pStyleQuoteItem.StyleCostingCustomField16,
		StyleCostingCustomField17 = pStyleQuoteItem.StyleCostingCustomField17,
		StyleCostingCustomField18 = pStyleQuoteItem.StyleCostingCustomField18,
		StyleCostingCustomField19 = pStyleQuoteItem.StyleCostingCustomField19,
		StyleCostingCustomField20 = pStyleQuoteItem.StyleCostingCustomField20,
		StyleCostingCustomField21 = pStyleQuoteItem.StyleCostingCustomField21,
		StyleCostingCustomField22 = pStyleQuoteItem.StyleCostingCustomField22,
		StyleCostingCustomField23 = pStyleQuoteItem.StyleCostingCustomField23,
		StyleCostingCustomField24 = pStyleQuoteItem.StyleCostingCustomField24,
		StyleCostingCustomField25 = pStyleQuoteItem.StyleCostingCustomField25,
		StyleCostingCustomField26 = pStyleQuoteItem.StyleCostingCustomField26,
		StyleCostingCustomField27 = pStyleQuoteItem.StyleCostingCustomField27,
		StyleCostingCustomField28 = pStyleQuoteItem.StyleCostingCustomField28,
		StyleCostingCustomField29 = pStyleQuoteItem.StyleCostingCustomField29,
		StyleCostingCustomField30 = pStyleQuoteItem.StyleCostingCustomField30,
		StyleCostingCustomField31 = pStyleQuoteItem.StyleCostingCustomField31,
		StyleCostingCustomField32 = pStyleQuoteItem.StyleCostingCustomField32,
		StyleCostingCustomField33 = pStyleQuoteItem.StyleCostingCustomField33,
		StyleCostingCustomField34 = pStyleQuoteItem.StyleCostingCustomField34,
		StyleCostingCustomField35 = pStyleQuoteItem.StyleCostingCustomField35,
		CUser = pStyleQuoteItem.CUser,
		CDate = pStyleQuoteItem.CDate ,
		MUser = pStyleQuoteItem.MUser,
		MDate = pStyleQuoteItem.MDate,
		QuoteFolderSort = pStyleQuoteItem.QuoteFolderSort ,
		AgentView = pStyleQuoteItem.AgentView ,
		StyleColorID = pStyleQuoteItem.StyleColorID ,
		StyleSourcingID = pStyleQuoteItem.StyleSourcingID
		FROM pStyleQuoteItem WHERE pStyleQuoteItem.StyleQuoteItemID = @StyleQuoteItemID
		AND pStyleQuoteItemVersion.StyleQuoteItemID = @StyleQuoteItemID AND pStyleQuoteItemVersion.Version = @Version 

	END

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01160', GetDate())
GO
	




