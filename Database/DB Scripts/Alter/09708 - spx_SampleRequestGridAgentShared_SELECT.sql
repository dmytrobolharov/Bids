IF OBJECT_ID(N'[dbo].[spx_SampleRequestGridAgentShared_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestGridAgentShared_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestGridAgentShared_SELECT] 
(
@TradePartnerID nvarchar(50),
@StyleNo nvarchar(200) = NULL,
@StyleDescription nvarchar(200) = NULL,
@sqlSelect nvarchar(max) = NULL
)
AS


DECLARE @UserID nvarchar(10), @sql nvarchar(max), @delim nvarchar(1), @select nvarchar(max), @enddate nvarchar(100), @duedate nvarchar(100), @pivot nvarchar(100), @table nvarchar(100)

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

SELECT @select = 'SELECT TOP 100 
	a.SampleRequestTradeID, 
	a.StyleColorID, a.StyleID, 
	a.StyleSet, pStyleHeader.StyleNo AS [Style No], 
	COALESCE(sr.SizeRangeCode, pStyleHeader.SizeRange) AS [Size Range], pStyleHeader.Description, 
CASE 
WHEN a.StyleSet = 1 THEN 
	CASE WHEN pStyleHeader.PC1 Is Not Null THEN pStyleHeader.PC1 ELSE ''1st Set'' END
WHEN a.StyleSet = 2 THEN 
	CASE WHEN pStyleHeader.PC2 Is Not Null THEN pStyleHeader.PC2 ELSE ''2nd Set'' END
WHEN a.StyleSet = 3 THEN 
	CASE WHEN pStyleHeader.PC3 Is Not Null THEN pStyleHeader.PC3 ELSE ''3rd Set'' END
WHEN a.StyleSet = 4 THEN 
	CASE WHEN pStyleHeader.PC4 Is Not Null THEN pStyleHeader.PC4 ELSE ''4th Set'' END 
END AS [Style Set], pStyleColorway.MainColor AS Color,  uTradePartner.TradePartnerName as [Agent], 
uTradePartnerVendor.VendorName as [Vendor], COALESCE(sc.Custom, pStyleHeader.SizeClass) AS SizeClass  
FROM pSampleRequestWorkflow a WITH (NOLOCK) INNER JOIN
	pStyleHeader WITH (NOLOCK) ON a.StyleID = pStyleHeader.StyleID 

	INNER JOIN  uTradePartner WITH (NOLOCK) ON a.TradePartnerID =  uTradePartner.TradePartnerID INNER JOIN
	uTradePartnerVendor WITH (NOLOCK) ON  a.TradePartnerVendorID =  uTradePartnerVendor.TradePartnerVendorID

	LEFT OUTER JOIN pStyleColorway WITH (NOLOCK) ON a.StyleColorID = pStyleColorway.StyleColorID INNER JOIN
	pSampleRequestTrade WITH (NOLOCK) ON a.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID
    
	LEFT JOIN pSizeClass sc ON scc.CustomId = pStyleHeader.SizeClassId
    LEFT JOIN pSizeRange sr ON sr.CustomId = pStyleHeader.SizeRangeId

GROUP BY a.SampleRequestTradeID, a.StyleID, a.StyleColorID, 
   a.StyleSet, pStyleHeader.StyleNo, COALESCE(sr.SizeRangeCode, pStyleHeader.SizeRange), pStyleHeader.Description, 
   a.StyleSet, pStyleHeader.Pc1, pStyleHeader.Pc2, pStyleHeader.Pc3, pStyleHeader.Pc4, 
   a.TradePartnerID, pStyleColorway.MainColor, pSampleRequestTrade.SampleRequestShare, 	
    uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName, COALESCE(sc.Custom, pStyleHeader.SizeClass)	


HAVING a.TradePartnerID = ''' + @TradePartnerID + ''' AND (pSampleRequestTrade.SampleRequestShare = 1) AND
	a.SampleRequestTradeID IN (' + @sqlSelect + ')'

--IF @StyleNo IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.StyleNo LIKE ''%' + @StyleNo + '%''' 
--IF @StyleDescription IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.Description LIKE ''%' + @StyleDescription + '%''' 

SELECT @select = @select + ' ORDER BY pStyleHeader.StyleNo, a.StyleSet '

SELECT @enddate = 'MAX(a.EndDate)'
SELECT @duedate = 'MAX(a.DueDate)'
SELECT @pivot = 'a.SampleWorkflowID'
SELECt @table = 'pSampleRequestWorkflow a WITH (NOLOCK)'

--PRINT ('SELECT ' + @pivot + ' AS pivot INTO ##tmpSampleWorkflow FROM ' + @table + ' WHERE 1=2')
EXEC ('SELECT ' + @pivot + ' AS tb_pivot INTO ##tmpSampleWorkflow FROM ' + @table + ' WHERE 1=2 AND SampleRequestTradeID IN (' + @sqlSelect + ')')

--PRINT ('INSERT INTO ##tmpSampleWorkflow SELECT DISTINCT ' + @pivot + ' FROM ' + @table + ' WHERE TradePartnerID = ''{' + @TradePartnerID + '}''' + ' AND ' + @pivot + ' Is Not Null')
EXEC ('INSERT INTO ##tmpSampleWorkflow SELECT DISTINCT ' + @pivot + ' FROM ' + @table + ' WHERE SampleRequestTradeID IN (' + @sqlSelect + ')' + ' AND ' + @pivot + ' Is Not Null')

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
VALUES ('DB_Version', '6.1.0000', '09708', GetDate())
GO
