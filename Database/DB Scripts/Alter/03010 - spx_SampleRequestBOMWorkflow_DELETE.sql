IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMWorkflow_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMWorkflow_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestBOMWorkflow_DELETE]
(
@SampleRequestTradeID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet int
)
AS 

--MUST be deleted be for deleting pSampleRequestSubmitBOM ******************
DELETE FROM pSampleRequestGCCWorkflow WHERE SampleRequestSubmitID in (SELECT SampleRequestSubmitID FROM pSampleRequestSubmitBOM WITH (NOLOCK) WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId))
DELETE FROM pSampleRequestSubmitVendor WHERE SampleRequestSubmitID in (SELECT SampleRequestSubmitID FROM pSampleRequestSubmitBOM WITH (NOLOCK) WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId))
--**************************************************************************
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

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03010'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03010', GetDate())

END

GO

