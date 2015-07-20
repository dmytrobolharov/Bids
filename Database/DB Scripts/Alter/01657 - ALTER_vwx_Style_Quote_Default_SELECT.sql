-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 21 July 2011                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'vwx_Style_Quote_Default_SELECT') AND type = N'V')
	DROP VIEW vwx_Style_Quote_Default_SELECT
GO


CREATE VIEW vwx_Style_Quote_Default_SELECT
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
	 dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.MaterialNo, dbo.pStyleQuoteItemFreightCost.Margin, 
	 dbo.pStyleQuoteItemFreightCost.TotalLandCost, dbo.pStyleHeader.Pc1, dbo.pStyleQuoteItem.StyleQuoteItemDueDate, dbo.pStyleQuoteItem.MDate, 
	 dbo.pStyleQuoteItem.StyleColorID, dbo.pStyleQuoteItem.StyleSourcingID, dbo.pStyleColorway.StyleColorID AS Expr1, dbo.pStyleColorway.StyleColorName, 
	 dbo.pStyleQuoteItem.StyleQuoteItemCustomField31, dbo.pStyleQuoteItem.StyleSeasonYearID, dbo.pStyleSeasonYear.SeasonYearID, 
	 dbo.pStyleSeasonYear.StyleSeason + ' ' + dbo.pStyleSeasonYear.StyleYear AS StyleSeasonYear
FROM dbo.pStyleQuoteItem 
	 INNER JOIN dbo.pStyleHeader ON dbo.pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID 
	 LEFT OUTER JOIN dbo.pStyleColorway ON dbo.pStyleQuoteItem.StyleColorID = dbo.pStyleColorway.StyleColorID 
	 LEFT OUTER JOIN dbo.pStyleQuoteItemFreightCost ON dbo.pStyleQuoteItem.StyleQuoteItemID = dbo.pStyleQuoteItemFreightCost.StyleQuoteItemId 
	 LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleQuoteItem.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID
	 LEFT OUTER JOIN dbo.pStyleQuoteItemStatus ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES      ('DB_Version', '4.1.0000', '01657', GetDate())
GO
