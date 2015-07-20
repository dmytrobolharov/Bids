/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasWorkflowSubmit_Logic_UPDATE]    Script Date: 05/21/2013 17:57:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_MeasWorkflowSubmit_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_MeasWorkflowSubmit_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest_MeasWorkflowSubmit_Logic_UPDATE]( 
@StyleID UNIQUEIDENTIFIER ,
@StyleSet INT,
@SampleRequestTradeID UNIQUEIDENTIFIER,
@SampleWorkflowID NVARCHAR(5),
@Submit INT, 
@MUser NVARCHAR(200),
@MDate DATETIME ,
@AllowSampleRevStatusAutoFill INT, 
@LockVendors INT
)
AS 



DECLARE @RevDate DATETIME 
DECLARE @RevBy NVARCHAR(200)
DECLARE @EndDate DATETIME
DECLARE @EndBy NVARCHAR(200)
DECLARE @ApprovedType INT
DECLARE @Status INT
DECLARE @DueDate DATETIME
DECLARE @SampleRequestWorkflowID UNIQUEIDENTIFIER
DECLARE @StyleColorID  UNIQUEIDENTIFIER
DECLARE @SampleRequestSubmitID UNIQUEIDENTIFIER


SELECT @RevDate = a.RevDate, @RevBy = a.RevBy, @ApprovedType = b.ApprovedType,
@EndDate = a.EndDate, @EndBy = ISNULL(a.EndBy,''), @Status = a.Status,
@SampleRequestWorkflowID  = a.SampleRequestWorkflowID, @StyleColorID = a.StyleColorID,
@SampleRequestSubmitID = a.SampleRequestSubmitID, @DueDate = a.DueDate
FROM pSampleRequestSubmit a
INNER JOIN pSampleRequestSubmitStatus b ON a.Status =  b.StatusID
WHERE a.SampleRequestTradeID = @SampleRequestTradeID 
AND a.SampleWorkflowID = @SampleWorkflowID
AND a.Submit = @Submit


IF @RevDate < '1910-01-01 00:00:00.000' SET @RevDate = NULL
IF @EndDate < '1910-01-01 00:00:00.000' SET @EndDate = NULL

IF @RevDate IS NULL
BEGIN
	IF @AllowSampleRevStatusAutoFill = 1
		SELECT @RevDate = @MDate, @RevBy = @MUser
	ELSE
		SELECT @RevDate = NULL, @RevBy = NULL
END 
	

IF @ApprovedType = 1
BEGIN
	IF @EndDate IS NULL SET @EndDate =@MDate 
	IF LEN ( @EndBy ) = 0 SET @EndBy = @MUser
END 	

--***
--** Logic from spx_SampleWorkflowSubmit_UPDATE
--***

IF @Status = 4 
	SET @EndDate = @MDate


UPDATE pSampleRequestSubmit
SET RevDate = @RevDate, EndDate = @EndDate, RevBy = @RevBy, @EndBy = EndBy
WHERE SampleRequestSubmitID = @SampleRequestSubmitID

DECLARE @vcDate as varchar (15) 



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
	SET              Submit = @Submit, Status = @Status, DueDate = @DueDate, EndDate = @EndDate, MUser = @MUser, MDate = @MDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
						  (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05761', GetDate())
GO
