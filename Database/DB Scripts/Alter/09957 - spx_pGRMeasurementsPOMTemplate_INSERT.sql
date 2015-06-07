IF OBJECT_ID(N'[dbo].[spx_pGRMeasurementsPOMTemplate_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplate_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplate_INSERT]
(
	@POMTempID  UNIQUEIDENTIFIER,
	@POMTempGroupId  UNIQUEIDENTIFIER,
	@POMType NVARCHAR(100),
	@POMDesc NVARCHAR(200),
	@ClassRangeId NVARCHAR(50),
	@Relative INT,
	@Negative INT,
	@Metric INT,
	@CUser NVARCHAR(200),
	@CDate DATETIME
)
AS

	DECLARE @SizeClassId NVARCHAR(50)
	DECLARE @SizeRangeId NVARCHAR(50)
	DECLARE @IncrCols NVARCHAR(2000)
	DECLARE @Maxcount INT
	DECLARE @RowCnt INT
	DECLARE @query NVARCHAR(max)
	DECLARE @sTemplatecol NVARCHAR(3)

BEGIN

	SET @Maxcount=49
	SET @RowCnt =0
	SET @IncrCols = ''

	SELECT @SizeClassId = SizeClassId, @SizeRangeId = SizeRangeId
	FROM pGRMeasurementsClassRange mcr
	LEFT JOIN pSizeClass sc ON sc.CustomID = mcr.SizeClassId
	LEFT JOIN pSizeRange sr ON sr.customId = mcr.SizeRangeId
	WHERE mcr.ClassRangeId = @ClassRangeId

	--Get Template samplesizecolumn
	WHILE @RowCnt <= @Maxcount
	BEGIN
		SET @IncrCols = @IncrCols + 'Sel' + CONVERT(NVARCHAR(3), @RowCnt) + ','				
		set @RowCnt = @RowCnt + 1
	END	
	IF RIGHT(@IncrCols,1)=',' SET @IncrCols = SUBSTRING(@IncrCols, 1, LEN(@IncrCols) - 1)		
	
	CREATE TABLE #tempSampleSize (
		sizeRowid int NOT NULL IDENTITY (0, 1),
		Sampleid NVARCHAR(10) COLLATE database_default,
		SampleSel INT)	
			 		 
	SET @query = N'SELECT Sampleid, SampleSel FROM 
		(SELECT ' + @IncrCols + ' FROM pSizeRange
		 WHERE CustomId = ''' + CONVERT(NVARCHAR(50),@SizeRangeId) + ''') p 
		UNPIVOT
		(SampleSel FOR Sampleid IN (' + @IncrCols + ')) AS unpvt 
		WHERE SampleSel = 1;'

	SELECT @query AS igcqry

	INSERT #tempSampleSize EXEC (@query) 
	--select * from #tempSampleSize

	SELECT @sTemplatecol = SUBSTRING(Sampleid, 4, LEN(Sampleid)) FROM #tempSampleSize

	DROP TABLE #tempSampleSize

	INSERT INTO pGRMeasurementsPOMTemplateGroup (
		POMTempGroupId, POMTempID, POMType, POMTypeDescription, SizeClassId, SizeRangeId, 
		ClassRangeId, [Relative], Negative, Metric, Active, Cuser, Cdate, Mdate, MUser)
	VALUES (
		@POMTempGroupId, @POMTempID, @POMType, @POMDesc, @SizeClassId, @SizeRangeId,
        @ClassRangeId, @Relative, @Negative, @Metric, 1, @CUser, @CDate, @CDate, @CUser)

	INSERT INTO pGRMeasurementsPOMTemplate (
		POMTempID, POMTempGroupId, POMType, POMTypeDescription, SizeClassId, SizeRangeId,
		ClassRangeId, SampleSize, CUser, CDate, MDate, MUser, Active,
		Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10,
		Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, Size20,
		Size21, Size22, Size23, Size24, Size25, Size26, Size27, Size28, Size29, Size30, 
		Size31, Size32, Size33, Size34, Size35, Size36, Size37, Size38, Size39, Size40, 
		Size41, Size42, Size43, Size44, Size45, Size46, Size47, Size48, Size49)
	SELECT @POMTempID, @POMTempGroupId, @POMType, @POMDesc, @SizeClassId, CustomId,
		   @ClassRangeId, @sTemplatecol, @CUser, @CDate, @CDate, @CUser, 1,
		   Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10,
		   Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, Size20,
		   Size21, Size22, Size23, Size24, Size25, Size26, Size27, Size28, Size29, Size30, 
		   Size31, Size32, Size33, Size34, Size35, Size36, Size37, Size38, Size39, Size40, 
		   Size41, Size42, Size43, Size44, Size45, Size46, Size47, Size48, Size49
	FROM pSizeRange
	WHERE CustomId = @SizeRangeId

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09957', GetUTCDate())
GO

