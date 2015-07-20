
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 14 September 2011                                                                               */
-- * WorkItem #5011                                                                             */
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
/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemAgentNew_SELECT]    Script Date: 09/13/2011 14:12:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemAgentNew_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteItemAgentNew_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemAgentNew_SELECT]    Script Date: 09/13/2011 14:12:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteItemAgentNew_SELECT] (
@TradePartnerId UNIQUEIDENTIFIER , 
@Top INT ,
@Total INT OUTPUT 
)
AS 


DECLARE @SQLString nvarchar(4000)
DECLARE @ParmDefinition nvarchar(500)


SET @SQLString = 'SELECT @pTotal = COUNT(*)
FROM pStyleQuoteItem WITH (NOLOCK) INNER JOIN 
pStyleHeader  WITH (NOLOCK) ON pStyleQuoteItem.StyleID = pStyleHeader.StyleID INNER JOIN 
uTradePartnerVendor  WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
WHERE  pStyleQuoteItem.TradePartnerID = @pTradePartnerId
AND pStyleQuoteItem.AgentView = 0
AND pStyleQuoteItem.StyleQuoteItemShare = 1'

SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER, @pTotal INT OUTPUT'

EXECUTE sp_executesql @SQLString, @ParmDefinition, 
		@pTradePartnerId = @TradePartnerId, 
		@pTotal = @Total OUTPUT


IF (@Top IS NULL) OR ( @Top<=0 )
	SET @SQLString = 'SELECT ' 
ELSE 
	SET @SQLString = 'SELECT TOP ' +  CAST ( @Top AS NVARCHAR(5) ) 

SET @SQLString = @SQLString + ' pStyleQuoteItem.StyleQuoteItemID, pStyleQuoteItem.CDate, pStyleHeader.StyleID, pStyleHeader.StyleNo, 
        pStyleHeader.Description, pStyleHeader.SizeClass, uTradePartnerVendor.VendorName, pStyleQuoteItem.TradePartnerID, 
        uTradePartnerVendor.VendorCode
FROM   pStyleQuoteItem  WITH (NOLOCK) INNER JOIN
pStyleHeader  WITH (NOLOCK) ON pStyleQuoteItem.StyleID = pStyleHeader.StyleID INNER JOIN
uTradePartnerVendor  WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
WHERE  pStyleQuoteItem.TradePartnerID = @pTradePartnerId
AND pStyleQuoteItem.AgentView = 0
AND pStyleQuoteItem.StyleQuoteItemShare = 1
ORDER BY pStyleQuoteItem.CDate DESC'

SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER'
EXECUTE sp_executesql @SQLString, @ParmDefinition, 
		@pTradePartnerId = @TradePartnerId


/*
MODIFIED:  July 25, 2008

SELECT     pStyleQuoteItem.StyleQuoteItemID, pStyleQuoteItem.CDate, pStyleHeader.StyleID, pStyleHeader.StyleNo, 
        pStyleHeader.Description, pStyleHeader.SizeClass, uTradePartnerVendor.VendorName, pStyleQuoteItem.TradePartnerID, 
        uTradePartnerVendor.VendorCode
FROM         pStyleQuoteItem WITH (NOLOCK) INNER JOIN
        pStyleHeader WITH (NOLOCK) ON pStyleQuoteItem.StyleID = pStyleHeader.StyleID INNER JOIN
        uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
WHERE     (pStyleQuoteItem.TradePartnerID = @TradePartnerId) AND (pStyleQuoteItem.AgentView = 0) AND (pStyleQuoteItem.StyleQuoteItemShare = 1)  
ORDER BY uTradePartnerVendor.VendorCode, pStyleQuoteItem.CDate

*/

Go
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01938'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01938', GetDate())
END	

GO


