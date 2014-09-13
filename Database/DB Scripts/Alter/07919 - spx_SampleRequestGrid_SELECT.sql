/****** Object:  StoredProcedure [dbo].[spx_SampleRequestGrid_SELECT]    Script Date: 06/05/2014 12:46:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestGrid_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestGrid_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestGrid_SELECT]    Script Date: 06/05/2014 12:46:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestGrid_SELECT]
(
@TradePartnerID nvarchar(50),
@StyleNo nvarchar(200) = NULL,
@StyleDescription nvarchar(200) = NULL,
@sqlSelect nvarchar(MAX) = NULL,
@TeamID nvarchar (50) = NULL 
)
AS

DECLARE @UserID nvarchar(10), @sql nvarchar(MAX), @delim nvarchar(1), @select nvarchar(MAX), @enddate nvarchar(100), @duedate nvarchar(100), @pivot nvarchar(100), @table nvarchar(100)

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

SELECT @select = 'SELECT TOP 100 a.SampleRequestTradeID, 
	a.StyleColorID, a.StyleID, 
	a.StyleSet, pStyleHeader.StyleNo AS [Style No], 
	pStyleHeader.SizeRange AS [Size], pStyleHeader.Description, 
CASE 
WHEN a.StyleSet = 1 THEN 
	CASE WHEN pStyleHeader.PC1 Is Not Null THEN pStyleHeader.PC1 ELSE ''1st Set'' END
WHEN a.StyleSet = 2 THEN 
	CASE WHEN pStyleHeader.PC2 Is Not Null THEN pStyleHeader.PC2 ELSE ''2nd Set'' END
WHEN a.StyleSet = 3 THEN 
	CASE WHEN pStyleHeader.PC3 Is Not Null THEN pStyleHeader.PC3 ELSE ''3rd Set'' END
WHEN a.StyleSet = 4 THEN 
	CASE WHEN pStyleHeader.PC4 Is Not Null THEN pStyleHeader.PC4 ELSE ''4th Set'' END 
END AS [Style Set], pStyleColorway.MainColor AS Color FROM pSampleRequestWorkflow  a WITH (NOLOCK)  INNER JOIN
	pStyleHeader WITH (NOLOCK) ON a.StyleID = pStyleHeader.StyleID LEFT OUTER JOIN
	pStyleColorway WITH (NOLOCK) ON a.StyleColorID = pStyleColorway.StyleColorID INNER JOIN
	pSampleRequestTrade WITH (NOLOCK) ON a.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID '

IF NOT @TeamID IS NULL  
BEGIN
	SET @select = @select + ' WHERE pStyleHeader.StyleType IN  (SELECT ProductTypeId FROM fnx_Permissions_GetIntProductTypePermissions(''' + CAST(@TeamID AS NVARCHAR(40)) + ''', 2) WHERE PermissionRoleId =3 OR PermissionView = 1 ) ' 
END 


SET @select = @select + ' GROUP BY a.SampleRequestTradeID, a.StyleID, a.StyleColorID, 
   a.StyleSet, pStyleHeader.StyleNo, pStyleHeader.SizeRange, pStyleHeader.Description, 
   a.StyleSet, pStyleHeader.Pc1, pStyleHeader.Pc2, pStyleHeader.Pc3, pStyleHeader.Pc4, 
   a.TradePartnerID, pStyleColorway.MainColor, pSampleRequestTrade.SampleRequestShare	
HAVING a.TradePartnerID = ''' + @TradePartnerID + ''' AND (pSampleRequestTrade.SampleRequestShare = 1) AND
	a.SampleRequestTradeID IN (' + @sqlSelect + ')'

--IF @StyleNo IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.StyleNo LIKE ''%' + @StyleNo + '%''' 
--IF @StyleDescription IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.Description LIKE ''%' + @StyleDescription + '%''' 

SELECT @select = @select + ' ORDER BY pStyleHeader.StyleNo, a.StyleSet '

SELECT @enddate = 'MAX(a.EndDate)'
SELECT @duedate = 'MAX(a.DueDate)'
SELECT @pivot = 'a.SampleWorkflowID'
SELECt @table = 'pSampleRequestWorkflow WITH (NOLOCK)'

--PRINT ('SELECT ' + @pivot + ' AS tb_pivot INTO ##tmpSampleWorkflow FROM pSampleRequestWorkflow a WITH (NOLOCK)  WHERE 1=2')
EXEC ('SELECT ' + @pivot + ' AS tb_pivot INTO ##tmpSampleWorkflow FROM pSampleRequestWorkflow a WITH (NOLOCK) WHERE 1=2 AND SampleRequestTradeID IN (' + @sqlSelect + ')')

--PRINT ('INSERT INTO ##tmpSampleWorkflow SELECT DISTINCT ' + @pivot + ' FROM ' + @table + ' WHERE TradePartnerID = ''{' + @TradePartnerID + '}''' + ' AND ' + @pivot + ' Is Not Null')

IF @TeamID  is NULL 
	EXEC ('INSERT INTO ##tmpSampleWorkflow SELECT DISTINCT ' + @pivot + ' FROM pSampleRequestWorkflow  a WITH (NOLOCK)   WHERE SampleRequestTradeID IN (' + @sqlSelect + ')' + ' AND ' + @pivot + ' Is Not Null')
ELSE 
	EXEC ('   INSERT INTO ##tmpSampleWorkflow  SELECT DISTINCT a.SampleWorkflowID  FROM pSampleRequestWorkflow  a WITH (NOLOCK)   WHERE SampleRequestTradeID IN (' + @sqlSelect + ') AND  a.SampleWorkflowID   IN  (  ' + 
	' SELECT DISTINCT SampleWorkflowID   FROM  pSampleWorkflowViewSubmit WITH (NOLOCK)  	WHERE TeamId = ''' +  @TeamID + ''' AND  SampleWorkflowID IN  (   ' + 
	' SELECT ProductTypeId FROM fnx_Permissions_GetStringProductTypePermissions(''' + @TeamID + ''', 5) WHERE PermissionRoleID = 3 OR PermissionView = 1   )  )  ' )




SELECT @sql='',  @duedate=stuff(@duedate, len(@duedate), 1, ' END)' )
SELECT @sql=@sql + '',  @enddate=stuff(@enddate, len(@enddate), 1, ' END)' )

SELECT @delim=CASE Sign( CharIndex('char', data_type) + CharIndex('date', data_type) ) 
	WHEN 0 THEN '''' ELSE '''' END 
	FROM tempdb.information_schema.columns 
WHERE table_name='##tmpSampleWorkflow' AND column_name='tb_pivot'

SELECT @sql=@sql + '''D_' + convert(varchar(100), tb_pivot) + ''' = ' + 
	stuff(@duedate,charindex( '(', @duedate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
	+ @delim + convert(varchar(100), tb_pivot) + @delim + ' THEN ' ) + ', ' 
	+ '''E_' + convert(varchar(100), tb_pivot) + ''' = ' + 
	stuff(@enddate,charindex( '(', @enddate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
	+ @delim + convert(varchar(100), tb_pivot) + @delim + ' THEN ' ) + ', ' 
FROM ##tmpSampleWorkflow

IF @sql is not null AND LEN(@SQL) > 0
begin 
	SELECT @sql=left(@sql, len(@sql)-1)
	SELECT @select=stuff(@select, charindex(' FROM ', @select)+1, 0, ', ' + @sql + ' ')
end 

DROP TABLE ##tmpSampleWorkflow

PRINT (@select)
EXEC (@select)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07919', GetDate())
GO