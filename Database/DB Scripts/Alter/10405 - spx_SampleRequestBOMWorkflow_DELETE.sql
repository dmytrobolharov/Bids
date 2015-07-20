/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMWorkflow_DELETE]    Script Date: 24.03.2015 15:16:09 ******/
IF OBJECT_ID(N'[dbo].[spx_SampleRequestBOMWorkflow_DELETE]') IS NOT NULL
DROP PROCEDURE [dbo].[spx_SampleRequestBOMWorkflow_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestBOMWorkflow_DELETE]
(
@SampleRequestTradeID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet int
)
AS 
BEGIN
	-- Breaking the connections between all the calendars
	DECLARE @TACalTemplateID UNIQUEIDENTIFIER
	
	DECLARE CalendarsCursor CURSOR SCROLL FOR
	SELECT TACalTemplateID FROM pTACalReference 
	WHERE ReferenceId = @SampleRequestTradeID AND TACalReferenceTypeId = 5
	
	OPEN CalendarsCursor
	FETCH NEXT FROM CalendarsCursor INTO @TACalTemplateID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC spx_TACalReference_DELETE @TACalTemplateID, @SampleRequestTradeID
		FETCH NEXT FROM CalendarsCursor INTO @TACalTemplateID
	END
	CLOSE CalendarsCursor
	DEALLOCATE CalendarsCursor
	
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

	/********* clear spec tables *********/
	DELETE FROM pMSEvalSampMeas WHERE SampleRequestHeaderId IN (SELECT SampleRequestHeaderId FROM pMSEvalHeader WHERE SampleRequestTradeID = @SampleRequestTradeID)
	DELETE FROM pMSEvalSampLbl WHERE SampleRequestHeaderId IN (SELECT SampleRequestHeaderId FROM pMSEvalHeader WHERE SampleRequestTradeID = @SampleRequestTradeID)
	DELETE FROM pMSEvalPom WHERE SampleRequestHeaderId IN (SELECT SampleRequestHeaderId FROM pMSEvalHeader WHERE SampleRequestTradeID = @SampleRequestTradeID)
	DELETE FROM pMSEvalHeader WHERE SampleRequestTradeID = @SampleRequestTradeID


	set ANSI_NULLS ON
	set QUOTED_IDENTIFIER ON


END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10405', GetUTCDate())
GO
