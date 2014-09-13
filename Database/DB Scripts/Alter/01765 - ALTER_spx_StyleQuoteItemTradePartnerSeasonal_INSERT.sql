-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 18 August 2011                                                                             */
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemTradePartnerSeasonal_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleQuoteItemTradePartnerSeasonal_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleQuoteItemTradePartnerSeasonal_INSERT] 
(@StyleQuoteItemID uniqueidentifier,
@StyleQuoteVariationID uniqueidentifier,
@StyleID uniqueidentifier,
@SeasonYearID uniqueidentifier,
@TradePartnerVendorID uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime)
AS 


/************************/
/*Declare variables.	*/
/************************/
DECLARE @StyleQuoteId UNIQUEIDENTIFIER
DECLARE @StyleQuoteDueDate DATETIME
DECLARE @StyleCostingTypeID INT
DECLARE @StyleCostingID UNIQUEIDENTIFIER
--DECLARE @StyleID UNIQUEIDENTIFIER
DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
DECLARE @StyleCostingHeaderID UNIQUEIDENTIFIER


/************************/
/*Get initial values.	*/
/************************/

/*Get the 'StyleQuoteId' to get the RFQ Due Date and 'StyleCostingID' and 'StyleCostingTypeID'.*/
SELECT @StyleQuoteId = StyleQuoteId
      ,@StyleCostingID = StyleCostingID
      ,@StyleCostingTypeID = StyleCostingType
FROM pStyleQuoteVariation
WHERE StyleQuoteVariationId = @StyleQuoteVariationId


/*Get the 'StyleQuoteDueDate' to use for the 'StyleQuoteItemDueDate'.*/
SELECT @StyleQuoteDueDate = StyleQuoteDueDate
FROM pStyleQuote
WHERE StyleQuoteId = @StyleQuoteId


/*Get the 'StyleId' and 'StyleSeasonYearId'.*/
SELECT @StyleId = StyleId
      ,@StyleSeasonYearID = StyleSeasonYearID
FROM pStyleCosting
WHERE StyleCostingID = @StyleCostingID


/*Get the 'StyleCostingHeaderID'.*/
SELECT @StyleCostingHeaderID = StyleCostingHeaderID
FROM pStyleCostingHeader
WHERE StyleID = @StyleID
AND StyleSeasonYearID = @StyleSeasonYearID


/********************************/
/*Logic for initial inserts.	*/
/********************************/
--IF (@StyleCostingTypeID = 1)	--Import
	BEGIN

		/*Add record.*/
		INSERT INTO pStyleQuoteItem(
			StyleQuoteItemID, StyleQuoteItemStatusId, 
			StyleQuoteVariationId, StyleQuoteID, StyleQuotaDutyID, StyleDevelopmentID,
			StyleID, StyleQuoteTradePartnerID, StyleCostingID, StyleCostingType, StyleCostingFreightTypeID,
			TradePartnerID, TradePartnerVendorID, StyleQuoteItemDueDate, 
			StyleQuoteItemCustomField1, StyleQuoteItemCustomField2, StyleQuoteItemCustomField3,
			StyleQuoteItemCustomField4, StyleQuoteItemCustomField5, StyleQuoteItemCustomField6,
			StyleQuoteItemCustomField7, StyleQuoteItemCustomField8, StyleQuoteItemCustomField9,
			StyleQuoteItemCustomField10, StyleQuoteItemCustomField11, StyleQuoteItemCustomField12,
			StyleQuoteItemCustomField13, StyleQuoteItemCustomField14, StyleQuoteItemCustomField15, 
			StyleQuoteItemCustomField16, StyleQuoteItemCustomField17, StyleQuoteItemCustomField18, 
			StyleQuoteItemCustomField19, StyleQuoteItemCustomField20, StyleQuoteItemCustomField21,
			StyleQuoteItemCustomField22, StyleQuoteItemCustomField23, StyleQuoteItemCustomField24, 
			StyleQuoteItemCustomField25, StyleQuoteItemCustomField26, StyleQuoteItemCustomField27, 
			StyleQuoteItemCustomField28, StyleQuoteItemCustomField29, StyleQuoteItemCustomField30, 
			StyleQuoteItemCustomField31, StyleQuoteItemCustomField32, StyleQuoteItemCustomField33, 
			StyleQuoteItemCustomField34, StyleQuoteItemCustomField35,  
			StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, 
			StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, 
			StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, 
			StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, 
			StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, 
			StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, 
			StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, 
			StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, 
			StyleCostingCustomField25, StyleCostingCustomField26, StyleCostingCustomField27, 
			StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, 
			StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, 
			StyleCostingCustomField34, StyleCostingCustomField35, 
			CUser, CDate, MUser, MDate, StyleSeasonYearID
		)
		SELECT
			@StyleQuoteItemID, 0, 
			@StyleQuoteVariationId, StyleQuoteID, StyleQuotaDutyID, StyleDevelopmentID,
			StyleID, StyleQuoteTradePartnerID, StyleCostingID, StyleCostingType, StyleCostingFreightTypeID,
			TradePartnerID, @TradePartnerVendorID, @StyleQuoteDueDate, 
			StyleQuoteItemCustomField1, StyleQuoteItemCustomField2, StyleQuoteItemCustomField3,
			StyleQuoteItemCustomField4, StyleQuoteItemCustomField5, StyleQuoteItemCustomField6,
			StyleQuoteItemCustomField7, StyleQuoteItemCustomField8, StyleQuoteItemCustomField9,
			StyleQuoteItemCustomField10, StyleQuoteItemCustomField11, StyleQuoteItemCustomField12,
			StyleQuoteItemCustomField13, StyleQuoteItemCustomField14, StyleQuoteItemCustomField15, 
			StyleQuoteItemCustomField16, StyleQuoteItemCustomField17, StyleQuoteItemCustomField18, 
			StyleQuoteItemCustomField19, StyleQuoteItemCustomField20, StyleQuoteItemCustomField21,
			StyleQuoteItemCustomField22, StyleQuoteItemCustomField23, StyleQuoteItemCustomField24, 
			StyleQuoteItemCustomField25, StyleQuoteItemCustomField26, StyleQuoteItemCustomField27, 
			StyleQuoteItemCustomField28, StyleQuoteItemCustomField29, StyleQuoteItemCustomField30, 
			StyleQuoteItemCustomField31, StyleQuoteItemCustomField32, StyleQuoteItemCustomField33, 
			StyleQuoteItemCustomField34, StyleQuoteItemCustomField35,  
			StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, 
			StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, 
			StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, 
			StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, 
			StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, 
			StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, 
			StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, 
			StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, 
			StyleCostingCustomField25, StyleCostingCustomField26, StyleCostingCustomField27, 
			StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, 
			StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, 
			StyleCostingCustomField34, StyleCostingCustomField35, 
			@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @StyleSeasonYearID

		FROM   pStyleQuoteVariation
		WHERE  StyleQuoteVariationID = @StyleQuoteVariationID
	END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01765', GetDate())
GO

SET NOCOUNT Off
GO
