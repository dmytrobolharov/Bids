/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowBOMSubmitQA_UPDATE]    Script Date: 05/21/2013 18:00:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowBOMSubmitQA_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmitQA_UPDATE]
GO

Create PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmitQA_UPDATE]
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
@ItemDim1Id UNIQUEIDENTIFIER = null,
@ItemDim2Id UNIQUEIDENTIFIER = null,
@ItemDim3Id UNIQUEIDENTIFIER = null,
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
		UPDATE    dbo.pSampleRequestSubmitBOM
		SET              Status = @Status, RevDate = @RevDate, RevBy = @RevBy, RecDate = @RecDate, RecBy = @RecBy, RecCarrier = @RecCarrier, RecTrackNo = @RecTrackNo, RecWeight = @RecWeight, 
		                      VendorWeight = @VendorWeight, DueDate = @DueDate, EndDate = @EndDate, EndBy = @EndBy, MUser = @ModifiedBy, 
		                      MDate = @ModifiedDate, VendorDate = @VendorDate, VendorName = @VendorName, InternalComment = @InternalComment, NoTolerance = @NoTolerance  
		WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
		                      (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit)
	END
	ELSE 
	BEGIN
		UPDATE    dbo.pSampleRequestSubmitBOM
		SET              Status = @Status, RevDate = @RevDate, RevBy = @RevBy, RecDate = @RecDate, RecBy = @RecBy,  RecWeight = @RecWeight, 
		                      DueDate = @DueDate, EndDate = @EndDate, EndBy = @EndBy, MUser = @ModifiedBy, 
		                      MDate = @ModifiedDate,  InternalComment = @InternalComment, NoTolerance = @NoTolerance  
		WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
		                      (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit)
	END
	
END                      




IF @Status = 0        -- OPEN 
BEGIN

	if @Submit > 1 
		SET @vcDate = '/2/1900'
	ELSE
		SET @vcDate = '/1/1900'


	UPDATE    dbo.pSampleRequestWorkflowBOM
	SET              Submit = @Submit, Status = @Status, DueDate = @DueDate, EndDate = CONVERT(nvarchar(2),@Submit) +  @vcDate   , MUser = @ModifiedBy, MDate = @ModifiedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) 
	AND  (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
END
ELSE IF @Status = 1       -- RESUMIT
BEGIN
	--PRINT DATEADD(day,7,GETDATE())
	UPDATE    pSampleRequestWorkflowBOM
	SET              Submit = @Submit, Status = 0, DueDate = @DueDate, EndDate = CONVERT(nvarchar(2),(@Submit)) + '/2/1900', MUser = @ModifiedBy, MDate = @ModifiedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
						  (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
END
ELSE IF @Status = 4       -- DROPPED 
BEGIN
	UPDATE    dbo.pSampleRequestWorkflowBOM
	SET              Submit = @Submit, Status = @Status, DueDate = @DueDate, EndDate = CONVERT(nvarchar(2),@Submit) + '/3/1900', MUser = @ModifiedBy, MDate = @ModifiedDate, FinalDate = @ModifiedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
		  (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
END
ELSE
BEGIN
	UPDATE dbo.pSampleRequestWorkflowBOM
	SET              Submit = @Submit, Status = @Status, DueDate = @DueDate, EndDate = @EndDate, MUser = @ModifiedBy, MDate = @ModifiedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
						  (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05768', GetDate())
GO
