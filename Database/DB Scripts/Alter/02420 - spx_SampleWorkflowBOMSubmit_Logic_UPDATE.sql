-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowBOMSubmit_Logic_UPDATE]    Script Date: 12/18/2011 18:42:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowBOMSubmit_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmit_Logic_UPDATE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowBOMSubmit_Logic_UPDATE]    Script Date: 12/18/2011 18:42:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



Create PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmit_Logic_UPDATE]( 
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
DECLARE @ItemDim1Id UNIQUEIDENTIFIER = null,
@ItemDim2Id UNIQUEIDENTIFIER = null,
@ItemDim3Id UNIQUEIDENTIFIER = null
DECLARE @SampleRequestSubmitID UNIQUEIDENTIFIER


SELECT @RevDate = a.RevDate, @RevBy = a.RevBy, @ApprovedType = b.ApprovedType,
@EndDate = a.EndDate, @EndBy = ISNULL(a.EndBy,''), @Status = a.Status,
@SampleRequestWorkflowID  = a.SampleRequestWorkflowID, @ItemDim1Id = a.ItemDim1Id,@ItemDim2Id = a.ItemDim2Id,@ItemDim3Id = a.ItemDim3Id,
@SampleRequestSubmitID = a.SampleRequestSubmitID
FROM pSampleRequestSubmitBOM a
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

IF (SELECT COUNT(*) FROM pSampleRequestSpecSizeBOM WITH (NOLOCK) WHERE StyleID = @StyleID 
	AND StyleSet = @StyleSet AND SampleRequestTradeID = @SampleRequestTradeID 
	AND SampleRequestWorkflowID = @SampleRequestWorkflowID AND @ItemDim1Id = ItemDim1Id AND @ItemDim2Id = ItemDim2Id AND @ItemDim3Id = ItemDim3Id) = 0
BEGIN	
	INSERT INTO dbo.pSampleRequestSpecSizeBOM
	(SampleRequestSpecSizeID, SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, WorkflowID, StyleID, SizeRange, StyleSet, 
	Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
	Col0, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9, Col10, Col11, Col12, Col13, Col14, Col15, Col16, Col17, Col18, Col19, 
	Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19)
	SELECT     NEWID(), @SampleRequestTradeID, @SampleRequestWorkflowID, @SampleWorkflowID, '{40000000-0000-0000-0000-000000000005}',
	StyleID, SizeRange, @StyleSet, 
	Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0 ,0 ,0 ,0 ,0 ,0, 
	Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19
	FROM dbo.pStyleSpecSize WITH (NOLOCK) WHERE (StyleID = @StyleID)
END



UPDATE pSampleRequestSubmitBOM
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
	EndDate = @vcDate,
	MUser = @MUser, MDate = @MDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
		 (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
END
ELSE
BEGIN
	UPDATE dbo.pSampleRequestWorkflowBOM
	SET              Submit = @Submit, Status = @Status, DueDate = @DueDate, EndDate = @EndDate, MUser = @MUser, MDate = @MDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
						  (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 
END











GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02420'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02420', GetDate())

END

GO
