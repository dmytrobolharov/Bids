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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMWorkflow_DELETE]    Script Date: 12/18/2011 18:30:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMWorkflow_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMWorkflow_DELETE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMWorkflow_DELETE]    Script Date: 12/18/2011 18:30:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMWorkflow_DELETE]
(
@SampleRequestTradeID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet int
)
AS 


DELETE FROM pSampleRequestSetItem	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
DELETE FROM pSampleRequestWorkflowBOM	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
DELETE FROM pSampleRequestSubmitBOM	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
DELETE FROM pSampleRequestMaterialBOM	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
DELETE FROM pSampleRequestSpecSizeBOM	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
DELETE FROM pSampleRequestSpecItem	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
DELETE FROM pSampleRequestStyleBOM		WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
DELETE FROM pSampleRequestBOMTrade		WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
DELETE FROM pSampleRequestBOMActivity	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 

DELETE FROM  pSampleRequestComment WHERE SampleRequestTradeID = @SampleRequestTradeID AND  StyleID = @StyleId



set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02397'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02397', GetDate())

END

GO

