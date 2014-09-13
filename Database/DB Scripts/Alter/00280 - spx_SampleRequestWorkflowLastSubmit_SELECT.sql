IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowLastSubmit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowLastSubmit_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowLastSubmit_SELECT](
@SampleRequestTradeID UNIQUEIDENTIFIER, 
@SampleWorkFlowID  NVARCHAR(5)
) 
AS 

	DECLARE @Submit INT 
	
	SELECT @Submit = MAX(Submit)  FROM pSampleRequestSubmit	
	WHERE SampleWorkflowID = @SampleWorkflowID -- '14A'
	AND SampleRequestTradeID = @SampleRequestTradeID -- '38D4B726-F30A-4A0A-8096-1952103AF227'
	
	IF @Submit > 0 
	BEGIN 

		SELECT b.SummaryXML,b.EditXML,  a.* 
		FROM pSampleRequestSubmit a
		INNER JOIN pSampleRequestWorkflowStatusSchema b ON  (b.StatusID = a.status AND b.SampleWorkflowID = a.SampleWorkflowID)
		WHERE a.SampleRequestTradeID = @SampleRequestTradeID  --'38D4B726-F30A-4A0A-8096-1952103AF227'
		AND a.SampleWorkflowID = @SampleWorkflowID --'14A'
		AND a.Submit = @Submit
		
	END  
	

	
GO