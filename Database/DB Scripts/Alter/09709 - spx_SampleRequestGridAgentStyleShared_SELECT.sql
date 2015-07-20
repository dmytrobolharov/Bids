IF OBJECT_ID(N'[dbo].[spx_SampleRequestGridAgentStyleShared_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestGridAgentStyleShared_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestGridAgentStyleShared_SELECT] 
(
@StyleID nvarchar(50),
@TradePartnerAgentID nvarchar(50),
@TradePartnerVendorID nvarchar(50)
)
AS

if object_id('tempdb..##tmpSampleStyleWorkflow') is not null 
BEGIN
	DROP TABLE ##tmpSampleStyleWorkflow
END

DECLARE @UserID nvarchar(10), @sql nvarchar(max), @delim nvarchar(1), @select nvarchar(max), @enddate nvarchar(100), @duedate nvarchar(100), @pivot nvarchar(100), @table nvarchar(100)

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

SELECT @select = 'SELECT pSampleRequestWorkflow.SampleRequestTradeID,uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName,
pStyleHeader.StyleNo, pStyleHeader.Description, COALESCE(sc.Custom, pStyleHeader.SizeClass) AS [SizeClass],  
CASE 
WHEN pSampleRequestWorkflow.StyleSet = 1 THEN 
	CASE WHEN pStyleHeader.PC1 Is Not Null THEN pStyleHeader.PC1 ELSE ''1st Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 2 THEN 
	CASE WHEN pStyleHeader.PC2 Is Not Null THEN pStyleHeader.PC2 ELSE ''2nd Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 3 THEN 
	CASE WHEN pStyleHeader.PC3 Is Not Null THEN pStyleHeader.PC3 ELSE ''3rd Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 4 THEN 
	CASE WHEN pStyleHeader.PC4 Is Not Null THEN pStyleHeader.PC4 ELSE ''4th Set'' END 
END AS [Style Set], ISNULL(pStyleColorway.MainColor,''NA'') AS Color,  pSampleRequestWorkflow.StyleSet , dbo.pStyleHeader.DueDate AS [Tech Pack] FROM  dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
    dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
    dbo.uTradePartner WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
    dbo.uTradePartnerVendor WITH (NOLOCK) ON 
    dbo.pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID LEFT OUTER JOIN
    dbo.pStyleColorway WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleColorID = dbo.pStyleColorway.StyleColorID
    LEFT JOIN pSizeClass sc ON sc.CustomId = pStyleHeader.SizeClassId
    LEFT JOIN pSizeRange sr ON sr.CustomId = pStyleHeader.SizeRangeId
GROUP BY dbo.pSampleRequestWorkflow.SampleRequestTradeID, dbo.pSampleRequestWorkflow.StyleID, dbo.pSampleRequestWorkflow.StyleColorID, 
    dbo.pSampleRequestWorkflow.StyleSet, dbo.pStyleHeader.StyleNo, COALESCE(sr.SizeRangeCode, pStyleHeader.SizeRange), dbo.pStyleHeader.Description, 
    dbo.pStyleHeader.Pc1, dbo.pStyleHeader.Pc2, dbo.pStyleHeader.Pc3, dbo.pStyleHeader.Pc4, COALESCE(sc.Custom, pStyleHeader.SizeClass),
    dbo.pSampleRequestWorkflow.TradePartnerID, dbo.pSampleRequestWorkflow.TradePartnerVendorID, dbo.pStyleColorway.MainColor, 
    dbo.uTradePartner.TradePartnerName, dbo.uTradePartnerVendor.VendorName,  dbo.pStyleHeader.StyleID, dbo.pStyleHeader.DueDate
HAVING   dbo.pStyleHeader.StyleID = ''' + @StyleID + '''' 


IF @TradePartnerVendorID IS NOT NULL SELECT @select = @select + ' AND pSampleRequestWorkflow.TradePartnerVendorID = ''' + @TradePartnerVendorID + ''''  
IF @TradePartnerAgentID IS NOT NULL SELECT @select = @select + ' AND pSampleRequestWorkflow.TradePartnerID = ''' + @TradePartnerAgentID + ''''  
--IF @StyleDescription IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.Description LIKE ''%' + @StyleDescription + '%''' 
--IF @Season IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.' + @CustomFieldSeason + ' = ''' + @Season + '''' 
--IF @Year IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.' + @CustomFieldYear + ' = ''' + @Year + '''' 

SELECT @select = @select + ' ORDER BY uTradePartnerVendor.VendorName, pStyleHeader.StyleNo, pSampleRequestWorkflow.StyleSet, pStyleColorway.MainColor '

SELECT @enddate = 'MAX(pSampleRequestWorkflow.EndDate)'
SELECT @duedate = 'MAX(pSampleRequestWorkflow.DueDate)'
SELECT @pivot = 'pSampleRequestWorkflow.SampleWorkflowID'
SELECt @table = 'pSampleRequestWorkflow WITH (NOLOCK)'

EXEC ('SELECT ' + @pivot + ' AS tb_pivot INTO ##tmpSampleStyleWorkflow FROM ' + @table + ' WHERE 1=2')
EXEC ('INSERT INTO ##tmpSampleStyleWorkflow SELECT DISTINCT ' + @pivot + ' FROM ' + @table + ' WHERE ' + @pivot + ' Is Not Null AND  StyleID = ''' + @StyleID + '''') 

SELECT @sql='',  @duedate=stuff(@duedate, len(@duedate), 1, ' END)' )
SELECT @sql=@sql + '',  @enddate=stuff(@enddate, len(@enddate), 1, ' END)' )

SELECT @delim=CASE Sign( CharIndex('char', data_type) + CharIndex('date', data_type) ) 
WHEN 0 THEN '''' ELSE '''' END 
FROM tempdb.information_schema.columns 
WHERE table_name='##tmpSampleStyleWorkflow' AND column_name='tb_pivot'

SELECT @sql=@sql + '''D_' + convert(nvarchar(100), tb_pivot) + ''' = ' + 
stuff(@duedate,charindex( '(', @duedate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(nvarchar(100), tb_pivot) + @delim + ' THEN ' ) + ', ' 
+ '''E_' + convert(nvarchar(100), tb_pivot) + ''' = ' + 
stuff(@enddate,charindex( '(', @enddate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(nvarchar(100), tb_pivot) + @delim + ' THEN ' ) + ', ' 
FROM ##tmpSampleStyleWorkflow

SELECT @sql=left(@sql, len(@sql)-1)

SELECT @select=stuff(@select, charindex(' FROM ', @select)+1, 0, ', ' + @sql + ' ')

DROP TABLE ##tmpSampleStyleWorkflow

PRINT @select


EXEC (@select)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09709', GetDate())
GO
