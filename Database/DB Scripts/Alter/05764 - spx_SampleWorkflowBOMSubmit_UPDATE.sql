/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowBOMSubmit_UPDATE]    Script Date: 05/21/2013 18:04:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowBOMSubmit_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmit_UPDATE]
GO

Create PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmit_UPDATE]
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

IF @Status  =  4 
	SET @EndDate =  GetDate()

IF (SELECT COUNT(*) FROM pSampleRequestSpecSizeBOM WITH (NOLOCK) WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND SampleRequestTradeID = @SampleRequestTradeID AND SampleRequestWorkflowID = @SampleRequestWorkflowID AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id)) = 0

BEGIN	

	INSERT INTO dbo.pSampleRequestSpecSizeBOM
	(SampleRequestSpecSizeID, SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, WorkflowID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleID, SizeRange, StyleSet, 
	Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
	Col0, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9, Col10, Col11, Col12, Col13, Col14, Col15, Col16, Col17, Col18, Col19, 
	Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19)
	SELECT     NEWID(), @SampleRequestTradeID, @SampleRequestWorkflowID, @SampleWorkflowID, '{40000000-0000-0000-0000-000000000005}',  @ItemDim1Id,@ItemDim2Id,@ItemDim3Id,
	StyleID, SizeRange, @StyleSet, 
	Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0 ,0 ,0 ,0 ,0 ,0, 
	Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19
	FROM dbo.pStyleSpecSize WITH (NOLOCK) WHERE (StyleID = @StyleID)

END


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



DECLARE @Month NVARCHAR(2) 
DECLARE @nMont INT 

IF @Status = 1
	SET @nMont = @Submit + 1
ELSE 
	SET @nMont = @Submit


IF  @Submit < 10
	SET @Month  = '0' + CAST(@Submit AS VARCHAR(1))
ELSE 
	SET @Month  = CAST(@Submit AS VARCHAR(2))


IF @Status = 0        -- OPEN 
BEGIN

	if @Submit > 1 
		SET @vcDate =  '1900-' + @Month + '-02' -- +  '/2/1900'
	ELSE
		SET @vcDate = '1900-' + @Month + '-01'  -- '/1/1900'

	UPDATE    dbo.pSampleRequestWorkflowBOM
	SET              Submit = @Submit, Status = @Status, DueDate = @DueDate, 
	--EndDate = CONVERT(nvarchar(2),@Submit) +  @vcDate, 
	EndDate = @vcDate, 
	MUser = @ModifiedBy, MDate = @ModifiedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) 
	AND  (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
END
ELSE IF @Status = 1       -- RESUMIT
BEGIN

	SET @vcDate =  '1900-' + @Month + '-02' 

	UPDATE    pSampleRequestWorkflowBOM
	SET              Submit = (@Submit + 1), Status = 0, DueDate = @DueDate, 
	--EndDate = CONVERT(nvarchar(2),(@Submit + 1)) + '/2/1900', 
	EndDate = @vcDate,
	MUser = @ModifiedBy, MDate = @ModifiedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
						 (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
END
ELSE IF @Status = 4       -- DROPPED 
BEGIN

	SET @vcDate =  '1900-' + @Month + '-03' 

	UPDATE    dbo.pSampleRequestWorkflowBOM
	SET              Submit = @Submit, Status = @Status, DueDate = @DueDate, 
	--EndDate = CONVERT(nvarchar(2),@Submit) + '/3/1900', 
	FinalDate = @EndDate,
	EndDate = @vcDate,
	MUser = @ModifiedBy, MDate = @ModifiedDate
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
VALUES     ('DB_Version', '0.5.0000', '05764', GetDate())
GO
