IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleQuoteItem]'))
DROP VIEW [dbo].[vwx_StyleQuoteItem]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_StyleQuoteItem]
AS
SELECT     dbo.pStyleQuoteItem.StyleQuoteItemID, dbo.pStyleQuoteItem.StyleQuoteItemNo, dbo.pStyleQuoteItem.StyleQuoteItemShare, 
                      dbo.pStyleQuoteItem.StyleQuoteItemStatusId, dbo.pStyleQuoteItem.StyleQuoteVariationId, dbo.pStyleQuoteItem.StyleQuoteID, dbo.pStyleQuoteItem.StyleQuotaDutyID, 
                      dbo.pStyleQuoteItem.StyleDevelopmentID, dbo.pStyleQuoteItem.StyleID, dbo.pStyleQuoteItem.StyleQuoteTradePartnerID, dbo.pStyleQuoteItem.StyleCostingID, 
                      dbo.pStyleQuoteItem.StyleCostingType, dbo.pStyleQuoteItem.StyleCostingFreightTypeID, dbo.pStyleQuoteItem.TradePartnerID, 
                      dbo.pStyleQuoteItem.TradePartnerVendorID, dbo.pStyleQuoteItem.StyleQuoteItemDueDate, dbo.pStyleQuoteItem.StyleQuoteItemApprovedBy, 
                      dbo.pStyleQuoteItem.StyleQuoteItemApprovedDate, dbo.pStyleQuoteItem.StyleQuoteItemCustomField1, dbo.pStyleQuoteItem.StyleQuoteItemCustomField2, 
                      dbo.pStyleQuoteItem.StyleQuoteItemCustomField3, dbo.pStyleQuoteItem.StyleQuoteItemCustomField4, dbo.pStyleQuoteItem.StyleQuoteItemCustomField5, 
                      dbo.pStyleQuoteItem.StyleQuoteItemCustomField6, dbo.pStyleQuoteItem.StyleQuoteItemCustomField7, dbo.pStyleQuoteItem.StyleQuoteItemCustomField8, 
                      dbo.pStyleQuoteItem.StyleQuoteItemCustomField9, dbo.pStyleQuoteItem.StyleQuoteItemCustomField10, dbo.pStyleQuoteItem.StyleQuoteItemCustomField11, 
                      dbo.pStyleQuoteItem.StyleQuoteItemCustomField12, dbo.pStyleQuoteItem.StyleQuoteItemCustomField13, dbo.pStyleQuoteItem.StyleQuoteItemCustomField14, 
                      dbo.pStyleQuoteItem.StyleQuoteItemCustomField15, dbo.pStyleQuoteItem.StyleQuoteItemCustomField16, dbo.pStyleQuoteItem.StyleQuoteItemCustomField17, 
                      dbo.pStyleQuoteItem.StyleQuoteItemCustomField18, dbo.pStyleQuoteItem.StyleQuoteItemCustomField19, dbo.pStyleQuoteItem.StyleQuoteItemCustomField20, 
                      dbo.pStyleQuoteItem.StyleQuoteItemCustomField21, dbo.pStyleQuoteItem.StyleQuoteItemCustomField22, dbo.pStyleQuoteItem.StyleQuoteItemCustomField23, 
                      dbo.pStyleQuoteItem.StyleQuoteItemCustomField24, dbo.pStyleQuoteItem.StyleQuoteItemCustomField25, dbo.pStyleQuoteItem.StyleQuoteItemCustomField26, 
                      dbo.pStyleQuoteItem.StyleQuoteItemCustomField27, dbo.pStyleQuoteItem.StyleQuoteItemCustomField28, dbo.pStyleQuoteItem.StyleQuoteItemCustomField29, 
                      dbo.pStyleQuoteItem.StyleQuoteItemCustomField30, dbo.pStyleQuoteItem.StyleQuoteItemCustomField31, dbo.pStyleQuoteItem.StyleQuoteItemCustomField32, 
                      dbo.pStyleQuoteItem.StyleQuoteItemCustomField33, dbo.pStyleQuoteItem.StyleQuoteItemCustomField34, dbo.pStyleQuoteItem.StyleQuoteItemCustomField35, 
                      dbo.pStyleQuoteItem.StyleQuoteItemNotes, dbo.pStyleQuoteItem.StyleCostingCustomField1, dbo.pStyleQuoteItem.StyleCostingCustomField2, 
                      dbo.pStyleQuoteItem.StyleCostingCustomField3, dbo.pStyleQuoteItem.StyleCostingCustomField4, dbo.pStyleQuoteItem.StyleCostingCustomField5, 
                      dbo.pStyleQuoteItem.StyleCostingCustomField6, dbo.pStyleQuoteItem.StyleCostingCustomField7, dbo.pStyleQuoteItem.StyleCostingCustomField8, 
                      dbo.pStyleQuoteItem.StyleCostingCustomField9, dbo.pStyleQuoteItem.StyleCostingCustomField10, dbo.pStyleQuoteItem.StyleCostingCustomField11, 
                      dbo.pStyleQuoteItem.StyleCostingCustomField12, dbo.pStyleQuoteItem.StyleCostingCustomField13, dbo.pStyleQuoteItem.StyleCostingCustomField14, 
                      dbo.pStyleQuoteItem.StyleCostingCustomField15, dbo.pStyleQuoteItem.StyleCostingCustomField16, dbo.pStyleQuoteItem.StyleCostingCustomField17, 
                      dbo.pStyleQuoteItem.StyleCostingCustomField18, dbo.pStyleQuoteItem.StyleCostingCustomField19, dbo.pStyleQuoteItem.StyleCostingCustomField20, 
                      dbo.pStyleQuoteItem.StyleCostingCustomField21, dbo.pStyleQuoteItem.StyleCostingCustomField22, dbo.pStyleQuoteItem.StyleCostingCustomField23, 
                      dbo.pStyleQuoteItem.StyleCostingCustomField24, dbo.pStyleQuoteItem.StyleCostingCustomField25, dbo.pStyleQuoteItem.StyleCostingCustomField26, 
                      dbo.pStyleQuoteItem.StyleCostingCustomField27, dbo.pStyleQuoteItem.StyleCostingCustomField28, dbo.pStyleQuoteItem.StyleCostingCustomField29, 
                      dbo.pStyleQuoteItem.StyleCostingCustomField30, dbo.pStyleQuoteItem.StyleCostingCustomField31, dbo.pStyleQuoteItem.StyleCostingCustomField32, 
                      dbo.pStyleQuoteItem.StyleCostingCustomField33, dbo.pStyleQuoteItem.StyleCostingCustomField34, dbo.pStyleQuoteItem.StyleCostingCustomField35, 
                      dbo.pStyleQuoteItem.CUser, dbo.pStyleQuoteItem.CDate, dbo.pStyleQuoteItem.MUser, dbo.pStyleQuoteItem.MDate, dbo.pStyleQuoteItem.QuoteFolderSort, 
                      dbo.pStyleQuoteItem.AgentView, dbo.pStyleQuoteItem.StyleColorID, dbo.pStyleQuoteItem.StyleSourcingID, dbo.pStyleQuoteItem.StyleSeasonYearID, 
                      dbo.pStyleQuoteItem.BOMCost, dbo.pStyleQuoteItem.BOLCost, dbo.pStyleQuoteItem.BOLCurr, dbo.pStyleQuoteItem.StyleQuotaVendorDutyID, 
                      dbo.pStyleCostingDuty.DutyCategory
FROM         dbo.pStyleQuoteItem LEFT OUTER JOIN
                      dbo.pStyleCostingDuty ON dbo.pStyleQuoteItem.StyleQuotaVendorDutyID = dbo.pStyleCostingDuty.DutyId

GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02493'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02493', GetDate())
END
GO