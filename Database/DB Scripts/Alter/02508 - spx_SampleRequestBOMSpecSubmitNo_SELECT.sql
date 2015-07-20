
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 23 Dec 2011                                                                               */
-- * WorkItem #5307                                                                             */
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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecSubmitNo_SELECT]    Script Date: 12/23/2011 00:09:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpecSubmitNo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpecSubmitNo_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecSubmitNo_SELECT]    Script Date: 12/23/2011 00:09:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestBOMSpecSubmitNo_SELECT]
(
	@StyleID UNIQUEIDENTIFIER,
	@ItemDim1Id UNIQUEIDENTIFIER = NULL,
	@ItemDim2Id UNIQUEIDENTIFIER = NULL,
	@ItemDim3Id UNIQUEIDENTIFIER = NULL,
	@StyleSet NVARCHAR(10),
	@SampleRequestWorkflowID UNIQUEIDENTIFIER,
	@SampleRequestTradeID UNIQUEIDENTIFIER,
	@SampleWorkflowID NVARCHAR(10))
AS 
BEGIN
	SELECT 
		SampleRequestWorkflowID, SampleWorkflowID, WorkflowID, 
		TradePartnerVendorID, Submit, StyleID, 
		StyleSet, SampleRequestTradeID
	FROM  
		pSampleRequestSubmitBOM WITH (NOLOCK)
	WHERE 
		(StyleID = @StyleID) 
		AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) 
		AND (StyleSet = @StyleSet) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
		AND (SampleWorkflowID = @SampleWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID)
	ORDER BY 
		Submit DESC
END




GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02508'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02508', GetDate())
END

GO
