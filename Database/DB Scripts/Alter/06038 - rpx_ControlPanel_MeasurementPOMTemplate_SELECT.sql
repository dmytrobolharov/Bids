IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ControlPanel_MeasurementPOMTemplate_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_ControlPanel_MeasurementPOMTemplate_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_ControlPanel_MeasurementPOMTemplate_SELECT]
(
	@POMTempID VARCHAR(50)
)
AS
BEGIN
	
	
	DECLARE @Maxcount	INT
	DECLARE @RowCnt		INT
	DECLARE @IncrCols 	VARCHAR(8000)
	DECLARE @IncrCols2  VARCHAR(8000)
	DECLARE @Query		NVARCHAR(MAX)
	
	DECLARE @IsRelative	INT
	DECLARE @IsNegative	INT
	DECLARE @IsMetric	INT

	SET @RowCnt		=	0
	SET @Maxcount	=	49
	SET @IncrCols	=	''
	SET @IncrCols2	=	''
	
	SELECT
	@IsRelative=[Relative]
	,@IsNegative=Negative
	,@IsMetric = Metric 
	FROM pGRMeasurementsPOMTemplateGroup
	WHERE POMTempID=@POMTempID

	WHILE @RowCnt <= @Maxcount
	BEGIN
		SET @IncrCols = @IncrCols + 'Incr' + CONVERT(NVARCHAR(3), @RowCnt) + ','
		SET @IncrCols2 = @IncrCols2 + 'ISNULL(Incr' + CONVERT(NVARCHAR(3), @RowCnt) + ',0) as Incr' + CONVERT(NVARCHAR(3), @RowCnt) + ','
		SET @RowCnt = @RowCnt + 1
	END
	IF RIGHT(@IncrCols,1)=',' SET @IncrCols=SUBSTRING(@IncrCols, 1, LEN(@IncrCols)-1)
	IF RIGHT(@IncrCols2,1)=',' SET @IncrCols2=SUBSTRING(@IncrCols2, 1, LEN(@IncrCols2)-1)
	
	/*--------Create Temporary Table to Hold Basic Required Data-------*/
	
	BEGIN	
		CREATE TABLE #tblMeasurementPOM 
		(
			SizeRowid			INT NOT NULL IDENTITY (0, 1)
			,Critical			INT
			,POMCode			NVARCHAR(50)
			,POMDesc			NVARCHAR(200)
			,TolPlus			NUMERIC(18,4)
			,TolMinus			NUMERIC(18,4)				 
			,POMTempID			UNIQUEIDENTIFIER
			,SizeColumnName		NVARCHAR(10)
			,SizeColumnValue	NVARCHAR(10)
			,POMSort			INT
			,AlternatesDesc		NVARCHAR(500)
		)
	END
	
	/*----------Convert Columns into Rows------------------------*/
	BEGIN		
		SET @Query = N'SELECT Critical,POMCode,POMDesc,TolPlus,TolMinus,POMTempID,SizeColumnName,SizeColumnValue,POMSort,AlternatesDesc
		FROM 
		(SELECT Critical,POMCode,POMDesc,TolPlus,TolMinus,POMTempID, ' + @IncrCols2 + ',POMSort,AlternatesDesc FROM pGRMeasurementsPOMTemplateItem
		WHERE POMTempID = ''' + CONVERT(NVARCHAR(50),@POMTempID) + ''') p
		UNPIVOT
		(SizeColumnValue For SizeColumnName IN (' + @IncrCols + ')) as unpvt;'
	END

	/*--------Insert Data into Temporary Table -----------------*/
	BEGIN
		INSERT #tblMeasurementPOM EXEC (@Query) 
	END
	
	/*---------Prepare To Insert Into Final Table From Final Select Query-----------------------*/
	
	BEGIN
		SELECT A.SizeRowid,
		A.Critical,
		A.POMCode,
		A.POMDesc,
		A.TolPlus,
		A.TolMinus,
		CONVERT(NVARCHAR(50),A.POMTempID) AS POMTempID ,
		RTRIM(LTRIM(REPLACE(A.SizeColumnName,'Incr','Size'))) AS SizeColumnName,
		A.SizeColumnValue,
		A.POMSort,
		C.SizeClass + ' (' + C.SizeRange + ')' AS SizeClassRangeStr,
		A.AlternatesDesc		
		INTO #tblFinalTable 
		FROM #tblMeasurementPOM A LEFT OUTER JOIN pGRMeasurementsPOMTemplateGroup B ON
		A.POMTempID = B.POMTempID LEFT OUTER JOIN pGRMeasurementsPOMTemplate C ON
		B.POMTempID = C.POMTempID
		WHERE C.POMTempID = @POMTempID
		ORDER BY A.POMSort,A.POMCode,A.SizeRowid
	END
	
	/*---------Prepare To Update Final Table for Size Column Names-----------------------*/
	
	BEGIN
	
		DECLARE @TotalRowCount			INT
		DECLARE @RowCnt1				INT
		DECLARE @Query1					NVARCHAR(MAX)
		DECLARE @Query2					NVARCHAR(MAX)
		DECLARE @ColumnName				NVARCHAR(20)		
		
		SELECT @TotalRowCount = COUNT(*) from #tblFinalTable 
		
		SET @RowCnt1 = 0
		
		WHILE ( @TotalRowCount > 0)
			BEGIN
				
				IF @RowCnt1>49
				BEGIN
					SET @RowCnt1=0 
				END
				
				SET @ColumnName='Size'+CONVERT(VARCHAR(5),@RowCnt1)
								
				SET @Query2	=	'SELECT ' +  @ColumnName+''
				SET @Query2	=	@Query2	+ '	FROM pGRMeasurementsPOMTemplate'
				SET @Query2	=	@Query2	+ '	WHERE POMTempID='''+CONVERT(NVARCHAR(50),@POMTempID)+''''
				
				SET @Query1	=	'UPDATE #tblFinalTable'
				SET @Query1	=	@Query1+	'	SET SizeColumnName=('+@Query2+')'
				SET @Query1	=	@Query1+	'	WHERE POMTempID='''+CONVERT(NVARCHAR(50),@POMTempID)+''''
				SET	@Query1	=	@Query1+	'	AND SizeColumnName='''+@ColumnName+''''
				
				EXEC(@Query1)
				
				SET @RowCnt1 = @RowCnt1 + 1
				SET @TotalRowCount=@TotalRowCount-1
			END
	END
	
	/*------------Prepare Final Select Query ---------------*/
	BEGIN
		IF @IsMetric=0
		BEGIN
			SELECT SizeRowid,Critical,POMCode,POMDesc, 
			ISNULL(dbo.fnx_Num2Frac_KeepNegative(TOLPlus),0) AS TOLPlus ,
			ISNULL(dbo.fnx_Num2Frac_KeepNegative(TOLMinus),0) AS TOLMinus,
			POMTempID,
			SizeColumnName,
			dbo.fnx_Num2Frac_KeepNegative(SizeColumnValue) AS SizeColumnValue,
			POMSort as Sort,
			SizeClassRangeStr,
			REPLACE(AlternatesDesc,'NONE','') AS AlternatesDesc
			FROM  #tblFinalTable
			WHERE SizeColumnName IS NOT NULL
		END
		ELSE
		BEGIN
			SELECT SizeRowid,Critical,POMCode,POMDesc, 
			ISNULL(TOLPlus,0) as TOLPlus, 
			ISNULL(TOLMinus,0) as TOLMinus, 
			POMTempID,
			SizeColumnName,
			SizeColumnValue,
			POMSort as Sort,
			SizeClassRangeStr,
			REPLACE(AlternatesDesc,'NONE','') AS AlternatesDesc 
			FROM  #tblFinalTable
			WHERE SizeColumnName IS NOT NULL
		END
	END
	
	/*---Clean Up------*/
	BEGIN
		DROP TABLE #tblMeasurementPOM
		DROP TABLE #tblFinalTable
	END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06038', GetDate())
GO
