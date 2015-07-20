
/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasQASampleReSubmit_Insert]    Script Date: 07/14/2011 12:37:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_MeasQASampleReSubmit_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_MeasQASampleReSubmit_Insert]
GO

Create  PROCEDURE [dbo].[spx_SampleRequest_MeasQASampleReSubmit_Insert] (
	@SampleRequestSubmitId uniqueidentifier,
	@SampleRequestWorkflowID uniqueidentifier,
	@SampleWorkflowID nvarchar(5),
	@SampleRequestTradeID uniqueidentifier,
	@SampleRequestHeaderId uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleColorID uniqueidentifier,
	@StyleSet int,
	@CreatedDate nvarchar(50),
	@CreatedBy nvarchar(50),
	@Submit int,
	@NewSubmit nvarchar(50)	
)

AS 
	SET NOCOUNT ON
	
	DECLARE @ResubmitDays int

	insert into pqasampMeas (SampleRequestHeaderId , AMLMeasHdrId, AmlMeaspomid, AMLMeasLblId, AmlMeasIGCid, SamplepomId, SampleLabelId, POMRow , 
	sizecol, sampleno, submit ,MeasValue, SampMeasValue )
	select  @SampleRequestHeaderId, AMLMeasHdrId, AmlMeaspomid, AMLMeasLblId, AmlMeasIGCid, SamplepomId, SampleLabelId, POMRow, 
	sizecol, sampleno, @NewSubmit , MeasValue, 0
	from pqasampMeas 
	where  SampleRequestHeaderId=@SampleRequestHeaderId and submit=@Submit 
	 
	update pqaHeader set submit=@NewSubmit where SampleRequestHeaderId=@SampleRequestHeaderId
	 
	SELECT @ResubmitDays = ResubmitDays FROM pSampleRequestWorkflow WITH (NOLOCK) WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID
		
	INSERT INTO pSampleRequestSubmit
	(SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID, StyleColorID, StyleSet, WorkflowID, TradePartnerVendorID, TradePartnerId, Submit, Status, StartDate, DueDate, 
	CUser, CDate, MUser, MDate)
	SELECT @SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID, StyleColorID, StyleSet, WorkflowID, TradePartnerVendorID, TradePartnerId, @NewSubmit, 0, StartDate, CONVERT(CHAR(8), GETDATE() + ISNULL(@ResubmitDays,1), 112), 
	@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM pSampleRequestSubmit WITH (NOLOCK)
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
	(StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit) 
    
    
	UPDATE pSampleRequestWorkflow
	SET Status = '0', Submit = @NewSubmit, DueDate = CONVERT(CHAR(8), GETDATE() + ISNULL(@ResubmitDays,1), 112),   MUser = @CreatedBy, MDate = @CreatedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
	
	SET NOCOUNT OFF
GO
			
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01641', GetDate())
                  
