-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 21 December 2011                                                                           */
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_StyleQuoteItemVendor_REPLACE') AND type = N'P' )
	DROP PROCEDURE spx_StyleQuoteItemVendor_REPLACE
GO


CREATE PROCEDURE spx_StyleQuoteItemVendor_REPLACE
(
@StyleQuoteItemID uniqueidentifier,
@TradePartnerVendorID uniqueidentifier
)
AS 

	UPDATE pStyleQuoteItem 
	SET TradePartnerVendorID = @TradePartnerVendorID 
	WHERE (StyleQuoteItemID = @StyleQuoteItemID) 

	DELETE pStyleQuoteItemActivity 
	WHERE StyleQuoteItemID = @StyleQuoteItemID

	-- Fields types don't match up so we can't do this now.
	--BEGIN
	--	UPDATE a
	--	SET a.StyleQuoteItemCustomField5 = b.Country
	--	FROM pStyleQuoteItem a LEFT OUTER JOIN uTradePartnerVendor b ON
	--	a.TradePartnerVendorID = b.TradePartnerVendorID
	--	WHERE a.StyleQuoteItemID = @StyleQuoteItemID
	--END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '02491', GetDate())
GO

SET NOCOUNT Off
GO
