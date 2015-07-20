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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSpecSubmitNoBOM_SELECT]    Script Date: 12/18/2011 18:13:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSpecSubmitNoBOM_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSpecSubmitNoBOM_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSpecSubmitNoBOM_SELECT]    Script Date: 12/18/2011 18:13:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestSpecSubmitNoBOM_SELECT]
(@StyleID uniqueidentifier,
@ItemDim1Id nvarchar(100) = null,
@ItemDim2Id nvarchar(100) = null,
@ItemDim3Id nvarchar(100) = null,
@StyleSet nvarchar(10),
@SampleRequestWorkflowID  nvarchar(100)  = null,
@SampleRequestTradeID uniqueidentifier,
@SampleWorkflowID nvarchar(10))
AS 



	SELECT SampleRequestWorkflowID, SampleWorkflowID, WorkflowID, TradePartnerVendorID, Submit, StyleID, StyleSet, SampleRequestTradeID
	FROM  pSampleRequestSubmitBOM WITH (NOLOCK)
	WHERE (StyleID = @StyleID) AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
	AND (SampleWorkflowID = @SampleWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID)
	ORDER BY Submit DESC

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02385'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02385', GetDate())

END

GO
