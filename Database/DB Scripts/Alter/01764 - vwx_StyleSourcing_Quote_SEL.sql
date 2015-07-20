-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 19 August 2011                                                                               */
-- * WorkItem#4275                                                                              */
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

/****** Object:  View [dbo].[vwx_StyleSourcing_Quote_SEL]    Script Date: 08/19/2011 13:52:04 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleSourcing_Quote_SEL]'))
DROP VIEW [dbo].[vwx_StyleSourcing_Quote_SEL]
GO

CREATE  VIEW [dbo].[vwx_StyleSourcing_Quote_SEL]
AS
SELECT DISTINCT    a.StyleQuoteItemID, a.StyleQuoteItemNo, a.StyleQuoteItemShare, a.StyleQuoteItemStatusId, a.StyleQuoteVariationId, a.StyleQuoteID, a.StyleQuotaDutyID, 
                      a.StyleDevelopmentID, a.StyleID, a.StyleQuoteTradePartnerID, a.StyleCostingID, a.StyleCostingType, a.StyleCostingFreightTypeID, a.TradePartnerID, 
                      a.TradePartnerVendorID, a.StyleQuoteItemDueDate, a.StyleQuoteItemApprovedBy, a.StyleQuoteItemApprovedDate, a.StyleQuoteItemCustomField1, 
                      a.StyleQuoteItemCustomField2, a.StyleQuoteItemCustomField3, a.StyleQuoteItemCustomField4, a.StyleQuoteItemCustomField5, a.StyleQuoteItemCustomField6, 
                      a.StyleQuoteItemCustomField7, a.StyleQuoteItemCustomField8, a.StyleQuoteItemCustomField9, a.StyleQuoteItemCustomField10, a.StyleQuoteItemCustomField11, 
                      a.StyleQuoteItemCustomField12, a.StyleQuoteItemCustomField13, a.StyleQuoteItemCustomField14, a.StyleQuoteItemCustomField15, a.StyleQuoteItemCustomField16, 
                      a.StyleQuoteItemCustomField17, a.StyleQuoteItemCustomField18, a.StyleQuoteItemCustomField19, a.StyleQuoteItemCustomField20, a.StyleQuoteItemCustomField21, 
                      a.StyleQuoteItemCustomField22, a.StyleQuoteItemCustomField23, a.StyleQuoteItemCustomField24, a.StyleQuoteItemCustomField25, a.StyleQuoteItemCustomField26, 
                      a.StyleQuoteItemCustomField27, a.StyleQuoteItemCustomField28, a.StyleQuoteItemCustomField29, a.StyleQuoteItemCustomField30, a.StyleQuoteItemCustomField31, 
                      a.StyleQuoteItemCustomField32, a.StyleQuoteItemCustomField33, a.StyleQuoteItemCustomField34, a.StyleQuoteItemCustomField35, a.StyleCostingCustomField1, 
                      a.StyleCostingCustomField2, a.StyleCostingCustomField3, a.StyleCostingCustomField4, a.StyleCostingCustomField5, a.StyleCostingCustomField6, 
                      a.StyleCostingCustomField7, a.StyleCostingCustomField8, a.StyleCostingCustomField9, a.StyleCostingCustomField10, a.StyleCostingCustomField11, 
                      a.StyleCostingCustomField12, a.StyleCostingCustomField13, a.StyleCostingCustomField14, a.StyleCostingCustomField15, a.StyleCostingCustomField16, 
                      a.StyleCostingCustomField17, a.StyleCostingCustomField18, a.StyleCostingCustomField19, a.StyleCostingCustomField20, a.StyleCostingCustomField21, 
                      a.StyleCostingCustomField22, a.StyleCostingCustomField23, a.StyleCostingCustomField24, a.StyleCostingCustomField25, a.StyleCostingCustomField26, 
                      a.StyleCostingCustomField27, a.StyleCostingCustomField28, a.StyleCostingCustomField29, a.StyleCostingCustomField30, a.StyleCostingCustomField31, 
                      a.StyleCostingCustomField32, a.StyleCostingCustomField33, a.StyleCostingCustomField34, a.StyleCostingCustomField35, a.CUser, a.CDate, a.MUser, a.MDate, 
                      a.QuoteFolderSort, a.AgentView, a.StyleColorID, a.StyleSourcingID, a.StyleSeasonYearID, b.StyleNo, b.SizeClass, b.MaterialNo, 
                      b.Pc1, d.StyleColorName, y.SeasonYearID, y.StyleSeason + ' ' + y.StyleYear AS StyleSeasonYear,CAST(a.StyleQuoteItemNotes as NVARCHAR) AS 'StyleQuoteItemNotes'
FROM         dbo.pStyleQuoteItemFreightCost AS c RIGHT OUTER JOIN
                      dbo.pStyleQuoteItem AS a ON c.StyleQuoteItemId = a.StyleQuoteItemID INNER JOIN
                      dbo.pStyleHeader AS b ON a.StyleID = b.StyleID LEFT OUTER JOIN
                      dbo.pStyleColorway AS d ON a.StyleColorID = d.StyleColorID LEFT OUTER JOIN
                      dbo.pStyleSourcing AS s ON a.StyleSourcingID = s.StyleSourcingID LEFT OUTER JOIN
                      dbo.pStyleSeasonYear AS y ON s.StyleSeasonYearID = y.StyleSeasonYearID
WHERE     (a.StyleQuoteItemShare = 1)


Go
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01764'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01764', GetDate())
END

