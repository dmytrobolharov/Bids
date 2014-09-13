/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitBOMStatus_Logic_UPDATE]    Script Date: 05/21/2013 18:07:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowSubmitBOMStatus_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowSubmitBOMStatus_Logic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitBOMStatus_Logic_UPDATE]    Script Date: 05/21/2013 18:07:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_SampleWorkflowSubmitBOMStatus_Logic_UPDATE](
@SampleRequestSubmitID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200), 
@MDate DATETIME,
@SampleLockVendorFields INT  
)
AS


DECLARE @EndDate DATETIME 
DECLARE @EndBy NVARCHAR(200)
DECLARE @Status  INT 
DECLARE @StyleID UNIQUEIDENTIFIER
DECLARE @StyleSet INT
DECLARE @SampleRequestTradeID UNIQUEIDENTIFIER
DECLARE @SampleRequestWorkflowID UNIQUEIDENTIFIER
DECLARE @ItemDim1Id UNIQUEIDENTIFIER
DECLARE @ItemDim2Id UNIQUEIDENTIFIER
DECLARE @ItemDim3Id UNIQUEIDENTIFIER
DECLARE @SampleWorkflowID NVARCHAR(5)
DECLARE @Submit INT
DECLARE @DueDate DATETIME
DECLARE @ApprovedType INT 

DECLARE @RecDate DATETIME
DECLARE @RevDate DATETIME
DECLARE @VendorDate DATETIME

---***
---** Update Dates, Set Null when < '1910-01-01 00:00:00.000'
---***


SELECT @EndDate = a.EndDate, @EndBy = a.EndBy, @Status = a.Status, @ApprovedType = b.ApprovedType,
@StyleID = StyleID, @StyleSet = StyleSet, @SampleRequestTradeID = SampleRequestTradeID, 
@SampleRequestWorkflowID = SampleRequestWorkflowID, @ItemDim1Id = ItemDim1Id,@ItemDim2Id = ItemDim2Id,@ItemDim3Id = ItemDim3Id,
@SampleWorkflowID = SampleWorkflowID, @Submit = Submit, @DueDate = DueDate,
@RecDate = RecDate , @RevDate = RevDate, @VendorDate = VendorDate
FROM pSampleRequestSubmitBOM a
INNER JOIN pSampleRequestSubmitStatus b ON a.Status = b.StatusID
WHERE a.SampleRequestSubmitID = @SampleRequestSubmitID

--SELECT * FROM pSampleRequestSubmitStatus 
IF @DueDate < '1910-01-01 00:00:00.000'
BEGIN 
	UPDATE pSampleRequestSubmitBOM SET DueDate = NULL WHERE SampleRequestSubmitID = @SampleRequestSubmitID
	SET @DueDate = NULL
END 

IF @RecDate < '1910-01-01 00:00:00.000'
BEGIN 
	UPDATE pSampleRequestSubmitBOM SET RecDate = NULL WHERE SampleRequestSubmitID = @SampleRequestSubmitID
	SET @RecDate = NULL
END 
	
IF @EndDate < '1910-01-01 00:00:00.000'
BEGIN 
	UPDATE pSampleRequestSubmitBOM SET EndDate = NULL WHERE SampleRequestSubmitID = @SampleRequestSubmitID
	SET @EndDate = NULL
END 
	
IF @RevDate< '1910-01-01 00:00:00.000'
BEGIN 
	UPDATE pSampleRequestSubmitBOM SET RevDate= NULL WHERE SampleRequestSubmitID = @SampleRequestSubmitID
	SET @RevDate = NULL
END 
	
IF @VendorDate < '1910-01-01 00:00:00.000'
BEGIN 
	UPDATE pSampleRequestSubmitBOM SET VendorDate = NULL WHERE SampleRequestSubmitID = @SampleRequestSubmitID
	SET @VendorDate  = NULL
END 

IF (SELECT b.ApprovedType FROM pSampleRequestSubmitBOM  a
	INNER JOIN pSampleRequestSubmitStatus b ON a.Status =  b.StatusID
	WHERE SampleRequestSubmitID = @SampleRequestSubmitID ) = 1
BEGIN
	---***
	---** Submit approved
	---***
	
	IF @EndDate IS NULL
		BEGIN
			SET @EndDate = @MDate 			
			UPDATE pSampleRequestSubmitBOM SET EndDate = @MDate 
			WHERE SampleRequestSubmitID = @SampleRequestSubmitID
		END
	IF @EndBy IS NULL
		BEGIN
			UPDATE pSampleRequestSubmitBOM SET EndBy = @MUser
			WHERE SampleRequestSubmitID = @SampleRequestSubmitID
		END

END 



DECLARE @vcDate as varchar (15) 
IF @Status  =  4 
	BEGIN
		SET @EndDate =  GetDate()
	END
	
IF (SELECT COUNT(*) FROM pSampleRequestSpecSizeBOM WITH (NOLOCK) 
	WHERE StyleID = @StyleID 
	AND StyleSet = @StyleSet 
	AND SampleRequestTradeID = @SampleRequestTradeID 
	AND SampleRequestWorkflowID = @SampleRequestWorkflowID AND @ItemDim1Id = ItemDim1Id AND @ItemDim2Id = ItemDim2Id AND @ItemDim3Id = ItemDim3Id) = 0
BEGIN	

	INSERT INTO dbo.pSampleRequestSpecSizeBOM
	(SampleRequestSpecSizeID, SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, WorkflowID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleID, SizeRange, StyleSet, 
	Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
	Col0, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9, Col10, Col11, Col12, Col13, Col14, Col15, Col16, Col17, Col18, Col19, 
	Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19)
	SELECT     NEWID(), @SampleRequestTradeID, @SampleRequestWorkflowID, @SampleWorkflowID, '{40000000-0000-0000-0000-000000000005}', @ItemDim1Id,@ItemDim2Id,@ItemDim3Id,
	StyleID, SizeRange, @StyleSet, 
	Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0 ,0 ,0 ,0 ,0 ,0, 
	Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19
	FROM dbo.pStyleSpecSize WITH (NOLOCK) WHERE (StyleID = @StyleID)

END



DECLARE @Month NVARCHAR(2) 
DECLARE @nMont INT 

IF @Status = 1
	BEGIN
		SET @nMont = @Submit + 1
	END
ELSE 
	BEGIN
		SET @nMont = @Submit
	END


IF  @Submit < 10
	BEGIN
		SET @Month  = '0' + CAST(@Submit AS VARCHAR(1))
	END
ELSE
	BEGIN 
		SET @Month  = CAST(@Submit AS VARCHAR(2))
	END


IF @Status = 0        -- OPEN 
	BEGIN		
		if @Submit > 1 
			BEGIN
				SET @vcDate =  '1900-' + @Month + '-02' -- +  '/2/1900'
			END
		ELSE
			BEGIN
				SET @vcDate = '1900-' + @Month + '-01'  -- '/1/1900'
			end
			
		UPDATE    dbo.pSampleRequestWorkflowBOM
		SET              Submit = @Submit, Status = @Status, DueDate = @DueDate, 
		--EndDate = CONVERT(nvarchar(2),@Submit) +  @vcDate, 
		EndDate = @vcDate, 
		MUser = @MUser, MDate = @MDate
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
		MUser = @MUser, MDate = @MDate
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
		MUser = @MUser, MDate = @MDate
		WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
			  (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
	END
ELSE
	BEGIN				
		UPDATE dbo.pSampleRequestWorkflowBOM
		SET  Submit = @Submit, Status = @Status, DueDate = @DueDate,EndDate=@MDate, 
		--EndDate = @EndDate, 
		MUser = @MUser, MDate = @MDate
		WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
							  (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
	END




--***
--** Update Material Sample 
--***

IF @ApprovedType = 1
	BEGIN		
		UPDATE pSampleRequestMaterialBOM  SET Status = 3,EndDate=@MDate 
		WHERE SampleRequestTradeID = @SampleRequestTradeID
		AND SampleWorkflowID = @SampleWorkflowID
		AND Submit = @Submit
	END 




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05770', GetDate())
GO
