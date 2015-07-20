IF EXISTS(select * from information_schema.routines where specific_name = N'spx_SampleRequestSpec_SELECT_OLD')
   DROP PROCEDURE spx_SampleRequestSpec_SELECT_OLD
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestSpec_SELECT_OLD] 
(@SampleRequestWorkflowID uniqueidentifier,
@SampleWorkflowID nvarchar(5),
@TeamID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet nvarchar(5))
AS

DECLARE @samplesize varchar(10), @sql varchar(8000), @selectwhere varchar(8000), @delim varchar(1), @select varchar(8000), @var varchar(100), @ask varchar(100), @spec varchar(100), @rev varchar(100), @fin varchar(100), @pivot varchar(100), @pivotwhere varchar(100), @table varchar(100)

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

--SELECT @samplesize = (SELECT 
--CASE 
--WHEN Sel0 = 1 THEN Size0	
--WHEN Sel1 = 1 THEN Size1
--WHEN Sel2 = 1 THEN Size2
--WHEN Sel3 = 1 THEN Size3
--WHEN Sel4 = 1 THEN Size4
--WHEN Sel5 = 1 THEN Size5
--WHEN Sel6 = 1 THEN Size6
--WHEN Sel7 = 1 THEN Size7
--WHEN Sel8 = 1 THEN Size8
--WHEN Sel9 = 1 THEN Size9
--WHEN Sel10 = 1 THEN Size10
--WHEN Sel11 = 1 THEN Size11	
--END AS [SampleSize] FROM pSampleRequestWorkflowSize WITH (NOLOCK) 
--WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
--AND (SampleWorkflowID = @SampleWorkflowID) 
--AND (TeamID = @TeamID) 
--AND (StyleID = @StyleID))

--CASE 
--WHEN Size0 = 1 THEN Proto0	
--WHEN Size1 = 1 THEN Proto1
--WHEN Size2 = 1 THEN Proto2
--WHEN Size3 = 1 THEN Proto3
--WHEN Size4 = 1 THEN Proto4
--WHEN Size5 = 1 THEN Proto5
--WHEN Size6 = 1 THEN Proto6
--WHEN Size7 = 1 THEN Proto7
--WHEN Size8 = 1 THEN Proto8
--WHEN Size9 = 1 THEN Proto9
--WHEN Size10 = 1 THEN Proto10
--WHEN Size11 = 1 THEN Proto11	
--END AS [SMP]

SELECT @select = 'SELECT POM, PointMeasur AS [Point of Measurment] 
 FROM dbo.pSampleRequestSpecItem WITH (NOLOCK)
GROUP BY SampleRequestWorkflowID, SampleWorkflowID, TradePartnerVendorID, StyleID, StyleSet, POM, PointMeasur, Sort '

SELECT @ask = 'MAX(Ask)'
SELECT @spec = 'MAX(Spec)'
SELECT @var = 'MAX(Var)'
SELECT @rev = 'MAX(Rev)'
SELECT @fin = 'MAX(Final)'

SELECT @pivot = 'Submit'
SELECT @table = 'pSampleRequestSpecItem '

SELECT @pivotwhere = ' pSampleRequestSpecItem WHERE 1=2 AND ((StyleSet =' + '''' + convert(varchar(5),@StyleSet) + ''')  
AND (StyleID =' + '''' + convert(varchar(50),@StyleID) + ''') 
AND (SampleRequestWorkflowID =' + '''' + convert(varchar(50),@SampleRequestWorkflowID) + ''') 
AND (SampleWorkflowID =' + '''' + convert(varchar(50),@SampleWorkflowID) + ''') 
AND (TradePartnerVendorID =' + '''' + convert(varchar(50),@TeamID) + ''') 
ORDER BY POM) '

--EXEC ('SELECT ' + @pivot + ' AS pivot INTO ##SampleSpec FROM ' + @table + ' WHERE 1=2')
--EXEC ('INSERT INTO ##SampleSpec SELECT DISTINCT ' + @pivot + ' FROM ' + @table + ' WHERE ' + @pivot + ' Is Not Null')
SELECT Submit AS 'pivot' INTO ##SampleSpec FROM pSampleRequestSpecItem WITH (NOLOCK) WHERE 1=2

INSERT INTO ##SampleSpec SELECT DISTINCT Submit FROM pSampleRequestSpecItem WITH (NOLOCK) WHERE Submit Is Not Null AND Spec = 0 AND StyleSet = @StyleSet AND StyleID = @StyleID AND TradePartnerVendorID = @TeamID AND SampleRequestWorkflowID = @SampleRequestWorkflowID AND SampleWorkflowID = @SampleWorkflowID

--SELECT * FROM pSampleRequestSpecItem WITH (NOLOCK) WHERE Spec <> 0 AND Submit Is Not Null AND StyleSet = @StyleSet AND StyleID = @StyleID AND TradePartnerVendorID = @TeamID AND SampleRequestWorkflowID = @SampleRequestWorkflowID AND SampleWorkflowID = @SampleWorkflowID

SELECT @sql='',  @ask=stuff(@ask, len(@ask), 1, ' END)' )
SELECT @sql=@sql + '',  @spec=stuff(@spec, len(@spec), 1, ' END)' )
SELECT @sql=@sql + '',  @var=stuff(@var, len(@var), 1, ' END)' )
SELECT @sql=@sql + '',  @rev=stuff(@rev, len(@rev), 1, ' END)' )
SELECT @sql=@sql + '',  @fin=stuff(@fin, len(@fin), 1, ' END)' )

SELECT @delim=CASE Sign( CharIndex('char', data_type) + CharIndex('date', data_type) ) 
WHEN 0 THEN '''' ELSE '''' END 
FROM tempdb.information_schema.columns 
WHERE table_name='##SampleSpec' AND column_name='pivot'

SELECT @sql=@sql + '''Ask ' + convert(varchar(100), @pivot) + ''' = ' + 
stuff(@ask,charindex( '(', @ask )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
+ '''Spec ' + convert(varchar(100), @pivot) + ''' = ' + 
stuff(@spec,charindex( '(', @spec )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
+ '''Var ' + convert(varchar(100), @pivot) + ''' = ' + 
stuff(@var,charindex( '(', @var )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
+ '''Rev ' + convert(varchar(100), @pivot) + ''' = ' + 
stuff(@rev,charindex( '(', @rev )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
+ '''Final ' + convert(varchar(100), @pivot) + ''' = ' + 
stuff(@fin,charindex( '(', @fin )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
FROM ##SampleSpec

SELECT @sql = left(@sql, len(@sql)-1)

SELECT @select = stuff(@select, charindex(' FROM ', @select)+1, 0, ', ' + @sql + ' ')

SELECT @selectwhere = ' HAVING  (StyleSet =' + '''' + convert(varchar(5),@StyleSet) + ''')  
AND (StyleID =' + '''' + convert(varchar(50),@StyleID) + ''') 
AND (SampleRequestWorkflowID =' + '''' + convert(varchar(50),@SampleRequestWorkflowID) + ''') 
AND (SampleWorkflowID =' + '''' + convert(varchar(50),@SampleWorkflowID) + ''') 
AND (TradePartnerVendorID =' + '''' + convert(varchar(50),@TeamID) + ''') 
ORDER BY Sort, POM '


PRINT @select + @selectwhere

DROP TABLE ##SampleSpec

EXEC (@select + @selectwhere)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01366', GetDate())
GO
