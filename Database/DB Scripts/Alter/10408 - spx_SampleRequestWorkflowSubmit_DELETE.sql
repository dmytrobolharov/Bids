/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowSubmit_DELETE]    Script Date: 24.03.2015 15:17:41 ******/
IF OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowSubmit_DELETE]') IS NOT NULL
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowSubmit_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowSubmit_DELETE]    Script Date: 24.03.2015 15:17:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowSubmit_DELETE]
(@SampleRequestWorkflowID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet int,
@SampleRequestTradeID uniqueidentifier,
@StyleColorID uniqueidentifier
)
AS 
BEGIN

	BEGIN
		DELETE FROM pSampleRequestWorkflow 
		WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleID = @StyleID) AND 
		(StyleSet = @StyleSet) AND (StyleColorID = @StyleColorID) AND (SampleRequestTradeID = @SampleRequestTradeID)
	END

	BEGIN
		DELETE FROM pSampleRequestActivity
		WHERE SampleRequestSubmitId IN (SELECT SampleRequestSubmitId FROM pSampleRequestSubmit WITH (NOLOCK) 
		WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleID = @StyleID) AND 
		(StyleSet = @StyleSet) AND (StyleColorID = @StyleColorID) AND (SampleRequestTradeID = @SampleRequestTradeID))
	END

	BEGIN
		DELETE FROM pSampleRequestSubmit 
		WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleID = @StyleID) AND 
		(StyleSet = @StyleSet) AND (StyleColorID = @StyleColorID) AND (SampleRequestTradeID = @SampleRequestTradeID)
	END

	BEGIN
		DELETE FROM pSampleRequestSpecSize 
		WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleID = @StyleID) AND 
		(StyleSet = @StyleSet) AND (StyleColorID = @StyleColorID) AND (SampleRequestTradeID = @SampleRequestTradeID)
	END

	BEGIN
		DELETE FROM pSampleRequestSpecItem 
		WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleID = @StyleID) AND 
		(StyleSet = @StyleSet) AND (StyleColorID = @StyleColorID) AND (SampleRequestTradeID = @SampleRequestTradeID)
	END

	BEGIN
		DELETE FROM pSampleRequestMaterial 
		WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleID = @StyleID) AND 
		(StyleSet = @StyleSet) AND (StyleColorID = @StyleColorID) AND (SampleRequestTradeID = @SampleRequestTradeID)
	END

	BEGIN
		DELETE FROM pSampleRequestComment
		WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)  AND (StyleID = @StyleID) AND 
		(StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID)
	END
	
	/******** clear spec tables **********/
	DELETE FROM pMSEvalSampMeas WHERE SampleRequestHeaderId IN (SELECT SampleRequestHeaderId FROM pMSEvalHeader WHERE SampleRequestTradeID = @SampleRequestTradeID AND SampleRequestWorkflowID = @SampleRequestWorkflowID)
	DELETE FROM pMSEvalSampLbl WHERE SampleRequestHeaderId IN (SELECT SampleRequestHeaderId FROM pMSEvalHeader WHERE SampleRequestTradeID = @SampleRequestTradeID AND SampleRequestWorkflowID = @SampleRequestWorkflowID)
	DELETE FROM pMSEvalPom WHERE SampleRequestHeaderId IN (SELECT SampleRequestHeaderId FROM pMSEvalHeader WHERE SampleRequestTradeID = @SampleRequestTradeID AND SampleRequestWorkflowID = @SampleRequestWorkflowID)
	DELETE FROM pMSEvalHeader WHERE SampleRequestTradeID = @SampleRequestTradeID AND SampleRequestWorkflowID = @SampleRequestWorkflowID

	-- Recalculating the calendar
	DECLARE @TACalTemplateID UNIQUEIDENTIFIER
	
	DECLARE CalendarsCursor CURSOR SCROLL FOR
	SELECT TACalTemplateID FROM pTACalReference 
	WHERE ReferenceId = @SampleRequestTradeID AND TACalReferenceTypeId = 5
	
	OPEN CalendarsCursor
	FETCH NEXT FROM CalendarsCursor INTO @TACalTemplateID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC spx_TACalendar_SampleRequestWorkflowReferences_Progress_UPDATE NULL, NULL, @TACalTemplateID
		FETCH NEXT FROM CalendarsCursor INTO @TACalTemplateID
	END
	CLOSE CalendarsCursor
	DEALLOCATE CalendarsCursor

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10408', GetUTCDate())
GO
