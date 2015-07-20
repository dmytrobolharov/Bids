/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflow_DELETE]    Script Date: 08/22/2014 16:45:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflow_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflow_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflow_DELETE]    Script Date: 08/22/2014 16:45:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflow_DELETE]
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
	DELETE FROM pSampleRequestWorkflow	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
	DELETE FROM pSampleRequestSubmit	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
	DELETE FROM pSampleRequestMaterial	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
	DELETE FROM pSampleRequestSpecSize	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
	DELETE FROM pSampleRequestSpecItem	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
	DELETE FROM pSampleRequestStyle		WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
	DELETE FROM pSampleRequestTrade		WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 
	DELETE FROM pSampleRequestActivity	WHERE (SampleRequestTradeID = @SampleRequestTradeID) AND (StyleID = @StyleId) 

	DELETE FROM  pSampleRequestComment WHERE SampleRequestTradeID = @SampleRequestTradeID AND  StyleID = @StyleId



	set ANSI_NULLS ON
	set QUOTED_IDENTIFIER ON

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08974', GetDate())
GO
