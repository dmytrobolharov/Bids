

/****** Object:  View [dbo].[vwx_SourcingStyle_Quote_Default_SELECT]    Script Date: 10/13/2012 14:58:53 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SourcingStyle_Quote_Default_SELECT]'))
DROP VIEW [dbo].[vwx_SourcingStyle_Quote_Default_SELECT]
GO


/****** Object:  View [dbo].[vwx_SourcingStyle_Quote_Default_SELECT]    Script Date: 10/13/2012 14:58:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_SourcingStyle_Quote_Default_SELECT]
AS
SELECT DISTINCT TOP (100) PERCENT 
	 '<img src=''../System/Icons/' + dbo.pStyleQuoteItemStatus.CustomIcon + ''' />' AS ImagePath, 
	 dbo.pStyleQuoteItem.StyleQuoteItemID, dbo.pStyleQuoteItem.StyleID, dbo.pStyleQuoteItem.StyleQuoteItemNo, 
	 dbo.pStyleQuoteItem.StyleQuoteItemStatusId, dbo.pStyleQuoteItem.StyleQuoteVariationId, dbo.pStyleQuoteItem.StyleQuoteID, dbo.pStyleQuoteItem.StyleQuotaDutyID, 
	 dbo.pStyleQuoteItem.StyleDevelopmentID, dbo.pStyleQuoteItem.StyleQuoteTradePartnerID, dbo.pStyleQuoteItem.StyleCostingID, 
	 dbo.pStyleQuoteItem.StyleCostingType, dbo.pStyleQuoteItem.StyleCostingFreightTypeID, dbo.pStyleQuoteItem.TradePartnerID, 
	 dbo.pStyleQuoteItem.TradePartnerVendorID, dbo.pStyleQuoteItem.StyleQuoteItemCustomField1, dbo.pStyleQuoteItem.StyleQuoteItemCustomField2, 
	 dbo.pStyleQuoteItem.StyleQuoteItemCustomField3, dbo.pStyleQuoteItem.StyleQuoteItemCustomField4, dbo.pStyleQuoteItem.StyleQuoteItemCustomField5, 
	 dbo.pStyleQuoteItem.StyleQuoteItemCustomField6, dbo.pStyleQuoteItem.StyleQuoteItemCustomField8, dbo.pStyleQuoteItem.StyleQuoteItemCustomField9, 
	 dbo.pStyleQuoteItem.StyleQuoteItemCustomField10, dbo.pStyleQuoteItem.StyleQuoteItemCustomField11, dbo.pStyleQuoteItem.StyleQuoteItemCustomField12, 
	 dbo.pStyleQuoteItem.StyleQuoteItemCustomField13, dbo.pStyleQuoteItem.StyleQuoteItemCustomField14, dbo.pStyleQuoteItem.StyleQuoteItemCustomField15, 
	 dbo.pStyleQuoteItem.StyleQuoteItemCustomField16, dbo.pStyleQuoteItem.StyleQuoteItemCustomField17, dbo.pStyleQuoteItem.StyleQuoteItemCustomField18, 
	 dbo.pStyleQuoteItem.StyleQuoteItemCustomField19, dbo.pStyleQuoteItem.StyleQuoteItemCustomField7, dbo.pStyleQuoteItem.StyleQuoteItemCustomField20, 
	 dbo.pStyleQuoteItem.StyleQuoteItemCustomField21, dbo.pStyleQuoteItem.StyleQuoteItemCustomField22, dbo.pStyleQuoteItem.StyleQuoteItemCustomField23, 
	 dbo.pStyleQuoteItem.StyleQuoteItemCustomField24, dbo.pStyleQuoteItem.StyleQuoteItemCustomField25, dbo.pStyleQuoteItem.StyleQuoteItemCustomField26, 
	 dbo.pStyleQuoteItem.StyleQuoteItemCustomField27, dbo.pStyleQuoteItem.StyleQuoteItemCustomField28, dbo.pStyleQuoteItem.StyleQuoteItemCustomField29, 
	 dbo.pStyleQuoteItem.StyleQuoteItemCustomField30, dbo.pStyleQuoteItem.StyleCostingCustomField1, dbo.pStyleQuoteItem.StyleCostingCustomField2, 
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
	 dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.SizeClass, dbo.pStyleCategory.StyleCategory, dbo.pStyleHeader.MaterialNo, 
	 --dbo.pStyleQuoteItemFreightCost.Margin, dbo.pStyleQuoteItemFreightCost.TotalLandCost,
	  dbo.pStyleHeader.Pc1, dbo.pStyleQuoteItem.StyleQuoteItemDueDate, dbo.pStyleQuoteItem.MDate, 
	 dbo.pStyleQuoteItem.StyleColorID, dbo.pStyleQuoteItem.StyleSourcingID,  pSourcingStyle.SourcingHeaderID,
	 dbo.pStyleQuoteItem.StyleQuoteItemCustomField31, dbo.pStyleQuoteItem.StyleSeasonYearID, dbo.pStyleSeasonYear.SeasonYearID, 
	 dbo.pStyleSeasonYear.StyleSeason + ' ' + dbo.pStyleSeasonYear.StyleYear AS StyleSeasonYear
FROM dbo.pStyleQuoteItem 
	 INNER JOIN dbo.pSourcingHeader ON dbo.pStyleQuoteItem.SourcingHeaderID = dbo.pSourcingHeader.SourcingHeaderID
	 INNER JOIN dbo.pSourcingStyle ON dbo.pStyleQuoteItem.StyleSourcingID = dbo.pSourcingStyle.SourcingStyleID
	 INNER JOIN dbo.pSourcingAgentVendor ON dbo.pStyleQuoteItem.StyleQuoteTradePartnerID = dbo.pSourcingAgentVendor.SourcingTradePartnerID
	 INNER JOIN dbo.pStyleHeader ON dbo.pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID 
	 LEFT OUTER JOIN dbo.pStyleBOMDimension ON dbo.pStyleQuoteItem.StyleColorID = dbo.pStyleBOMDimension.StyleBOMDimensionID
	 LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
	 LEFT OUTER JOIN dbo.pStyleCategory ON dbo.pStyleHeader.StyleCategory = dbo.pStyleCategory.StyleCategoryId
	 LEFT OUTER JOIN dbo.pStyleQuoteItemStatus ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey
	 
--	 LEFT OUTER JOIN dbo.pStyleColorway ON dbo.pStyleQuoteItem.StyleColorID = dbo.pStyleColorway.StyleColorID 
--	 LEFT OUTER JOIN dbo.pStyleQuoteItemFreightCost ON dbo.pStyleQuoteItem.StyleQuoteItemID = dbo.pStyleQuoteItemFreightCost.StyleQuoteItemId 
--	 LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleQuoteItem.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID
--	 LEFT OUTER JOIN dbo.pStyleQuoteItemStatus ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey
--WHERE     (dbo.pStyleQuoteItemFreightCost.FreightCostSelected = 1) OR
--(dbo.pStyleQuoteItemFreightCost.FreightCostSelected IS NULL)
          






GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04169', GetDate())
GO
