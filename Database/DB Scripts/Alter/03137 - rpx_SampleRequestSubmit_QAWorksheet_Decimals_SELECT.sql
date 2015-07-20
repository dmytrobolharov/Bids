IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'rpx_SampleRequestSubmit_QAWorksheet_Decimals_SELECT')
   DROP PROCEDURE rpx_SampleRequestSubmit_QAWorksheet_Decimals_SELECT
GO


CREATE PROCEDURE rpx_SampleRequestSubmit_QAWorksheet_Decimals_SELECT (
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

SELECT
	@SampleRequestTradeID = SampleRequestTradeID,
	@SampleWorkflowID = SampleWorkflowID,
	@Submit = Submit,
	@StyleID = StyleID,
	@StyleSet = StyleSet,	
	@SampleRequestWorkflowID = SampleRequestWorkflowID
FROM pSampleRequestSubmit
WHERE SampleRequestSubmitID = @SampleRequestSubmitID


DECLARE @Query as varchar(4000)

SET @Query = ' SELECT pSampleRequestQAWorksheet.POM, pSampleRequestQAWorksheet.PointMeasur, '
SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.TOL AS DECIMAL(8,3)) AS TOL, CAST(pSampleRequestQAWorksheet.TOLN AS DECIMAL(8,3)) AS TOLN, '
SET @Query = @Query + ' pSampleRequestQAWorksheet.Critical, pSampleRequestQASize.NumberOfSamples, '

IF @SizeIndex = 0
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size0 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask000 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec000 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec000, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec001 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec001, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec002 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec002, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec003 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec003, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec004 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec004, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec005 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec005, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec006 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec006, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec007 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec007, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec008 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec008, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec009 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask000, pSampleRequestQAWorksheet.Spec009, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 1
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size1 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask001 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec010 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec010, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec011 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec011, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec012 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec012, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec013 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec013, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec014 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec014, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec015 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec015, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec016 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec016, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec017 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec017, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec018 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec018, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec019 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask001, pSampleRequestQAWorksheet.Spec019, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 2
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size2 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask002 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec020 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec020, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec021 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec021, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec022 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec022, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec023 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec023, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec024 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec024, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec025 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec025, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec026 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec026, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec027 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec027, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec028 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec028, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec029 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask002, pSampleRequestQAWorksheet.Spec029, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 3
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size3 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask003 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec030 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec030, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec031 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec031, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec032 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec032, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec033 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec033, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec034 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec034, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec035 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec035, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec036 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec036, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec037 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec037, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec038 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec038, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec039 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask003, pSampleRequestQAWorksheet.Spec039, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END


IF @SizeIndex = 4
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size4 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask004 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec040 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec040, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec041 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec041, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec042 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec042, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec043 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec043, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec044 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec044, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec045 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec045, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec046 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec046, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec047 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec047, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec048 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec048, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec049 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask004, pSampleRequestQAWorksheet.Spec049, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END


IF @SizeIndex = 5
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size5 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask005 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec050 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec050, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec051 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec051, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec052 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec052, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec053 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec053, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec054 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec054, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec055 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec055, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec056 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec056, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec057 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec057, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec058 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec058, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec059 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask005, pSampleRequestQAWorksheet.Spec059, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 6
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size6 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask006 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec060 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec060, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec061 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec061, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec062 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec062, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec063 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec063, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec064 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec064, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec065 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec065, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec066 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec066, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec067 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec067, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec068 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec068, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec069 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask006, pSampleRequestQAWorksheet.Spec069, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 7
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size7 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask007 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec070 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec070, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec071 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec071, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec072 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec072, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec073 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec073, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec074 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec074, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec075 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec075, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec076 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec076, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec077 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec077, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec078 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec078, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec079 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask007, pSampleRequestQAWorksheet.Spec079, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 8
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size8 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask008 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec080 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec080, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec081 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec081, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec082 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec082, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec083 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec083, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec084 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec084, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec085 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec085, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec086 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec086, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec087 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec087, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec088 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec088, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec089 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask008, pSampleRequestQAWorksheet.Spec089, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 9
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size9 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask009 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec090 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec090, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec091 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec091, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec092 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec092, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec093 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec093, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec094 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec094, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec095 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec095, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec096 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec096, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec097 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec097, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec098 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec098, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec099 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask009, pSampleRequestQAWorksheet.Spec099, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 10
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size10 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask010 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec100 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec100, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec101 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec101, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec102 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec102, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec103 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec103, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec104 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec104, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec105 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec105, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec106 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec106, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec107 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec107, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec108 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec108, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec109 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask010, pSampleRequestQAWorksheet.Spec109, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 11
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size11 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask011 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec110 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec110, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec111 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec111, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec112 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec112, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec113 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec113, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec114 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec114, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec115 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec115, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec116 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec116, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec117 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec117, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec118 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec118, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec119 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask011, pSampleRequestQAWorksheet.Spec119, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 12
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size12 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask012 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec120 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec120, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec121 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec121, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec122 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec122, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec123 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec123, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec124 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec124, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec125 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec125, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec126 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec126, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec127 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec127, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec128 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec128, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec129 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask012, pSampleRequestQAWorksheet.Spec129, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 13
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size13 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask013 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec130 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec130, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec131 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec131, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec132 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec132, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec133 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec133, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec134 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec134, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec135 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec135, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec136 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec136, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec137 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec137, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec138 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec138, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec139 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask013, pSampleRequestQAWorksheet.Spec139, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 14
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size14 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask014 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec140 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec140, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec141 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec141, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec142 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec142, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec143 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec143, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec144 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec144, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec145 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec145, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec146 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec146, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec147 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec147, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec148 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec148, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec149 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask014, pSampleRequestQAWorksheet.Spec149, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 15
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size15 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask015 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec150 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec150, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec151 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec151, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec152 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec152, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec153 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec153, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec154 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec154, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec155 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec155, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec156 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec156, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec157 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec157, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec158 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec158, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec159 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask015, pSampleRequestQAWorksheet.Spec159, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 16
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size16 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask016 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec160 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec160, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec161 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec161, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec162 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec162, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec163 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec163, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec164 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec164, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec165 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec165, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec166 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec166, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec167 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec167, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec168 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec168, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec169 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask016, pSampleRequestQAWorksheet.Spec169, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 17
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size17 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask017 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec170 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec170, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec171 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec171, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec172 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec172, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec173 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec173, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec174 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec174, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec175 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec175, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec176 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec176, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec177 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec177, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec178 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec178, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec179 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask017, pSampleRequestQAWorksheet.Spec179, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 18
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size18 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask018 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec180 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec180, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec181 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec181, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec182 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec182, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec183 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec183, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec184 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec184, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec185 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec185, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec186 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec186, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec187 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec187, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec188 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec188, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec189 AS DECIMAL(8,3)) AS Spec9,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask018, pSampleRequestQAWorksheet.Spec189, pSampleRequestQAWorksheet.TOL) AS TolFlag9,'
	END

IF @SizeIndex = 19
	BEGIN
		SET @Query = @Query + ' pSampleRequestQASize.Size19 AS Size,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Ask019 AS DECIMAL(8,3)) AS Ask,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec190 AS DECIMAL(8,3)) AS Spec0,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec190, pSampleRequestQAWorksheet.TOL) AS TolFlag0,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec191 AS DECIMAL(8,3)) AS Spec1,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec191, pSampleRequestQAWorksheet.TOL) AS TolFlag1,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec192 AS DECIMAL(8,3)) AS Spec2,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec192, pSampleRequestQAWorksheet.TOL) AS TolFlag2,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec193 AS DECIMAL(8,3)) AS Spec3,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec193, pSampleRequestQAWorksheet.TOL) AS TolFlag3,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec194 AS DECIMAL(8,3)) AS Spec4,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec194, pSampleRequestQAWorksheet.TOL) AS TolFlag4,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec195 AS DECIMAL(8,3)) AS Spec5,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec195, pSampleRequestQAWorksheet.TOL) AS TolFlag5,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec196 AS DECIMAL(8,3)) AS Spec6,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec196, pSampleRequestQAWorksheet.TOL) AS TolFlag6,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec197 AS DECIMAL(8,3)) AS Spec7,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec197, pSampleRequestQAWorksheet.TOL) AS TolFlag7,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec198 AS DECIMAL(8,3)) AS Spec8,'
		SET @Query = @Query + ' dbo.fnx_ToleranceFlag(pSampleRequestQAWorksheet.Ask019, pSampleRequestQAWorksheet.Spec198, pSampleRequestQAWorksheet.TOL) AS TolFlag8,'
		SET @Query = @Query + ' CAST(pSampleRequestQAWorksheet.Spec199 AS DECIMAL(8,3)) AS Spec9,'
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
VALUES ('DB_Version', '4.1.0000', '03137', GetDate())
GO