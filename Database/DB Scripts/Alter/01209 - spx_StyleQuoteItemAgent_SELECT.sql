

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemAgent_SELECT]    Script Date: 03/01/2011 01:40:53 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemAgent_SELECT]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[spx_StyleQuoteItemAgent_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleQuoteItemAgent_SELECT]
(@StyleId uniqueidentifier,
@TradePartnerID uniqueidentifier,
@AllowStyleSourcing varchar(10))
AS 


IF @AllowStyleSourcing = 'TRUE'
	BEGIN
		SELECT pColorPalette.ColorCode + ' ' + pColorPalette.ColorName AS ColorName, pSeasonYear.Season + ' ' + pSeasonYear.Year AS SeasonYearName, 
			  uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName, pStyleQuoteItem.StyleQuoteItemID, pStyleQuoteItem.StyleQuoteItemNo, 
			  pStyleQuoteItem.StyleQuoteItemShare, pStyleQuoteItem.StyleQuoteItemStatusId, pStyleQuoteItem.StyleQuoteVariationId, 
			  pStyleQuoteItem.StyleQuoteID, pStyleQuoteItem.StyleQuotaDutyID, pStyleQuoteItem.StyleDevelopmentID, pStyleQuoteItem.StyleID, 
			  pStyleQuoteItem.StyleQuoteTradePartnerID, pStyleQuoteItem.StyleCostingID, pStyleQuoteItem.StyleCostingType, 
			  pStyleQuoteItem.StyleCostingFreightTypeID, pStyleQuoteItem.TradePartnerID, pStyleQuoteItem.TradePartnerVendorID, 
			  pStyleQuoteItem.StyleQuoteItemDueDate, pStyleQuoteItem.StyleQuoteItemApprovedBy, pStyleQuoteItem.StyleQuoteItemApprovedDate, 
			  pStyleQuoteItem.StyleQuoteItemCustomField1, pStyleQuoteItem.StyleQuoteItemCustomField2, pStyleQuoteItem.StyleQuoteItemCustomField3, 
			  pStyleQuoteItem.StyleQuoteItemCustomField4, pStyleQuoteItem.StyleQuoteItemCustomField5, pStyleQuoteItem.StyleQuoteItemCustomField6, 
			  pStyleQuoteItem.StyleQuoteItemCustomField7, pStyleQuoteItem.StyleQuoteItemCustomField8, pStyleQuoteItem.StyleQuoteItemCustomField9, 
			  pStyleQuoteItem.StyleQuoteItemCustomField10, pStyleQuoteItem.StyleQuoteItemCustomField11, pStyleQuoteItem.StyleQuoteItemCustomField12, 
			  pStyleQuoteItem.StyleQuoteItemCustomField13, pStyleQuoteItem.StyleQuoteItemCustomField14, pStyleQuoteItem.StyleQuoteItemCustomField15, 
			  pStyleQuoteItem.StyleQuoteItemCustomField16, pStyleQuoteItem.StyleQuoteItemCustomField17, pStyleQuoteItem.StyleQuoteItemCustomField18, 
			  pStyleQuoteItem.StyleQuoteItemCustomField19, pStyleQuoteItem.StyleQuoteItemCustomField20, pStyleQuoteItem.StyleQuoteItemCustomField21, 
			  pStyleQuoteItem.StyleQuoteItemCustomField22, pStyleQuoteItem.StyleQuoteItemCustomField23, pStyleQuoteItem.StyleQuoteItemCustomField24, 
			  pStyleQuoteItem.StyleQuoteItemCustomField25, pStyleQuoteItem.StyleQuoteItemCustomField26, pStyleQuoteItem.StyleQuoteItemCustomField27, 
			  pStyleQuoteItem.StyleQuoteItemCustomField28, pStyleQuoteItem.StyleQuoteItemCustomField29, pStyleQuoteItem.StyleQuoteItemCustomField30, 
			  pStyleQuoteItem.StyleQuoteItemCustomField31, pStyleQuoteItem.StyleQuoteItemNotes, pStyleQuoteItem.StyleCostingCustomField1, 
			  pStyleQuoteItem.StyleCostingCustomField2, pStyleQuoteItem.StyleCostingCustomField3, pStyleQuoteItem.StyleCostingCustomField4, 
			  pStyleQuoteItem.StyleCostingCustomField5, pStyleQuoteItem.StyleCostingCustomField6, pStyleQuoteItem.StyleCostingCustomField7, 
			  pStyleQuoteItem.StyleCostingCustomField8, pStyleQuoteItem.StyleCostingCustomField9, pStyleQuoteItem.StyleCostingCustomField10, 
			  pStyleQuoteItem.StyleCostingCustomField11, pStyleQuoteItem.StyleCostingCustomField12, pStyleQuoteItem.StyleCostingCustomField13, 
			  pStyleQuoteItem.StyleCostingCustomField14, pStyleQuoteItem.StyleCostingCustomField15, pStyleQuoteItem.StyleCostingCustomField16, 
			  pStyleQuoteItem.StyleCostingCustomField17, pStyleQuoteItem.StyleCostingCustomField18, pStyleQuoteItem.StyleCostingCustomField19, 
			  pStyleQuoteItem.StyleCostingCustomField20, pStyleQuoteItem.StyleCostingCustomField21, pStyleQuoteItem.StyleCostingCustomField22, 
			  pStyleQuoteItem.StyleCostingCustomField23, pStyleQuoteItem.StyleCostingCustomField24, pStyleQuoteItem.StyleCostingCustomField25, 
			  pStyleQuoteItem.StyleCostingCustomField26, pStyleQuoteItem.StyleCostingCustomField27, pStyleQuoteItem.StyleCostingCustomField28, 
			  pStyleQuoteItem.StyleCostingCustomField29, pStyleQuoteItem.StyleCostingCustomField30, pStyleQuoteItem.StyleCostingCustomField31, 
			  pStyleQuoteItem.StyleCostingCustomField32, pStyleQuoteItem.StyleCostingCustomField33, pStyleQuoteItem.StyleCostingCustomField34, 
			  pStyleQuoteItem.StyleCostingCustomField35, pStyleQuoteItem.CUser, pStyleQuoteItem.CDate, pStyleQuoteItem.MUser, pStyleQuoteItem.MDate, 
			  pStyleQuoteItem.QuoteFolderSort, pStyleQuoteItem.AgentView, pStyleQuoteItem.StyleColorID, pStyleQuoteItem.StyleSourcingID
		FROM  pStyleSourcing INNER JOIN
			  pStyleQuoteItem ON pStyleSourcing.StyleSourcingID = pStyleQuoteItem.StyleSourcingID INNER JOIN
			  pStyleSeasonYear ON pStyleSourcing.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
			  pSeasonYear ON pStyleSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID INNER JOIN
			  uTradePartner ON pStyleSourcing.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
			  uTradePartnerVendor ON pStyleSourcing.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID LEFT OUTER JOIN
			  pColorPalette INNER JOIN
			  pStyleColorway ON pColorPalette.ColorPaletteID = pStyleColorway.ColorPaletteID ON 
			  pStyleQuoteItem.StyleColorID = pStyleColorway.StyleColorID
		WHERE (pStyleQuoteItem.StyleID = @StyleId) AND (pStyleQuoteItem.TradePartnerID = @TradePartnerID) AND (pStyleQuoteItem.StyleQuoteItemShare = 1)
		ORDER BY uTradePartnerVendor.VendorName		
	END
ELSE
	BEGIN
		SELECT  pSeasonYear.Season + ' ' + pSeasonYear.Year AS SeasonYearName, 'N/A' AS ColorName, pStyleQuoteItem.StyleQuoteItemID, 
              pStyleQuoteItem.StyleQuoteItemNo, pStyleQuoteItem.StyleQuoteItemShare, pStyleQuoteItem.StyleQuoteItemStatusId, 
              pStyleQuoteItem.StyleQuoteVariationId, pStyleQuoteItem.StyleQuoteID, pStyleQuoteItem.StyleQuotaDutyID, pStyleQuoteItem.StyleDevelopmentID, 
              pStyleQuoteItem.StyleID, pStyleQuoteItem.StyleQuoteTradePartnerID, pStyleQuoteItem.StyleCostingID, pStyleQuoteItem.StyleCostingType, 
              pStyleQuoteItem.StyleCostingFreightTypeID, pStyleQuoteItem.TradePartnerID, pStyleQuoteItem.TradePartnerVendorID, 
              pStyleQuoteItem.StyleQuoteItemDueDate, pStyleQuoteItem.StyleQuoteItemApprovedBy, pStyleQuoteItem.StyleQuoteItemApprovedDate, 
              pStyleQuoteItem.StyleQuoteItemCustomField1, pStyleQuoteItem.StyleQuoteItemCustomField2, pStyleQuoteItem.StyleQuoteItemCustomField3, 
              pStyleQuoteItem.StyleQuoteItemCustomField4, pStyleQuoteItem.StyleQuoteItemCustomField5, pStyleQuoteItem.StyleQuoteItemCustomField6, 
              pStyleQuoteItem.StyleQuoteItemCustomField7, pStyleQuoteItem.StyleQuoteItemCustomField8, pStyleQuoteItem.StyleQuoteItemCustomField9, 
              pStyleQuoteItem.StyleQuoteItemCustomField10, pStyleQuoteItem.StyleQuoteItemCustomField11, pStyleQuoteItem.StyleQuoteItemCustomField12, 
              pStyleQuoteItem.StyleQuoteItemCustomField13, pStyleQuoteItem.StyleQuoteItemCustomField14, pStyleQuoteItem.StyleQuoteItemCustomField15, 
              pStyleQuoteItem.StyleQuoteItemCustomField16, pStyleQuoteItem.StyleQuoteItemCustomField17, pStyleQuoteItem.StyleQuoteItemCustomField18, 
              pStyleQuoteItem.StyleQuoteItemCustomField19, pStyleQuoteItem.StyleQuoteItemCustomField20, pStyleQuoteItem.StyleQuoteItemCustomField21, 
              pStyleQuoteItem.StyleQuoteItemCustomField22, pStyleQuoteItem.StyleQuoteItemCustomField23, pStyleQuoteItem.StyleQuoteItemCustomField24, 
              pStyleQuoteItem.StyleQuoteItemCustomField25, pStyleQuoteItem.StyleQuoteItemCustomField26, pStyleQuoteItem.StyleQuoteItemCustomField27, 
              pStyleQuoteItem.StyleQuoteItemCustomField28, pStyleQuoteItem.StyleQuoteItemCustomField29, pStyleQuoteItem.StyleQuoteItemCustomField30, 
              pStyleQuoteItem.StyleQuoteItemCustomField31, pStyleQuoteItem.StyleQuoteItemNotes, pStyleQuoteItem.StyleCostingCustomField1, 
              pStyleQuoteItem.StyleCostingCustomField2, pStyleQuoteItem.StyleCostingCustomField3, pStyleQuoteItem.StyleCostingCustomField4, 
              pStyleQuoteItem.StyleCostingCustomField5, pStyleQuoteItem.StyleCostingCustomField6, pStyleQuoteItem.StyleCostingCustomField7, 
              pStyleQuoteItem.StyleCostingCustomField8, pStyleQuoteItem.StyleCostingCustomField9, pStyleQuoteItem.StyleCostingCustomField10, 
              pStyleQuoteItem.StyleCostingCustomField11, pStyleQuoteItem.StyleCostingCustomField12, pStyleQuoteItem.StyleCostingCustomField13, 
              pStyleQuoteItem.StyleCostingCustomField14, pStyleQuoteItem.StyleCostingCustomField15, pStyleQuoteItem.StyleCostingCustomField16, 
              pStyleQuoteItem.StyleCostingCustomField17, pStyleQuoteItem.StyleCostingCustomField18, pStyleQuoteItem.StyleCostingCustomField19, 
              pStyleQuoteItem.StyleCostingCustomField20, pStyleQuoteItem.StyleCostingCustomField21, pStyleQuoteItem.StyleCostingCustomField22, 
              pStyleQuoteItem.StyleCostingCustomField23, pStyleQuoteItem.StyleCostingCustomField24, pStyleQuoteItem.StyleCostingCustomField25, 
              pStyleQuoteItem.StyleCostingCustomField26, pStyleQuoteItem.StyleCostingCustomField27, pStyleQuoteItem.StyleCostingCustomField28, 
              pStyleQuoteItem.StyleCostingCustomField29, pStyleQuoteItem.StyleCostingCustomField30, pStyleQuoteItem.StyleCostingCustomField31, 
              pStyleQuoteItem.StyleCostingCustomField32, pStyleQuoteItem.StyleCostingCustomField33, pStyleQuoteItem.StyleCostingCustomField34, 
              pStyleQuoteItem.StyleCostingCustomField35, pStyleQuoteItem.CUser, pStyleQuoteItem.CDate, pStyleQuoteItem.MUser, pStyleQuoteItem.MDate, 
              pStyleQuoteItem.QuoteFolderSort, pStyleQuoteItem.AgentView, pStyleQuoteItem.StyleColorID, pStyleQuoteItem.StyleSourcingID, 
              uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName
		FROM  pSeasonYear INNER JOIN
              pStyleSeasonYear ON pSeasonYear.SeasonYearID = pStyleSeasonYear.SeasonYearID INNER JOIN
              pStyleQuoteItem ON pStyleSeasonYear.StyleSeasonYearID = pStyleQuoteItem.StyleSeasonYearID INNER JOIN
              uTradePartner ON pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
              uTradePartnerVendor ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
		WHERE     (pStyleQuoteItem.StyleID = @StyleId) AND (pStyleQuoteItem.TradePartnerID = @TradePartnerID) AND
					(pStyleQuoteItem.StyleQuoteItemShare = 1)
		ORDER BY uTradePartnerVendor.VendorName	
	END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01209', GetDate())
GO
