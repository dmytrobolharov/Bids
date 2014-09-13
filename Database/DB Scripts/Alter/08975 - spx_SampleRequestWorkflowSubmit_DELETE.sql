/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowSubmit_DELETE]    Script Date: 08/22/2014 16:37:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowSubmit_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowSubmit_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowSubmit_DELETE]    Script Date: 08/22/2014 16:37:40 ******/
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
VALUES ('DB_Version', '6.0.0000', '08975', GetDate())
GO
