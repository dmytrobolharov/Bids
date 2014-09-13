/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMWorkflowSubmit_DELETE]    Script Date: 08/22/2014 16:37:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMWorkflowSubmit_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMWorkflowSubmit_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMWorkflowSubmit_DELETE]    Script Date: 08/22/2014 16:37:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestBOMWorkflowSubmit_DELETE]
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
VALUES ('DB_Version', '6.0.0000', '08973', GetDate())
GO
