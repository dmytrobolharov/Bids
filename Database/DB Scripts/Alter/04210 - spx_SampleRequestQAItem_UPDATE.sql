IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestQAItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestQAItem_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestQAItem_UPDATE]
(
	@SampleRequestQAWorksheetID uniqueidentifier,
	@Submit int,
	@SizeIndex int,
	@WashType nvarchar(20),
	@Pom nvarchar(10),
	@PomMeasurment nvarchar(200),
	@Tol numeric(18,4),
	@TolN numeric(18,4),
	@Spec numeric(18,4),
	@Spec0 numeric(18,4),
	@Spec1 numeric(18,4),
	@Spec2 numeric(18,4),
	@Spec3 numeric(18,4),
	@Spec4 numeric(18,4),
	@Spec5 numeric(18,4),
	@Spec6 numeric(18,4),
	@Spec7 numeric(18,4),
	@Spec8 numeric(18,4),
	@Spec9 numeric(18,4),
	@ModifiedBy nvarchar(200),
	@ModifiedDate datetime
)

AS 

DECLARE @Query as nvarchar(max)

SET @Query ='UPDATE pSampleRequestQAWorksheet SET '
SET @Query = @Query + ' pSampleRequestQAWorksheet.POM = N''' + ISNULL(@POM,'') + ''','
SET @Query = @Query + ' pSampleRequestQAWorksheet.PointMeasur = N''' + ISNULL(@PomMeasurment,'') + ''','
IF @WashType = 'NOWASH'
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.TOLN = ' + CAST(ISNULL(@TOLN,0) AS VARCHAR(10)) + ','
	END
ELSE
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.TOL = ' + CAST(ISNULL(@TOL,0) AS VARCHAR(10)) + ','
	END

IF @SizeIndex = 0
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask000 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec000 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec001 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec002 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec003 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec004 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec005 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec006 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec007 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec008 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec009 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 1
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask001 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec010 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec011 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec012 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec013 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec014 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec015 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec016 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec017 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec018 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec019 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 2
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask002 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec020 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec021 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec022 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec023 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec024 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec025 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec026 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec027 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec028 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec029 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 3
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask003 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec030 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec031 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec032 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec033 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec034 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec035 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec036 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec037 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec038 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec039 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END


IF @SizeIndex = 4
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask004 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec040 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec041 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec042 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec043 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec044 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec045 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec046 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec047 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec048 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec049 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END


IF @SizeIndex = 5
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask005 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec050 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec051 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec052 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec053 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec054 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec055 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec056 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec057 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec058 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec059 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 6
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask006 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec060 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec061 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec062 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec063 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec064 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec065 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec066 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec067 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec068 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec069 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 7
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask007 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec070 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec071 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec072 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec073 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec074 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec075 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec076 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec077 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec078 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec079 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 8
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask008 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec080 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec081 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec082 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec083 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec084 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec085 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec086 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec087 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec088 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec089 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 9
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask009 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec090 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec091 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec092 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec093 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec094 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec095 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec096 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec097 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec098 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec099 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 10
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask010 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec100 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec101 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec102 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec103 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec104 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec105 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec106 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec107 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec108 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec109 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 11
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask011 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec110 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec111 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec112 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec113 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec114 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec115 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec116 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec117 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec118 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec119 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 12
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask012 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec120 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec121 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec122 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec123 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec124 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec125 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec126 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec127 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec128 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec129 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 13
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask013 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec130 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec131 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec132 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec133 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec134 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec135 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec136 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec137 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec138 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec139 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 14
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask014 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec140 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec141 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec142 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec143 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec144 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec145 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec146 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec147 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec148 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec149 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 15
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask015 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec150 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec151 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec152 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec153 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec154 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec155 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec156 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec157 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec158 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec159 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 16
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask016 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec160 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec161 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec162 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec163 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec164 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec165 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec166 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec167 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec168 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec169 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 17
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask017 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec170 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec171 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec172 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec173 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec174 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec175 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec176 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec177 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec178 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec179 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 18
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask018 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec180 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec181 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec182 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec183 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec184 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec185 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec186 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec187 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec188 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec189 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

IF @SizeIndex = 19
	BEGIN
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Ask019 = ' + CAST(ISNULL(@Spec,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec190 = ' + CAST(ISNULL(@Spec0,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec191 = ' + CAST(ISNULL(@Spec1,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec192 = ' + CAST(ISNULL(@Spec2,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec193 = ' + CAST(ISNULL(@Spec3,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec194 = ' + CAST(ISNULL(@Spec4,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec195 = ' + CAST(ISNULL(@Spec5,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec196 = ' + CAST(ISNULL(@Spec6,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec197 = ' + CAST(ISNULL(@Spec7,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec198 = ' + CAST(ISNULL(@Spec8,0) AS VARCHAR(10)) + ','
		SET @Query = @Query + ' pSampleRequestQAWorksheet.Spec199 = ' + CAST(ISNULL(@Spec9,0) AS VARCHAR(10)) + ','		
	END

	SET @Query = @Query + ' pSampleRequestQAWorksheet.MDate = ''' + CAST(ISNULL(@ModifiedDate,'') AS VARCHAR(40)) + ''','
	SET @Query = @Query + ' pSampleRequestQAWorksheet.MUser = ''' + CAST(ISNULL(@ModifiedBy ,'') AS NVARCHAR(200)) + ''''
	SET @Query = @Query + ' WHERE pSampleRequestQAWorksheet.SampleRequestQAWorksheetID = ''' + CAST(ISNULL(@SampleRequestQAWorksheetID,'') AS VARCHAR(40)) + '''' 

--
--SELECT @Query

BEGIN
	EXEC (@Query) 
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04210', GetDate())
GO
