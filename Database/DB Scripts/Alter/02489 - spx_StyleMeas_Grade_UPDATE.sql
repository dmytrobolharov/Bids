IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_Grade_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_Grade_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


Create PROCEDURE [dbo].[spx_StyleMeas_Grade_UPDATE]
(
    @AMLMeasHdrId UNIQUEIDENTIFIER,
    @AMLMeasPOMId UNIQUEIDENTIFIER,
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

	UPDATE pAMLMeasIGC 
	SET Incr = @Incr,
	MUser=@ModifiedBy,
	MDate=@ModifiedDate
	WHERE AMLMeasHdrId = @AMLMeasHdrId
	AND AMLMeasPOMId = @AMLMeasPOMId
	AND pom_row = @pomrow
	AND SizeCol = @SizeCol
	
	select @Metric = Ismetric from pamlmeashdr WITH(NOLOCK) where amlmeashdrid = @AMLMeasHdrId
	Select @IsSample = IsSample from pAMLMeasLbl WITH(NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId AND SizeCol = @SizeCol
	Select @IsLength = IsLength, @IsWidth = IsWidth, @ShrinkX = ShrinkX, @ShrinkY = ShrinkY from pAMLMeasPOM where AMLMeasHdrId = @AMLMeasHdrId AND AMLMeasPOMId = @AMLMeasPOMId

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
			if @IsLength <> 0 AND @ShrinkX <> 0
				BEGIN
					set @BeforeTreat = @ImperialIncr * (1-(@ShrinkX/100))
					set @Changed = 1
				END
			
			if @IsWidth <> 0 AND @ShrinkY <> 0
				BEGIN
					set @BeforeTreat = @ImperialIncr * (1-(@ShrinkY/100))
					set @Changed = 1
				END
			
			if @Changed = 1 
				BEGIN
					SET	@ImperialBT = @BeforeTreat  / 2.54
					UPDATE pAMLMeasPOM 
					SET	BeforeTreat = @ImperialBT,
					MUser=@ModifiedBy,
					MDate=@ModifiedDate
					WHERE AMLMeasHdrId = @AMLMeasHdrId
					AND AMLMeasPOMId = @AMLMeasPOMId		
				END
		END

END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02489'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02489', GetDate())

END

GO