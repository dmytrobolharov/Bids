
IF EXISTS(select * from information_schema.routines where specific_name = N'spx_SampleWorkflowItem_SELECT_1')
   DROP PROCEDURE spx_SampleWorkflowItem_SELECT_1
GO


CREATE PROCEDURE [dbo].[spx_SampleWorkflowItem_SELECT_1] 
(@UserID nvarchar(5))
AS

DECLARE @sql varchar(8000), @delim varchar(1), @select varchar(8000), @enddate varchar(100), @duedate varchar(100), @pivot varchar(100), @table varchar(100)
SET NOCOUNT ON

SELECT @select = 'SELECT dbo.pSampleRequestWorkflow.StyleID, dbo.pStyleHeader.StyleNo AS [Style No], dbo.pStyleHeader.Description, 
CASE 
WHEN pSampleRequestWorkflow.StyleSet = 1 THEN 
	CASE WHEN dbo.pStyleHeader.PC1 Is Not Null THEN dbo.pStyleHeader.PC1 ELSE ''1st Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 2 THEN 
	CASE WHEN dbo.pStyleHeader.PC2 Is Not Null THEN dbo.pStyleHeader.PC2 ELSE ''2nd Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 3 THEN 
	CASE WHEN dbo.pStyleHeader.PC3 Is Not Null THEN dbo.pStyleHeader.PC3 ELSE ''3rd Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 4 THEN 
	CASE WHEN dbo.pStyleHeader.PC4 Is Not Null THEN dbo.pStyleHeader.PC4 ELSE ''4th Set'' END
END AS [Style Set] FROM  dbo.pSampleRequestWorkflow WITH (NOLOCK) 
INNER JOIN dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID 
GROUP BY dbo.pSampleRequestWorkflow.StyleID, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.Description, dbo.pSampleRequestWorkflow.StyleSet, 
dbo.pStyleHeader.PC1, dbo.pStyleHeader.PC2, dbo.pStyleHeader.PC3, dbo.pStyleHeader.PC4,pSampleRequestWorkflow.UserID
HAVING pSampleRequestWorkflow.UserID = ' + @UserID + ' ORDER BY dbo.pStyleHeader.StyleNo, dbo.pSampleRequestWorkflow.StyleSet'

--SELECT @enddate = 'MAX((CONVERT(datetime, CONVERT(varchar, dbo.pSampleRequestWorkflow.EndDate, 101))))'
--SELECT @duedate = 'MAX((CONVERT(datetime, CONVERT(varchar, dbo.pSampleRequestWorkflow.DueDate, 101))))'

SELECT @enddate = 'MAX(dbo.pSampleRequestWorkflow.EndDate)'
SELECT @duedate = 'MAX(dbo.pSampleRequestWorkflow.DueDate)'
SELECT @pivot = 'dbo.pSampleRequestWorkflow.SampleWorkflowID'
SELECt @table = 'pSampleRequestWorkflow WITH (NOLOCK)'

EXEC ('SELECT ' + @pivot + ' AS pivot INTO ##SampleWorkflow FROM ' + @table + ' WHERE 1=2')
EXEC ('INSERT INTO ##SampleWorkflow SELECT DISTINCT ' + @pivot + ' FROM ' + @table + ' WHERE ' 
+ @pivot + ' Is Not Null')


SELECT @sql='',  @duedate=stuff(@duedate, len(@duedate), 1, ' END)' )
SELECT @sql=@sql + '',  @enddate=stuff(@enddate, len(@enddate), 1, ' END)' )

SELECT @delim=CASE Sign( CharIndex('char', data_type) + CharIndex('date', data_type) ) 
WHEN 0 THEN '''' ELSE '''' END 
FROM tempdb.information_schema.columns 
WHERE table_name='##SampleWorkflow' AND column_name='pivot'

SELECT @sql=@sql + '''D_' + convert(varchar(100), @pivot) + ''' = ' + 
stuff(@duedate,charindex( '(', @duedate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
+ '''E_' + convert(varchar(100), @pivot) + ''' = ' + 
stuff(@enddate,charindex( '(', @enddate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
FROM ##SampleWorkflow

SELECT @sql=left(@sql, len(@sql)-1)

SELECT @select=stuff(@select, charindex(' FROM ', @select)+1, 0, ', ' + @sql + ' ')

DROP TABLE ##SampleWorkflow

EXEC (@select)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01367', GetDate())
GO
