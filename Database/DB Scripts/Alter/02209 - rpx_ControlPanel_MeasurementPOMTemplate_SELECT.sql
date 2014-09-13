-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 25 Nov 2011                                                                               */
-- * WorkItem #5775                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[rpx_ControlPanel_MeasurementPOMTemplate_SELECT]    Script Date: 11/25/2011 16:23:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ControlPanel_MeasurementPOMTemplate_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_ControlPanel_MeasurementPOMTemplate_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[rpx_ControlPanel_MeasurementPOMTemplate_SELECT]    Script Date: 11/25/2011 16:23:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_ControlPanel_MeasurementPOMTemplate_SELECT]
(
	@POMTempID VARCHAR(50)
)
AS
BEGIN
	
	
	DECLARE @Maxcount	INT
	DECLARE @RowCnt		INT
	DECLARE @IncrCols	NVARCHAR(2000)
	DECLARE @Query		NVARCHAR(MAX)
	
	DECLARE @IsRelative	INT
	DECLARE @IsNegative	INT
	DECLARE @IsMetric	INT

	SET @RowCnt		=	0
	SET @Maxcount	=	49
	SET @IncrCols	=	''
	
	SELECT
	@IsRelative=[Relative]
	,@IsNegative=Negative
	,@IsMetric = Metric 
	FROM pGRMeasurementsPOMTemplateGroup
	WHERE POMTempID=@POMTempID

	WHILE @RowCnt <= @Maxcount
	BEGIN
		SET @IncrCols = @IncrCols + 'Incr' + CONVERT(NVARCHAR(3), @RowCnt) + ','
		SET @RowCnt = @RowCnt + 1
	END
	
	IF RIGHT(@IncrCols,1)=',' SET @IncrCols=SUBSTRING(@IncrCols, 1, LEN(@IncrCols)-1)
	
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
			,Sort				NVARCHAR(8)
			,AlternatesDesc		NVARCHAR(500)
		)
	END
	
	/*----------Convert Columns into Rows------------------------*/
	BEGIN		
		SET @Query = N'SELECT Critical,POMCode,POMDesc,TolPlus,TolMinus,POMTempID,SizeColumnName,SizeColumnValue,Sort,AlternatesDesc
		FROM 
		(SELECT Critical,POMCode,POMDesc,TolPlus,TolMinus,POMTempID, ' + @IncrCols + ',Sort,AlternatesDesc FROM pGRMeasurementsPOMTemplateItem
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
		A.Sort,
		C.SizeClass + ' (' + C.SizeRange + ')' AS SizeClassRangeStr,
		A.AlternatesDesc		
		INTO #tblFinalTable 
		FROM #tblMeasurementPOM A LEFT OUTER JOIN pGRMeasurementsPOMTemplateGroup B ON
		A.POMTempID = B.POMTempID LEFT OUTER JOIN pGRMeasurementsPOMTemplate C ON
		B.POMTempID = C.POMTempID
		WHERE C.POMTempID = @POMTempID
		ORDER BY A.Sort,A.POMCode,A.SizeRowid
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
			dbo.fnx_Num2Frac_KeepNegative(TOLPlus) AS TOLPlus ,
			dbo.fnx_Num2Frac_KeepNegative(TOLMinus)AS TOLMinus,
			POMTempID,
			SizeColumnName,
			dbo.fnx_Num2Frac_KeepNegative(SizeColumnValue) AS SizeColumnValue,
			Sort,
			SizeClassRangeStr,
			REPLACE(AlternatesDesc,'NONE','') AS AlternatesDesc
			FROM  #tblFinalTable
		END
		ELSE
		BEGIN
			SELECT SizeRowid,Critical,POMCode,POMDesc, 
			TOLPlus ,
			TOLMinus,
			POMTempID,
			SizeColumnName,
			SizeColumnValue,
			Sort,
			SizeClassRangeStr,
			REPLACE(AlternatesDesc,'NONE','') AS AlternatesDesc 
			FROM  #tblFinalTable
		END
	END
	
	/*---Clean Up------*/
	BEGIN
		DROP TABLE #tblMeasurementPOM
		DROP TABLE #tblFinalTable
	END
END

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02209'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02209', GetDate())
	END
GO
