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
/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMWorkflowSubmit_DELETE]    Script Date: 12/18/2011 18:30:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMWorkflowSubmit_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMWorkflowSubmit_DELETE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMWorkflowSubmit_DELETE]    Script Date: 12/18/2011 18:30:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMWorkflowSubmit_DELETE]
(@SampleRequestWorkflowID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet int,
@SampleRequestTradeID uniqueidentifier,
@ItemDim1Id  nvarchar(50) = null,
@ItemDim2Id  nvarchar(50) = null,
@ItemDim3Id  nvarchar(50) = null
)
AS 

BEGIN
	DELETE FROM pSampleRequestWorkflowBOM 
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleID = @StyleID) AND 
	(StyleSet = @StyleSet) AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id)
	AND (SampleRequestTradeID = @SampleRequestTradeID)
END

BEGIN
	DELETE FROM pSampleRequestBOMActivity
	WHERE SampleRequestSubmitId IN (SELECT SampleRequestSubmitId FROM pSampleRequestSubmit WITH (NOLOCK) 
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleID = @StyleID) AND 
	(StyleSet = @StyleSet) AND  (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) 
	AND (SampleRequestTradeID = @SampleRequestTradeID))
END

BEGIN
	DELETE FROM pSampleRequestSubmitBOM 
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleID = @StyleID) AND 
	(StyleSet = @StyleSet) AND  (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id)
	 AND (SampleRequestTradeID = @SampleRequestTradeID)
END

BEGIN
	DELETE FROM pSampleRequestSpecSizeBOM 
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleID = @StyleID) AND 
	(StyleSet = @StyleSet)  AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id)
	 AND (SampleRequestTradeID = @SampleRequestTradeID)
END

BEGIN
	DELETE FROM pSampleRequestSpecItem 
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleID = @StyleID) AND 
	(StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID)
END

BEGIN
	DELETE FROM pSampleRequestMaterialBOM 
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleID = @StyleID) AND 
	(StyleSet = @StyleSet)  AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) 
	AND (SampleRequestTradeID = @SampleRequestTradeID)
END

BEGIN
	DELETE FROM pSampleRequestComment
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleID = @StyleID) AND 
	(StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID)
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02398'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02398', GetDate())

END

GO