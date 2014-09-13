-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpec_Logic_SELECT]    Script Date: 12/18/2011 18:39:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpec_Logic_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpec_Logic_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpec_Logic_SELECT]    Script Date: 12/18/2011 18:39:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE  PROCEDURE [dbo].[spx_SampleRequestBOMSpec_Logic_SELECT] 
(@SampleRequestWorkflowID uniqueidentifier,
@SampleWorkflowID nvarchar(5),
@TeamID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet nvarchar(5) ,
@SampleRequestTradeID uniqueidentifier,
@DefineSchema INT = 0 
)

AS

DECLARE @samplesize varchar(10), @sql varchar(8000), @selectwhere varchar(8000), @delim varchar(1), @select varchar(8000), @var varchar(100), @ask varchar(100), @spec varchar(100), @rev varchar(100), @fin varchar(100), @pivot varchar(100), @pivotwhere varchar(100), @table varchar(100)
DECLARE @Select02 varchar (8000) 


SET NOCOUNT ON
SET ANSI_WARNINGS OFF



SELECT @ask = 'MAX(Ask)'
SELECT @spec = 'MAX(Spec)'
SELECT @var = 'MAX(Var)'
SELECT @rev = 'MAX(Rev)'
SELECT @fin = 'MAX(Final)'

SELECT @pivot = 'Submit'
SELECT @table = 'pSampleRequestSpecItem '


SELECT Submit AS tb_pivot INTO ##SampleSpec FROM pSampleRequestSpecItem WITH (NOLOCK) WHERE 1=2


INSERT INTO ##SampleSpec 
SELECT DISTINCT Submit 
FROM pSampleRequestSpecItemBOM WITH (NOLOCK) 
WHERE Submit Is Not Null AND  StyleSet = @StyleSet AND StyleID = @StyleID 
AND SampleRequestWorkflowID = @SampleRequestWorkflowID 
AND SampleWorkflowID = @SampleWorkflowID





SELECT @sql='',  @ask=stuff(@ask, len(@ask), 1, ' END)' )
SELECT @sql=@sql + '',  @spec=stuff(@spec, len(@spec), 1, ' END)' )
SELECT @sql=@sql + '',  @var=stuff(@var, len(@var), 1, ' END)' )
SELECT @sql=@sql + '',  @rev=stuff(@rev, len(@rev), 1, ' END)' )
SELECT @sql=@sql + '',  @fin=stuff(@fin, len(@fin), 1, ' END)' )




SELECT @delim=CASE Sign( CharIndex('char', data_type) + CharIndex('date', data_type) ) 
WHEN 0 THEN '''' ELSE '''' END 
FROM tempdb.information_schema.columns 
WHERE table_name='##SampleSpec' AND column_name='tb_pivot'


SELECT Sort , Submit, SampleRequestSpecID, POM,  PointMeasur, Ask,Spec, Var, Rev , Final --=0  
INTO ##SampleSummary
FROM pSampleRequestSpecItemBOM WITH (NOLOCK)  
WHERE StyleID =  @StyleID
AND StyleSet = @StyleSet
AND SampleRequestTradeID = @SampleRequestTradeID
AND SampleRequestWorkflowID = @SampleRequestWorkflowID
AND SampleWorkflowID = @SampleWorkflowID
ORDER BY Sort, POM, Submit 


SELECT @sql=@sql + '''Ask ' + convert(varchar(100), tb_pivot) + ''' = ' + 
stuff(@ask,charindex( '(', @ask )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), tb_pivot) + @delim + ' THEN ' ) + ', ' 
+ '''Spec ' + convert(varchar(100), tb_pivot) + ''' = ' + 
stuff(@spec,charindex( '(', @spec )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), tb_pivot) + @delim + ' THEN ' ) + ', ' 
+ '''Var ' + convert(varchar(100), tb_pivot) + ''' = ' + 
stuff(@var,charindex( '(', @var )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), tb_pivot) + @delim + ' THEN ' ) + ', ' 
+ '''Rev ' + convert(varchar(100), tb_pivot) + ''' = ' + 
stuff(@rev,charindex( '(', @rev )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), tb_pivot) + @delim + ' THEN ' ) + ', ' 
+ '''Final ' + convert(varchar(100), tb_pivot) + ''' = ' + 
stuff(@fin,charindex( '(', @fin )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), tb_pivot) + @delim + ' THEN ' ) + ', ' 
FROM ##SampleSpec



if  ( @sql is NULL OR len ( @sql  ) <= 0   )
	SELECT @Select02  = 'SELECT POM, PointMeasur AS [Point of Measurement]  '  +  @sql +  ' FROM ##SampleSummary GROUP  BY   POM, PointMeasur, Sort  ORDER BY  Sort'
else
begin 
	SELECT @sql = left(@sql, len(@sql)-1)
	SELECT @Select02  = 'SELECT POM, PointMeasur AS [Point of Measurement] , '  +  @sql +  ' FROM ##SampleSummary GROUP  BY   POM, PointMeasur, Sort  ORDER BY  Sort'
end 

PRINT @Select02 
EXEC (@Select02 )

DECLARE @LastSubmit  INT
SELECT @LastSubmit  = ISNULL(MAX(tb_pivot),0) FROM ##SampleSpec

DROP TABLE ##SampleSpec
DROP TABLE  ##SampleSummary


IF @DefineSchema = 1
BEGIN 

	--**** 
	--** Define Schema structure 
	--**** 

	CREATE TABLE #tb (
		GridOrder INT IDENTITY(1,1), 
		[Column] NVARCHAR(200),
		Alias NVARCHAR(200),
		Type  NVARCHAR(200),
		datatype NVARCHAR(200),
		dataformat NVARCHAR(200),
		cellwidth INT,
		GridWidth INT,
		GridHeaderCss NVARCHAR(200)
	)

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss ) 
	VALUES('POM', 'POM', 'label', 'string', 50, 40, 'TableHeader' )

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss ) 
	VALUES('Point of Measurement', 'Point of Measurement', 'label', 'string', 50, 150, 'TableHeader' )


	DECLARE @CONT INT
	SET @CONT =1 
	WHILE @CONT <= @LastSubmit	
	BEGIN 
		
		INSERT INTO #tb ( [Column], Alias, Type, datatype, dataformat, cellwidth, GridWidth, GridHeaderCss) 
		VALUES('Ask ' + CAST(@CONT AS NVARCHAR(3)), 'Ask '+ CAST(@CONT AS NVARCHAR(3)), 'label', 'fraction','0.00', 50, 50, 'TableHeaderBlue'  )

		INSERT INTO #tb ( [Column], Alias, Type, datatype,dataformat, cellwidth, GridWidth, GridHeaderCss ) 
		VALUES('Spec '+ CAST(@CONT AS NVARCHAR(3)), 'Spec '+ CAST(@CONT AS NVARCHAR(3)), 'label', 'fraction','', 50, 50, 'TableHeader' )
/*
		INSERT INTO #tb ( [Column], Alias, Type, datatype, dataformat,cellwidth, GridWidth, GridHeaderCss ) 
		VALUES('Var '+ CAST(@CONT AS NVARCHAR(3)), 'Var '+ CAST(@CONT AS NVARCHAR(3)), 'label', 'decimal','', 50, 50, 'TableHeaderRed' )

		INSERT INTO #tb ( [Column], Alias, Type, datatype, dataformat,cellwidth, GridWidth, GridHeaderCss ) 
		VALUES('Rev '+ CAST(@CONT AS NVARCHAR(3)), 'Rev '+ CAST(@CONT AS NVARCHAR(3)), 'label', 'decimal','', 50, 50, 'TableHeaderGreen' )
*/		
		SET @CONT = @CONT  + 1 
	END

	
	IF ( SELECT b.ApprovedType
		FROM pSampleRequestSubmitBOM  a INNER JOIN pSampleRequestSubmitStatus b ON a.Status = b.StatusID
		WHERE a.SampleRequestTradeID = @SampleRequestTradeID
		AND a.SampleWorkflowID= @SampleWorkflowID
		AND a.Styleset= @StyleSet
		AND a.Submit = @LastSubmit
		) = 1
	BEGIN
		INSERT INTO #tb ( [Column], Alias, Type, datatype, dataformat, cellwidth, GridWidth, GridHeaderCss ) 
		VALUES('Final '+ CAST(@LastSubmit AS NVARCHAR(3)), 'Final '+ CAST(@LastSubmit AS NVARCHAR(3)), 'label', 'decimal','', 50, 50, 'TableHeader' )
	END 

	
	SELECT RIGHT( '0000'+ CAST(GridOrder AS NVARCHAR(3)), 4)  AS GridOrder, [Column], Alias, Type, 
	datatype, dataformat, cellwidth, GridWidth, GridHeaderCss
	FROM #tb
	
	
	DROP TABLE #tb 	


END 



GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02414'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02414', GetDate())

END

GO
