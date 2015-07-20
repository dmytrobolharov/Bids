/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitStatus_Logic_UPDATE]    Script Date: 08/14/2014 22:22:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowSubmitStatus_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowSubmitStatus_Logic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitStatus_Logic_UPDATE]    Script Date: 08/14/2014 22:22:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_SampleWorkflowSubmitStatus_Logic_UPDATE](
@SampleRequestSubmitID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200), 
@MDate DATETIME,
@SampleLockVendorFields INT  
)
AS
BEGIN

	DECLARE @EndDate DATETIME 
	DECLARE @EndBy NVARCHAR(200)
	DECLARE @Status  INT 
	DECLARE @StyleID UNIQUEIDENTIFIER
	DECLARE @StyleSet INT
	DECLARE @SampleRequestTradeID UNIQUEIDENTIFIER
	DECLARE @SampleRequestWorkflowID UNIQUEIDENTIFIER
	DECLARE @StyleColorID UNIQUEIDENTIFIER
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
	@SampleRequestWorkflowID = SampleRequestWorkflowID, @StyleColorID = StyleColorID,
	@SampleWorkflowID = SampleWorkflowID, @Submit = Submit, @DueDate = DueDate,
	@RecDate = RecDate , @RevDate = RevDate, @VendorDate = VendorDate
	FROM pSampleRequestSubmit a
	INNER JOIN pSampleRequestSubmitStatus b ON a.Status = b.StatusID
	WHERE a.SampleRequestSubmitID = @SampleRequestSubmitID

	--SELECT * FROM pSampleRequestSubmitStatus 
	IF @DueDate < '1910-01-01 00:00:00.000'
	BEGIN 
		UPDATE pSampleRequestSubmit SET DueDate = NULL WHERE SampleRequestSubmitID = @SampleRequestSubmitID
		SET @DueDate = NULL
	END 

	IF @RecDate < '1910-01-01 00:00:00.000'
	BEGIN 
		UPDATE pSampleRequestSubmit SET RecDate = NULL WHERE SampleRequestSubmitID = @SampleRequestSubmitID
		SET @RecDate = NULL
	END 
		
	IF @EndDate < '1910-01-01 00:00:00.000'
	BEGIN 
		UPDATE pSampleRequestSubmit SET EndDate = NULL WHERE SampleRequestSubmitID = @SampleRequestSubmitID
		SET @EndDate = NULL
	END 
		
	IF @RevDate< '1910-01-01 00:00:00.000'
	BEGIN 
		UPDATE pSampleRequestSubmit SET RevDate= NULL WHERE SampleRequestSubmitID = @SampleRequestSubmitID
		SET @RevDate = NULL
	END 
		
	IF @VendorDate < '1910-01-01 00:00:00.000'
	BEGIN 
		UPDATE pSampleRequestSubmit SET VendorDate = NULL WHERE SampleRequestSubmitID = @SampleRequestSubmitID
		SET @VendorDate  = NULL
	END 

	IF (SELECT b.ApprovedType FROM pSampleRequestSubmit  a
		INNER JOIN pSampleRequestSubmitStatus b ON a.Status =  b.StatusID
		WHERE SampleRequestSubmitID = @SampleRequestSubmitID ) = 1
	BEGIN
		---***
		---** Submit approved
		---***
		
		IF @EndDate IS NULL
			BEGIN
				SET @EndDate = @MDate 			
				UPDATE pSampleRequestSubmit SET EndDate = @MDate 
				WHERE SampleRequestSubmitID = @SampleRequestSubmitID
			END
		IF @EndBy IS NULL
			BEGIN
				UPDATE pSampleRequestSubmit SET EndBy = @MUser
				WHERE SampleRequestSubmitID = @SampleRequestSubmitID
			END

	END 



	DECLARE @vcDate as nvarchar (15) 
	IF @Status  =  4 
		BEGIN
			SET @EndDate =  GetDate()
		END
		
	IF (SELECT COUNT(*) FROM pSampleRequestSpecSize WITH (NOLOCK) 
		WHERE StyleID = @StyleID 
		AND StyleSet = @StyleSet 
		AND SampleRequestTradeID = @SampleRequestTradeID 
		AND SampleRequestWorkflowID = @SampleRequestWorkflowID AND StyleColorID = @StyleColorID) = 0
	BEGIN	

		INSERT INTO dbo.pSampleRequestSpecSize
		(SampleRequestSpecSizeID, SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, WorkflowID, StyleColorID, StyleID, SizeRange, StyleSet, 
		Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
		Col0, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9, Col10, Col11, Col12, Col13, Col14, Col15, Col16, Col17, Col18, Col19, 
		Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19)
		SELECT     NEWID(), @SampleRequestTradeID, @SampleRequestWorkflowID, @SampleWorkflowID, '{40000000-0000-0000-0000-000000000005}', @StyleColorID,
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
			SET @Month  = '0' + CAST(@Submit AS nVARCHAR(1))
		END
	ELSE
		BEGIN 
			SET @Month  = CAST(@Submit AS nVARCHAR(2))
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
				
			UPDATE    dbo.pSampleRequestWorkflow
			SET              Submit = @Submit, Status = @Status, DueDate = @DueDate, 
			--EndDate = CONVERT(nvarchar(2),@Submit) +  @vcDate, 
			EndDate = @vcDate, 
			MUser = @MUser, MDate = @MDate
			WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) 
			AND  (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
		END
	ELSE IF @Status = 1       -- RESUMIT
		BEGIN
			
			SET @vcDate =  '1900-' + @Month + '-02' 

			UPDATE    pSampleRequestWorkflow
			SET              Submit = (@Submit + 1), Status = 0, DueDate = @DueDate, 
			--EndDate = CONVERT(nvarchar(2),(@Submit + 1)) + '/2/1900', 
			EndDate = @vcDate,
			MUser = @MUser, MDate = @MDate
			WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
								  (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
		END
	ELSE IF @Status = 4       -- DROPPED 
		BEGIN
			
			SET @vcDate =  '1900-' + @Month + '-03' 

			UPDATE    dbo.pSampleRequestWorkflow
			SET              Submit = @Submit, Status = @Status, DueDate = @DueDate, 
			--EndDate = CONVERT(nvarchar(2),@Submit) + '/3/1900', 
			FinalDate = @EndDate,
			EndDate = @vcDate,
			MUser = @MUser, MDate = @MDate
			WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
				  (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
		END
	ELSE
		BEGIN				
			UPDATE dbo.pSampleRequestWorkflow
			SET  Submit = @Submit, Status = @Status, DueDate = @DueDate,EndDate = @MDate, 
			--EndDate = @EndDate, 
			MUser = @MUser, MDate = @MDate
			WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
								  (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
		END




	--***
	--** Update Material Sample 
	--***

	IF @ApprovedType = 1
		BEGIN		
			UPDATE pSampleRequestMaterial  SET Status = 3,EndDate=@MDate 
			WHERE SampleRequestTradeID = @SampleRequestTradeID
			AND SampleWorkflowID = @SampleWorkflowID
			AND Submit = @Submit
		END 

	EXEC spx_TACalendar_SampleRequestWorkflowReferences_Progress_UPDATE @SampleRequestTradeID, @SampleWorkflowID
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08862', GetDate())
GO
