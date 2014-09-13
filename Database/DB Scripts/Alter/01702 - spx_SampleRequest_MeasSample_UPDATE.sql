-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 3 August 2011                                                                              */
-- * WorkItem #4107                                                                             */
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
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO


IF EXISTS (select * from sysobjects where id = object_id('spx_SampleRequest_MeasSample_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_SampleRequest_MeasSample_UPDATE
GO


CREATE PROCEDURE spx_SampleRequest_MeasSample_UPDATE
(
	@SampleRequestHeaderId UNIQUEIDENTIFIER,
	@SampleMeasId UNIQUEIDENTIFIER,
	@Submit INT,
	@PostRev int,
	@CopySpec int,
	@CopyRev int
)
AS 

DECLARE @SamplePomId UNIQUEIDENTIFIER
DECLARE @VdrMeasValue numeric(18,4)
DECLARE @EvalMeasValue numeric(18,4)
DECLARE @SampMeasValue numeric(18,4)
DECLARE @VdrDelta numeric(18,4)
DECLARE @SampDelta numeric(18,4)
DECLARE @Tolplus numeric(18,4)
DECLARE @TolMinus numeric(18,4)
DECLARE @RevisedSpec numeric(18,4)
DECLARE @VdrOutTol int
DECLARE @SampOutTol int
DECLARE @AMLMeasPOMId UNIQUEIDENTIFIER
DECLARE @AMLMeasHdrId UNIQUEIDENTIFIER
DECLARE @SampleSizeId UNIQUEIDENTIFIER
DECLARE @EvalSizeId UNIQUEIDENTIFIER
DECLARE @AMLMeasIGCId UNIQUEIDENTIFIER
DECLARE @POMRow int
DECLARE @IsNotEvalSameAsSampleSize int
DECLARE @EvalSizecol int
DECLARE @SampleSizecol int
DECLARE @EvalGrade numeric(18,4)
DECLARE @blnIssample int
DECLARE @SampleGrade numeric(18,4)
DECLARE @GradeDiff numeric(18,4)
DECLARE @sampleRevisedValue numeric(18,4)

SET NOCOUNT ON
SET @blnIssample = 0
SET @IsNotEvalSameAsSampleSize = 0

SELECT @SamplePomId = SamplePomId, @VdrMeasValue = VdrMeasValue, @EvalMeasValue = EvalMeasValue,
       @SampMeasValue = SampMeasValue, @RevisedSpec = RevisedSpec, @AMLMeasPOMId = AMLMeasPOMId, 
       @AMLMeasIGCId = AMLMeasIGCId, @POMRow = POMRow
FROM pMSEvalSampMeas 
WHERE SampleRequestHeaderId = @SampleRequestHeaderId 
AND sampleIndex = @Submit 
AND SampleMeasId = @SampleMeasId

IF @CopySpec = 1   
BEGIN
	SET @SampMeasValue = @VdrMeasValue
END

IF @CopyRev = 1 
BEGIN
	SET @RevisedSpec = @SampMeasValue
END
	
IF 	@CopySpec = 1 or @CopyRev = 1
BEGIN
	UPDATE pMSEvalSampMeas 
	SET SampMeasValue = @SampMeasValue, RevisedSpec = @RevisedSpec
	WHERE SampleRequestHeaderId = @SampleRequestHeaderId 
	AND sampleIndex = @Submit 
	AND SampleMeasId = @SampleMeasId
	AND SamplePomId = @SamplePomId 
	AND AMLMeasPOMId = @AMLMeasPOMId
END

SELECT @AMLMeasHdrId = AMLMeasHdrId, @EvalSizeId = EvalSizeId 
FROM pMSEvalHeader 
WHERE SampleRequestHeaderId = @SampleRequestHeaderId

SELECT @EvalSizecol = sizecol FROM pAMLMeasLbl WHERE AMLMeasHdrId = @AMLMeasHdrId AND AMLMeasLblId = @EvalSizeId
SELECT @SampleSizecol = sizecol, @SampleSizeId = AMLMeasLblId FROM pAMLMeasLbl WHERE AMLMeasHdrId = @AMLMeasHdrId AND IsSample = 1

SELECT @EvalGrade = Grade 
FROM pAMLMeasIGC 
WHERE AMLMeasHdrId = @AMLMeasHdrId 
AND AMLMeasPOMId = @AMLMeasPOMId
AND POM_Row = @POMRow 
AND Sizecol = @Evalsizecol 
AND AMLMeasIGCId = @AMLMeasIGCId

SELECT @SampleGrade = Grade 
FROM pAMLMeasIGC 
WHERE AMLMeasHdrId = @AMLMeasHdrId 
AND AMLMeasPOMId = @AMLMeasPOMId
AND POM_Row = @POMRow 
AND Sizecol = @SampleSizecol

SELECT @Tolplus = Tolplus, @TolMinus = TolMinus 
FROM pmsevalpom 
WHERE SamplePomId = @SamplePomId
AND AMLMeasPOMId = @AMLMeasPOMId 
AND SampleRequestHeaderId = @SampleRequestHeaderId

SET @GradeDiff = @EvalGrade - @SampleGrade

SET @sampleRevisedValue = @RevisedSpec - @GradeDiff

IF @RevisedSpec <> 0
BEGIN
	IF @SampleSizeId = @EvalSizeId	
	BEGIN
		SET @blnIssample = 1
		IF @EvalGrade = @RevisedSpec
		BEGIN
			SET @IsNotEvalSameAsSampleSize = 0
		END
		ELSE
		BEGIN
			SET @IsNotEvalSameAsSampleSize = 1
		END
	END
	ELSE
	BEGIN
		SET @blnIssample = 0
		IF @EvalGrade = @RevisedSpec
		BEGIN
			SET @IsNotEvalSameAsSampleSize = 0
		END
		ELSE
		BEGIN
			SET @IsNotEvalSameAsSampleSize = 1
		END
	END
END

IF @EvalMeasValue <> 0
BEGIN
	IF @VdrMeasValue = 0 
	BEGIN
		SET @VdrDelta = 0	
		SET @VdrOutTol = 0
	END
	ELSE
	BEGIN
		SET @VdrDelta = @VdrMeasValue - @EvalMeasValue
		IF @VdrDelta >= @TolMinus AND @VdrDelta <= @Tolplus
		BEGIN
			SET @VdrOutTol = 0
		END
		ELSE
		BEGIN
			SET @VdrOutTol = 1
		END
	END
		
	IF @sampMeasValue = 0 
	BEGIN
		SET @SampDelta = 0	
		SET @SampOutTol = 0
	END
	ELSE
	BEGIN
		SET @SampDelta = @sampMeasValue - @EvalMeasValue
		IF @SampDelta >= @TolMinus AND @SampDelta <= @Tolplus
		BEGIN
			SET @SampOutTol = 0
		END
		ELSE
		BEGIN
			SET @SampOutTol = 1
		END
	END
		
	UPDATE pMSEvalSampMeas 
	SET VdrDelta = @VdrDelta, SampDelta = @SampDelta, VdrOutTol = @VdrOutTol, SampOutTol = @SampOutTol 
	WHERE SampleRequestHeaderId = @SampleRequestHeaderId 
	AND sampleIndex = @Submit 
	AND SampleMeasId = @SampleMeasId
END

IF @RevisedSpec <> 0 AND @PostRev = 1
BEGIN
	IF @blnIssample = 1 
	BEGIN
		IF @IsNotEvalSameAsSampleSize = 1
		BEGIN
			EXEC spx_SampleRequest_MeasReviseSample_UPDATE
			@AMLMeasHdrId,
			@AMLMeasPomId, 
			@POMRow,						
			@SampleSizeCol,
			@RevisedSpec
		END
	END
	ELSE
	BEGIN
		IF @IsNotEvalSameAsSampleSize = 1
		BEGIN
			EXEC spx_SampleRequest_MeasReviseSample_UPDATE
			@AMLMeasHdrId,
			@AMLMeasPomId, 
			@POMRow,						
			@SampleSizeCol,
			@sampleRevisedValue
		END
	END
	SET NOCOUNT OFF
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01702', GetDate())
GO

SET NOCOUNT Off
GO
