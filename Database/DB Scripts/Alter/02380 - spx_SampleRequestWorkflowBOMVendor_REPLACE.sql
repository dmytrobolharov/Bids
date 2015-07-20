-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowBOMVendor_REPLACE]    Script Date: 12/18/2011 18:09:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowBOMVendor_REPLACE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMVendor_REPLACE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowBOMVendor_REPLACE]    Script Date: 12/18/2011 18:09:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



Create   PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMVendor_REPLACE]
(
@SampleRequestTradeID uniqueidentifier,
@TradePartnerVendorID uniqueidentifier
)
AS 

UPDATE  pSampleRequestBOMTrade SET  TradePartnerVendorID = @TradePartnerVendorID
WHERE   (SampleRequestTradeID = @SampleRequestTradeID) 

UPDATE  pSampleRequestWorkflowBOM SET  TradePartnerVendorID = @TradePartnerVendorID
WHERE   (SampleRequestTradeID = @SampleRequestTradeID) 

UPDATE  pSampleRequestStyleBOM SET  TradePartnerVendorID = @TradePartnerVendorID
WHERE   (SampleRequestTradeID = @SampleRequestTradeID) 

UPDATE  pSampleRequestSubmitBOM SET  TradePartnerVendorID = @TradePartnerVendorID
WHERE   (SampleRequestTradeID = @SampleRequestTradeID) 

UPDATE  pSampleRequestSpecItem SET  TradePartnerVendorID = @TradePartnerVendorID
WHERE   (SampleRequestTradeID = @SampleRequestTradeID) 

UPDATE  pSampleRequestMaterialBOM SET  TradePartnerVendorID = @TradePartnerVendorID
WHERE   (SampleRequestTradeID = @SampleRequestTradeID) 




GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02380'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02380', GetDate())

END

GO
