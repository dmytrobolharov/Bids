IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleLink_MeasurementSize_SampleSizeConversion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleLink_MeasurementSize_SampleSizeConversion]
GO


CREATE PROCEDURE [dbo].[spx_StyleLink_MeasurementSize_SampleSizeConversion]
	@OldAMLMeasHdrId uniqueidentifier,
	@NewAMLMeasHdrId uniqueidentifier
AS
BEGIN

declare @NewPOMTempID uniqueidentifier
Declare @OldSampleCol int
Declare @NewSampleCol int

SELECT @NewPOMTempID = CompanyId FROM pAMLMeasHdr WHERE AMLMeasHdrId = @NewAMLMeasHdrId
SELECT @OldSampleCol = convert(int,COALESCE(sizecol,'0')) FROM pAMLMeasLbl WHERE AMLMeasHdrId = @OldAMLMeasHdrId AND IsSample = 1
SELECT @NewSampleCol = convert(int,COALESCE(sizecol,'0')) FROM pAMLMeasLbl WHERE AMLMeasHdrId = @NewAMLMeasHdrId AND IsSample = 1

CREATE TABLE #tempPOM (ROWID INT IDENTITY(1,1), AMLMeasPOMId UNIQUEIDENTIFIER, POMCode NVARCHAR(50))

INSERT INTO #tempPOM (AMLMeasPOMId, POMCode) 
SELECT AMLMeasPOMId, RefCode FROM pAMLMeasPOM 
WHERE AMLMeasHdrId = @NewAMLMeasHdrId AND RefCode IS NOT NULL AND RefCode <> ''

DECLARE @AMLMeasPOMId UNIQUEIDENTIFIER
DECLARE @POMCode NVARCHAR(50)
DECLARE @Conv NUMERIC (18,4)
DECLARE @SampleSizeIncr NUMERIC (18,4)

DECLARE @iRow INT = 1
DECLARE @iCount INT = (SELECT COUNT(*) FROM #tempPOM)

WHILE @iRow <= @iCount
BEGIN
	
	SELECT @AMLMeasPOMId = AMLMeasPOMId, @POMCode = POMCode FROM #tempPOM WHERE ROWID = @iRow

	IF (SELECT COUNT(*) FROM pGRMeasurementsPOMTemplateItem WHERE POMTempID = @NewPOMTempID AND POMCode = @POMCode) > 0
	BEGIN
		SELECT TOP 1 @Conv = Conv FROM pGRMeasurementsPOMTemplateItem WHERE POMTempID = @NewPOMTempID AND POMCode = @POMCode
		SELECT TOP 1 @SampleSizeIncr = Incr FROM pAMLMeasIGC 
			INNER JOIN pAMLMeasPOM ON pAMLMeasIGC.AMLMeasPOMId = pAMLMeasPOM.AMLMeasPOMId 
				AND pAMLMeasIGC.AMLMeasHdrId = @OldAMLMeasHdrId 
				AND pAMLMeasPOM.RefCode = @POMCode
				AND pAMLMeasIGC.SizeCol = @OldSampleCol
		
		UPDATE pAMLMeasIGC SET Incr = (CASE WHEN @Conv IS NULL OR @Conv = 0 THEN 0 ELSE @Conv + @SampleSizeIncr END)
		WHERE AMLMeasHdrId = @NewAMLMeasHdrId AND SizeCol = @NewSampleCol 
		AND AMLMeasPOMId = @AMLMeasPOMId
	END
		
	SET @iRow = @iRow + 1
END

DROP TABLE #tempPOM



Declare @IsRelative int
SELECT @IsRelative = IsRelative FROM pamlmeashdr WITH (NOLOCK) WHERE AMLMeasHdrId = @NewAMLMeasHdrId

if @IsRelative=1 
	begin
		EXEC spx_StyleMeasIMRelative_UPDATE	
		@NewAMLMeasHdrId
	end
else
	begin
		EXEC spx_StyleMeasIMIncrement_UPDATE	
		@NewAMLMeasHdrId
	end	


END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07142', GetDate())
GO
