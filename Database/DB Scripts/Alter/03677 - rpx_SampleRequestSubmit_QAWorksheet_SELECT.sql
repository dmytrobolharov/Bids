IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestSubmit_QAWorksheet_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestSubmit_QAWorksheet_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[rpx_SampleRequestSubmit_QAWorksheet_SELECT] (
	@SampleRequestSubmitID varchar(50),
	@SizeIndex int	
)

AS 

DECLARE	@SampleRequestTradeID varchar(255)
DECLARE	@SampleWorkflowID nvarchar(5)
DECLARE	@Submit int
DECLARE	@StyleID varchar(50)
DECLARE @StyleSet int 
DECLARE @SampleRequestWorkflowID uniqueidentifier


If ((Len(@SizeIndex) = 0) OR (@SizeIndex IS NULL))
	begin
		set @SizeIndex=0
	end

IF EXISTS (SELECT * FROM pSampleRequestSubmit WHERE SampleRequestSubmitID = @SampleRequestSubmitID)
BEGIN
	SELECT
		@SampleRequestTradeID = SampleRequestTradeID,
		@SampleWorkflowID = SampleWorkflowID,
		@Submit = Submit,
		@StyleID = StyleID,
		@StyleSet = StyleSet,	
		@SampleRequestWorkflowID = SampleRequestWorkflowID
	FROM pSampleRequestSubmit
	WHERE SampleRequestSubmitID = @SampleRequestSubmitID
END
ELSE
BEGIN
	SELECT
		@SampleRequestTradeID = SampleRequestTradeID,
		@SampleWorkflowID = SampleWorkflowID,
		@Submit = Submit,
		@StyleID = StyleID,
		@StyleSet = StyleSet,	
		@SampleRequestWorkflowID = SampleRequestWorkflowID
	FROM pSampleRequestSubmitBOM
	WHERE SampleRequestSubmitID = @SampleRequestSubmitID
END


DECLARE @Query as varchar(4000)

SET @Query = ' SELECT pSampleRequestQAWorksheet.POM, pSampleRequestQAWorksheet.PointMeasur, '
SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.TOL) AS TOL, dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.TOLN) AS TOLN, '
SET @Query = @Query + ' pSampleRequestQAWorksheet.Critical, pSampleRequestQASize.NumberOfSamples, '

IF @SizeIndex = 0
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size0 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask000) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec000) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec000, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec001) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec001, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec002) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec002, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec003) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec003, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec004) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec004, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec005) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec005, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec006) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec006, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec007) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec007, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec008) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec008, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec009) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec009, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 1
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size1 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask001) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec010) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec010, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec011) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec011, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec012) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec012, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec013) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec013, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec014) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec014, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec015) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec015, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec016) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec016, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec017) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec017, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec018) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec018, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec019) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec019, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 2
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size2 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask002) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec020) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec020, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec021) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec021, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec022) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec022, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec023) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec023, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec024) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec024, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec025) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec025, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec026) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec026, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec027) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec027, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec028) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec028, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec029) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec029, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 3
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size3 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask003) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec030) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec030, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec031) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec031, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec032) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec032, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec033) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec033, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec034) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec034, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec035) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec035, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec036) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec036, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec037) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec037, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec038) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec038, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec039) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec039, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END


IF @SizeIndex = 4
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size4 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask004) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec040) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec040, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec041) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec041, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec042) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec042, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec043) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec043, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec044) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec044, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec045) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec045, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec046) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec046, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec047) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec047, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec048) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec048, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec049) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec049, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END


IF @SizeIndex = 5
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size5 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask005) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec050) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec050, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec051) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec051, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec052) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec052, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec053) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec053, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec054) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec054, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec055) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec055, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec056) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec056, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec057) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec057, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec058) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec058, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec059) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec059, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 6
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size6 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask006) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec060) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec060, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec061) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec061, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec062) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec062, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec063) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec063, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec064) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec064, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec065) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec065, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec066) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec066, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec067) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec067, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec068) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec068, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec069) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec069, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 7
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size7 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask007) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec070) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec070, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec071) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec071, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec072) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec072, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec073) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec073, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec074) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec074, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec075) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec075, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec076) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec076, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec077) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec077, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec078) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec078, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec079) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec079, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 8
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size8 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask008) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec080) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec080, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec081) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec081, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec082) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec082, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec083) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec083, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec084) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec084, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec085) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec085, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec086) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec086, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec087) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec087, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec088) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec088, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec089) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec089, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 9
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size9 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask009) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec090) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec090, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec091) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec091, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec092) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec092, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec093) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec093, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec094) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec094, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec095) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec095, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec096) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec096, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec097) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec097, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec098) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec098, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec099) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec099, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 10
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size10 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask010) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec100) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec100, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec101) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec101, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec102) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec102, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec103) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec103, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec104) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec104, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec105) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec105, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec106) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec106, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec107) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec107, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec108) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec108, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec109) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec109, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 11
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size11 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask011) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec110) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec110, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec111) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec111, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec112) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec112, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec113) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec113, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec114) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec114, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec115) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec115, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec116) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec116, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec117) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec117, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec118) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec118, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec119) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec119, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 12
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size12 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask012) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec120) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec120, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec121) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec121, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec122) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec122, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec123) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec123, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec124) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec124, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec125) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec125, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec126) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec126, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec127) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec127, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec128) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec128, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec129) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec129, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 13
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size13 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask013) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec130) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec130, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec131) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec131, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec132) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec132, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec133) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec133, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec134) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec134, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec135) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec135, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec136) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec136, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec137) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec137, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec138) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec138, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec139) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec139, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 14
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size14 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask014) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec140) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec140, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec141) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec141, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec142) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec142, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec143) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec143, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec144) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec144, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec145) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec145, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec146) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec146, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec147) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec147, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec148) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec148, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec149) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec149, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 15
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size15 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask015) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec150) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec150, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec151) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec151, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec152) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec152, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec153) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec153, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec154) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec154, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec155) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec155, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec156) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec156, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec157) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec157, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec158) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec158, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec159) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec159, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 16
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size16 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask016) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec160) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec160, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec161) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec161, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec162) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec162, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec163) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec163, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec164) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec164, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec165) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec165, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec166) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec166, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec167) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec167, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec168) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec168, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec169) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec169, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 17
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size17 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask017) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec170) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec170, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec171) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec171, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec172) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec172, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec173) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec173, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec174) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec174, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec175) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec175, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec176) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec176, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec177) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec177, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec178) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec178, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec179) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec179, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 18
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size18 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask018) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec180) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec180, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec181) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec181, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec182) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec182, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec183) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec183, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec184) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec184, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec185) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec185, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec186) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec186, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec187) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec187, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec188) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec188, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec189) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec189, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 19
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size19 AS Size,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Ask019) AS Ask,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec190) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec190, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec191) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec191, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec192) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec192, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec193) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec193, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec194) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec194, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec195) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec195, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec196) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec196, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec197) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec197, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec198) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec198, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' dbo.fnx_Num2Frac(pSampleRequestQAWorksheet.Spec199) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec199, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

		SET @Query = @Query + ' pSampleRequestQAWorksheet.CDate, pSampleRequestQAWorksheet.CUser, pSampleRequestQAWorksheet.MDate, '
		SET @Query = @Query + ' pSampleRequestQAWorksheet.MUser, pSampleRequestQAWorksheet.Change, pSampleRequestQAWorksheet.Sort, pPOMLibrary.HowToMeasurText, '
		SET @Query = @Query + ' pPOMLibrary.HowToMeasurImage '
		SET @Query = @Query + ' FROM  pSampleRequestQAWorksheet '
		SET @Query = @Query + ' LEFT OUTER JOIN pPOMLibrary ON pSampleRequestQAWorksheet.POMLibraryID = pPOMLibrary.POMLibraryID '
		SET @Query = @Query + ' LEFT OUTER JOIN pSampleRequestQASize ON pSampleRequestQAWorksheet.SampleRequestTradeID = pSampleRequestQASize.SampleRequestTradeID '
		SET @Query = @Query + '											AND pSampleRequestQAWorksheet.SampleRequestWorkflowID = pSampleRequestQASize.SampleRequestWorkflowID '
		SET @Query = @Query + '											AND pSampleRequestQAWorksheet.SampleWorkflowID = pSampleRequestQASize.SampleWorkflowID '
		SET @Query = @Query + '											AND pSampleRequestQAWorksheet.StyleID = pSampleRequestQASize.StyleID '
		SET @Query = @Query + '											AND pSampleRequestQAWorksheet.StyleColorID = pSampleRequestQASize.StyleColorID '
		SET @Query = @Query + '											AND pSampleRequestQAWorksheet.StyleSet = pSampleRequestQASize.StyleSet '
		SET @Query = @Query + ' WHERE pSampleRequestQAWorksheet.StyleID = ''' + CAST(ISNULL(@StyleID,'') AS VARCHAR(40)) + ''''
		SET @Query = @Query + ' AND  pSampleRequestQAWorksheet.StyleSet = ''' + CAST(ISNULL(@StyleSet,'') AS VARCHAR(2)) + ''''
		SET @Query = @Query + ' AND pSampleRequestQAWorksheet.SampleRequestTradeID = ''' + CAST(ISNULL(@SampleRequestTradeID,'') AS VARCHAR(40)) + ''''
		SET @Query = @Query + ' AND pSampleRequestQAWorksheet.SampleRequestWorkflowID = ''' + CAST(ISNULL(@SampleRequestWorkflowID,'') AS VARCHAR(40)) + ''''
		SET @Query = @Query + ' AND pSampleRequestQAWorksheet.SampleWorkflowID = ''' + CAST(ISNULL(@SampleWorkflowID,'') AS VARCHAR(10)) + ''''
		SET @Query = @Query + ' AND pSampleRequestQAWorksheet.Submit = ''' + CAST(ISNULL(@Submit,'') AS VARCHAR(2)) + ''''
		SET @Query = @Query + ' ORDER BY pSampleRequestQAWorksheet.Sort, pSampleRequestQAWorksheet.POM, pSampleRequestQAWorksheet.PointMeasur '


--SELECT @Query

BEGIN
	EXEC (@Query) 
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03677', GetDate())
GO