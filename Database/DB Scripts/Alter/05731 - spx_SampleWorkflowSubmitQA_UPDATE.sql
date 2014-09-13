/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitQA_UPDATE]    Script Date: 05/21/2013 18:02:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowSubmitQA_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowSubmitQA_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitQA_UPDATE]    Script Date: 05/21/2013 18:02:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleWorkflowSubmitQA_UPDATE]
(@Status nvarchar(50),
@RevDate nvarchar(50),
@RevBy nvarchar(200),
@RecDate nvarchar(50),
@RecBy nvarchar(200),
@RecCarrier nvarchar(200),
@RecTrackNo nvarchar(50),
@RecWeight nvarchar(50),
@VendorWeight nvarchar(50),
@VendorName nvarchar(200),
@VendorDate nvarchar(50),
@DueDate nvarchar(50),
@EndDate nvarchar(50),
@EndBy nvarchar(200),
@SampleRequestWorkflowID uniqueidentifier,
@SampleWorkflowID nvarchar(5),
@StyleID uniqueidentifier,
@StyleColorID uniqueidentifier,
@StyleSet int,
@SampleRequestTradeID uniqueidentifier,
@Submit int,
@ModifiedBy nvarchar(200),
@ModifiedDate datetime,
@NoTolerance int = 0,
@InternalComment ntext,
@SampleLockVendorFields int = 0
)
AS 

DECLARE @vcDate as varchar (15) 


BEGIN

	IF @SampleLockVendorFields  =  0
	BEGIN 
		UPDATE    dbo.pSampleRequestSubmit
		SET              Status = @Status, RevDate = @RevDate, RevBy = @RevBy, RecDate = @RecDate, RecBy = @RecBy, RecCarrier = @RecCarrier, RecTrackNo = @RecTrackNo, RecWeight = @RecWeight, 
		                      VendorWeight = @VendorWeight, DueDate = @DueDate, EndDate = @EndDate, EndBy = @EndBy, MUser = @ModifiedBy, 
		                      MDate = @ModifiedDate, VendorDate = @VendorDate, VendorName = @VendorName, InternalComment = @InternalComment, NoTolerance = @NoTolerance  
		WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
		                      (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit)
	END
	ELSE 
	BEGIN
		UPDATE    dbo.pSampleRequestSubmit
		SET              Status = @Status, RevDate = @RevDate, RevBy = @RevBy, RecDate = @RecDate, RecBy = @RecBy,  RecWeight = @RecWeight, 
		                      DueDate = @DueDate, EndDate = @EndDate, EndBy = @EndBy, MUser = @ModifiedBy, 
		                      MDate = @ModifiedDate,  InternalComment = @InternalComment, NoTolerance = @NoTolerance  
		WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
		                      (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit)
	END
	
END                      




IF @Status = 0        -- OPEN 
BEGIN

	if @Submit > 1 
		SET @vcDate = '/2/1900'
	ELSE
		SET @vcDate = '/1/1900'


	UPDATE    dbo.pSampleRequestWorkflow
	SET              Submit = @Submit, Status = @Status, DueDate = @DueDate, EndDate = CONVERT(nvarchar(2),@Submit) +  @vcDate   , MUser = @ModifiedBy, MDate = @ModifiedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) 
	AND  (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
END
ELSE IF @Status = 1       -- RESUMIT
BEGIN
	--PRINT DATEADD(day,7,GETDATE())
	UPDATE    pSampleRequestWorkflow
	SET              Submit = @Submit, Status = 0, DueDate = @DueDate, EndDate = CONVERT(nvarchar(2),(@Submit)) + '/2/1900', MUser = @ModifiedBy, MDate = @ModifiedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
						  (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
END
ELSE IF @Status = 4       -- DROPPED 
BEGIN
	UPDATE    dbo.pSampleRequestWorkflow
	SET              Submit = @Submit, Status = @Status, DueDate = @DueDate, EndDate = @ModifiedDate, MUser = @ModifiedBy, MDate = @ModifiedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
		  (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
END
ELSE
BEGIN
	UPDATE dbo.pSampleRequestWorkflow
	SET              Submit = @Submit, Status = @Status, DueDate = @DueDate, EndDate = @EndDate, MUser = @ModifiedBy, MDate = @ModifiedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
						  (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05731', GetDate())
GO
