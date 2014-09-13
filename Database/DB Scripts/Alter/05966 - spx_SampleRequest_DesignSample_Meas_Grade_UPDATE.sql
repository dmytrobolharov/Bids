/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_Grade_UPDATE]    Script Date: 07/02/2013 15:43:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_Meas_Grade_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_Grade_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_Grade_UPDATE]    Script Date: 07/02/2013 15:43:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_Grade_UPDATE]
(
    @SampleRequestAMLMeasHdrId UNIQUEIDENTIFIER,
    @SampleRequestAMLMeasPOMId UNIQUEIDENTIFIER,
    @pomrow int,
    @SizeCol int,
    @Incr numeric(18,4),
    @ModifiedBy nvarchar(204),
    @ModifiedDate datetime
)
AS
BEGIN 
	DECLARE @IsLength int
	DECLARE @IsWidth int
	DECLARE @ShrinkX numeric(18, 4)
	DECLARE @ShrinkY numeric(18, 4)
	DECLARE @BeforeTreat numeric(18, 4)
	DECLARE @MetricBeforeTreat numeric(18, 4)
	DECLARE @Changed int
	Declare @Metric int
	Declare @IsSample int
	Declare @MetricShrink int
	Declare @ImperialIncr numeric(18,4)
	Declare @ImperialBT numeric(18,4)
	SET @Changed = 0

	UPDATE pSampleRequestAMLMeasIGC 
	SET Incr = @Incr,
	MUser=@ModifiedBy,
	MDate=@ModifiedDate
	WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId
	AND SampleRequestAMLMeasPOMId = @SampleRequestAMLMeasPOMId
	AND pom_row = @pomrow
	AND SizeCol = @SizeCol
	
	select @Metric = Ismetric from pSampleRequestamlmeashdr WITH(NOLOCK) where SampleRequestamlmeashdrid = @SampleRequestAMLMeasHdrId
	Select @IsSample = IsSample from pSampleRequestAMLMeasLbl WITH(NOLOCK) WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId AND SizeCol = @SizeCol
	Select @IsLength = IsLength, @IsWidth = IsWidth, @ShrinkX = ShrinkX, @ShrinkY = ShrinkY from pSampleRequestAMLMeasPOM where SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId AND SampleRequestAMLMeasPOMId = @SampleRequestAMLMeasPOMId

	if @Metric = 1
		Begin
			SET	@ImperialIncr = @Incr
		End
	else
		begin
			SET	@ImperialIncr = @Incr  * 2.54
		end
		
	if @Incr <> 0  AND @IsSample = 1
		BEGIN
			if @IsLength <> 0
				BEGIN
					set @BeforeTreat = @ImperialIncr * (1-(@ShrinkX/100))
					set @Changed = 1
				END
			
			if @IsWidth <> 0
				BEGIN
					set @BeforeTreat = @ImperialIncr * (1-(@ShrinkY/100))
					set @Changed = 1
				END
			
			if @Changed = 1 
				BEGIN
					SET	@ImperialBT = @BeforeTreat / 2.54
					UPDATE pSampleRequestAMLMeasPOM 
					SET	BeforeTreat = @ImperialBT,
					MUser=@ModifiedBy,
					MDate=@ModifiedDate
					WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId
					AND SampleRequestAMLMeasPOMId = @SampleRequestAMLMeasPOMId		
				END
		END

END



GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05966', GetDate())
GO
