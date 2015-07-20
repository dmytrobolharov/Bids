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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSpecBOMSubmitNo_SELECT]    Script Date: 12/18/2011 18:34:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSpecBOMSubmitNo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSpecBOMSubmitNo_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSpecBOMSubmitNo_SELECT]    Script Date: 12/18/2011 18:34:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestSpecBOMSubmitNo_SELECT]
(@StyleID uniqueidentifier,
@ItemDim1Id UNIQUEIDENTIFIER = null,
@ItemDim2Id UNIQUEIDENTIFIER = null,
@ItemDim3Id UNIQUEIDENTIFIER = null,
@StyleSet nvarchar(10),
@SampleRequestWorkflowID uniqueidentifier,
@SampleRequestTradeID uniqueidentifier,
@SampleWorkflowID nvarchar(10))
AS 

	SELECT SampleRequestWorkflowID, SampleWorkflowID, WorkflowID, TradePartnerVendorID, Submit, StyleID, StyleSet, SampleRequestTradeID
	FROM  pSampleRequestSubmitBOM WITH (NOLOCK)
	WHERE (StyleID = @StyleID) AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
	AND (SampleWorkflowID = @SampleWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID)
	ORDER BY Submit DESC

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02406'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02406', GetDate())

END

GO