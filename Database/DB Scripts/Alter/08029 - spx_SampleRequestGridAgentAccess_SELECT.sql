/****** Object:  StoredProcedure [dbo].[spx_SampleRequestGridAgentAccess_SELECT]    Script Date: 06/17/2014 12:19:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestGridAgentAccess_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestGridAgentAccess_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestGridAgentAccess_SELECT]    Script Date: 06/17/2014 12:19:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestGridAgentAccess_SELECT] 
(
@TradePartnerID nvarchar(50),
@StyleNo nvarchar(200),
@StyleDescription nvarchar(200),
@TeamID nvarchar (50) 
)
AS
DECLARE @UserID nvarchar(10), @sql nvarchar(MAX), @delim nvarchar(1), @select nvarchar(MAX), @enddate nvarchar(100), @duedate nvarchar(100), 
@pivot nvarchar(100), @table nvarchar(100)

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

SELECT @select = 'SELECT srw.SampleRequestTradeID, 
srw.StyleColorID, srw.StyleID, 
srw.StyleSet, dbo.pStyleHeader.StyleNo AS [Style No], 
dbo.pStyleHeader.SizeRange AS [Size], dbo.pStyleHeader.Description, 
CASE 
WHEN srw.StyleSet = 1 THEN 
	CASE WHEN dbo.pStyleHeader.PC1 Is Not Null THEN dbo.pStyleHeader.PC1 ELSE ''1st Set'' END
WHEN srw.StyleSet = 2 THEN 
	CASE WHEN dbo.pStyleHeader.PC2 Is Not Null THEN dbo.pStyleHeader.PC2 ELSE ''2nd Set'' END
WHEN srw.StyleSet = 3 THEN 
	CASE WHEN dbo.pStyleHeader.PC3 Is Not Null THEN dbo.pStyleHeader.PC3 ELSE ''3rd Set'' END
WHEN srw.StyleSet = 4 THEN 
	CASE WHEN dbo.pStyleHeader.PC4 Is Not Null THEN dbo.pStyleHeader.PC4 ELSE ''4th Set'' END 
END AS [Style Set], dbo.pStyleColorway.MainColor AS Color FROM pSampleRequestWorkflow srw WITH (NOLOCK) INNER JOIN
	pSampleWorkflow ON srw.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN 
	dbo.pStyleHeader WITH (NOLOCK) ON srw.StyleID = dbo.pStyleHeader.StyleID LEFT OUTER JOIN
	dbo.pStyleColorway WITH (NOLOCK) ON srw.StyleColorID = dbo.pStyleColorway.StyleColorID INNER JOIN
	dbo.pSampleRequestTrade WITH (NOLOCK) ON srw.SampleRequestTradeID = dbo.pSampleRequestTrade.SampleRequestTradeID CROSS APPLY
	fnx_Permissions_GetIntProductType_WorkflowPermissions(''' + CAST(@TeamID AS NVARCHAR(40)) + ''', 5, pStyleHeader.StyleType) access 
WHERE access.WorkflowID = pSampleWorkflow.SampleWorkflowGUID
GROUP BY srw.SampleRequestTradeID, srw.StyleID, srw.StyleColorID, 
   srw.StyleSet, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.SizeRange, dbo.pStyleHeader.Description, 
   srw.StyleSet, dbo.pStyleHeader.Pc1, dbo.pStyleHeader.Pc2, dbo.pStyleHeader.Pc3, dbo.pStyleHeader.Pc4, 
   srw.TradePartnerID, dbo.pStyleColorway.MainColor, dbo.pSampleRequestTrade.SampleRequestShare	
HAVING srw.TradePartnerID = ''' + @TradePartnerID + ''' '

IF @StyleNo IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.StyleNo LIKE ''%' + @StyleNo + '%''' 
IF @StyleDescription IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.Description LIKE ''%' + @StyleDescription + '%''' 

SELECT @select = @select + ' ORDER BY dbo.pStyleHeader.StyleNo, srw.StyleSet '

SELECT @enddate = 'MAX(srw.EndDate)'
SELECT @duedate = 'MAX(srw.DueDate)'
SELECT @pivot = 'srw.SampleWorkflowID'
SELECt @table = 'pSampleRequestWorkflow srw INNER JOIN pStyleHeader sh ON sh.StyleID = srw.StyleID '

EXEC ('SELECT ' + @pivot + ' AS tb_pivot INTO ##tmpSampleWorkflow FROM ' + @table + ' WHERE 1=2')

DECLARE @strSQL NVARCHAR(MAX)
SET @strSQL = 'INSERT INTO ##tmpSampleWorkflow SELECT DISTINCT ' + @pivot + ' FROM ' + 
	@table + ' WHERE srw.TradePartnerID = ''{' + @TradePartnerID + '}''' + ' AND ' + @pivot + ' Is Not Null 
	AND SampleWorkflowID IN 
	(
	 SELECT DISTINCT SampleWorkflowID FROM pSampleWorkflow w
	 INNER JOIN fnx_Permissions_GetIntProductType_WorkflowPermissions(''' + CAST(@TeamID AS NVARCHAR(40)) + ''', 5, sh.StyleType) acc ON acc.WorkflowId = w.SampleWorkflowGUID 
	 WHERE acc.PermissionRoleID = 3 OR acc.PermissionView = 1
	)
  AND SampleWorkflowID  IN ( select  DISTINCT SampleWorkflowId   from pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = ''' + @TeamID + '''  )' 

EXEC (@strSQL)

SELECT @sql='',  @duedate=stuff(@duedate, len(@duedate), 1, ' END)' )
SELECT @sql=@sql + '',  @enddate=stuff(@enddate, len(@enddate), 1, ' END)' )

SELECT @delim=CASE Sign( CharIndex('char', data_type) + CharIndex('date', data_type) ) 
WHEN 0 THEN '''' ELSE '''' END 
FROM tempdb.information_schema.columns 
WHERE table_name='##tmpSampleWorkflow' AND column_name='tb_pivot'


SELECT @sql=@sql + '''D_' + convert(nvarchar(100), tb_pivot) + ''' = ' + 
stuff(@duedate,charindex( '(', @duedate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(nvarchar(100), tb_pivot) + @delim + ' THEN ' ) + ', ' 
+ '''E_' + convert(nvarchar(100), tb_pivot) + ''' = ' + 
stuff(@enddate,charindex( '(', @enddate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(nvarchar(100), tb_pivot) + @delim + ' THEN ' ) + ', ' 
FROM ##tmpSampleWorkflow

SELECT @sql=left(@sql, len(@sql)-1)

SELECT @select=stuff(@select, charindex(' FROM ', @select)+1, 0, ', ' + @sql + ' ')

DROP TABLE ##tmpSampleWorkflow

print  @select 

EXEC (@select)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08029', GetDate())
GO
