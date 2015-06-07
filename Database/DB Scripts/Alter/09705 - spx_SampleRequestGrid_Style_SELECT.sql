IF OBJECT_ID(N'[dbo].[spx_SampleRequestGrid_Style_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestGrid_Style_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestGrid_Style_SELECT] 
(
@DevelopmentID nvarchar(50),
@StyleID nvarchar(50),
@TradePartnerAgentID nvarchar(50),
@TradePartnerVendorID nvarchar(50)
)
AS

if object_id('tempdb..##tmpSampleStyleWorkflow') is not null 
BEGIN
	DROP TABLE ##tmpSampleStyleWorkflow
END

DECLARE @UserID nvarchar(10), @sql nvarchar(max), @delim nvarchar(1), @select nvarchar(MAX), @enddate nvarchar(100), @duedate nvarchar(100), @pivot nvarchar(100), @table nvarchar(100)

SET NOCOUNT ON
SET ANSI_WARNINGS OFF


SELECT @select = 'SELECT a.SampleRequestTradeID,uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName,
pStyleHeader.StyleNo, pStyleHeader.Description, COALESCE(sc.Custom, pStyleHeader.SizeClass) AS [SizeClass], 
CASE 
WHEN a.StyleSet = 1 THEN 
	CASE WHEN pStyleHeader.PC1 Is Not Null THEN pStyleHeader.PC1 ELSE ''1st Set'' END
WHEN a.StyleSet = 2 THEN 
	CASE WHEN pStyleHeader.PC2 Is Not Null THEN pStyleHeader.PC2 ELSE ''2nd Set'' END
WHEN a.StyleSet = 3 THEN 
	CASE WHEN pStyleHeader.PC3 Is Not Null THEN pStyleHeader.PC3 ELSE ''3rd Set'' END
WHEN a.StyleSet = 4 THEN 
	CASE WHEN pStyleHeader.PC4 Is Not Null THEN pStyleHeader.PC4 ELSE ''4th Set'' END 
END AS [StyleSet], ISNULL(pStyleColorway.MainColor,''NA'') AS Color, pStyleHeader.DueDate AS [Tech Pack]  
FROM  pSampleRequestWorkflow a WITH (NOLOCK) INNER JOIN
    pStyleHeader WITH (NOLOCK) ON a.StyleID = pStyleHeader.StyleID INNER JOIN
    uTradePartner WITH (NOLOCK) ON a.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
    uTradePartnerVendor WITH (NOLOCK) ON 
    a.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID LEFT OUTER JOIN
    pStyleColorway WITH (NOLOCK) ON a.StyleColorID = pStyleColorway.StyleColorID  INNER JOIN
   pSampleRequestTrade ON pSampleRequestTrade.SampleRequestTradeID = a.SampleRequestTradeID
   LEFT JOIN pSizeClass sc ON sc.CustomId = pStyleHeader.SizeClassId
   LEFT JOIN pSizeRange sr ON sr.CustomId = pStyleHeader.SizeRangeId
GROUP BY a.SampleRequestTradeID, a.StyleID, a.StyleColorID, 
    a.StyleSet, pStyleHeader.StyleNo, COALESCE(sr.SizeRangeCode, pStyleHeader.SizeRange), pStyleHeader.Description, 
    pStyleHeader.Pc1, pStyleHeader.Pc2, pStyleHeader.Pc3, pStyleHeader.Pc4, COALESCE(sc.Custom, pStyleHeader.SizeClass),
    a.TradePartnerID, a.TradePartnerVendorID, pStyleColorway.MainColor, 
    uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName,  pStyleHeader.DevelopmentID, pStyleHeader.DueDate ,  pStyleHeader.StyleID ,  pSampleRequestTrade.TechPackID
HAVING   pStyleHeader.DevelopmentID = ''' + @DevelopmentID + '''' 


IF @TradePartnerVendorID IS NOT NULL SELECT @select = @select + ' AND a.TradePartnerVendorID = ''' + @TradePartnerVendorID + ''''  
IF @TradePartnerAgentID IS NOT NULL SELECT @select = @select + ' AND a.TradePartnerID = ''' + @TradePartnerAgentID + ''''  
IF @StyleID IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.StyleID = ''' + @StyleID + '''' 
--IF @StyleDescription IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.Description LIKE ''%' + @StyleDescription + '%''' 
--IF @Season IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.' + @CustomFieldSeason + ' = ''' + @Season + '''' 
--IF @Year IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.' + @CustomFieldYear + ' = ''' + @Year + '''' 

SELECT @select = @select + ' ORDER BY uTradePartnerVendor.VendorName, pStyleHeader.StyleNo, a.StyleSet, pStyleColorway.MainColor '

SELECT @enddate = 'MAX(a.EndDate)'
SELECT @duedate = 'MAX(a.DueDate)'
SELECT @pivot = 'a.SampleWorkflowID'
SELECt @table = 'pSampleRequestWorkflow WITH (NOLOCK)'

/*
EXEC ('SELECT ' + @pivot + ' AS pivot INTO ##tmpSampleStyleWorkflow FROM ' + @table + ' WHERE 1=2')
EXEC ('INSERT INTO ##tmpSampleStyleWorkflow SELECT DISTINCT ' + @pivot + ' FROM ' + @table + ' WHERE ' + @pivot + ' Is Not Null AND  StyleID IN (SELECT StyleID FROM pStyleHeader WHERE DevelopmentID = ''' + @DevelopmentID + ''')') 
*/

EXEC ('SELECT ' + @pivot + ' AS tb_pivot, ''0000'' AS SampleWorkflowSort  INTO ##tmpSampleStyleWorkflow FROM pSampleRequestWorkflow  a WITH (NOLOCK) WHERE 1=2')
EXEC ('INSERT INTO ##tmpSampleStyleWorkflow SELECT DISTINCT ' + @pivot + ' ,  c.SampleWorkflowSort  FROM  pSampleRequestWorkflow a WITH (NOLOCK) , pSampleWorkflow c WITH (NOLOCK)  WHERE ' + 
@pivot + ' Is Not Null AND  StyleID IN (SELECT StyleID FROM pStyleHeader WITH (NOLOCK) WHERE DevelopmentID = ''' + @DevelopmentID + ''')   AND  a.SampleWorkflowID = c.SampleWorkflowID ORDER BY  c.SampleWorkflowSort '      ) 



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

SELECT @select=stuff(@select, charindex(' FROM ', @select)+1, 0, ', ' + @sql + '  , pSampleRequestTrade.TechPackID ' )  
-- ,  pSampleRequestTrade.TechPackID , pSampleRequestWorkflow.StyleID

DROP TABLE ##tmpSampleStyleWorkflow

PRINT @select


EXEC (@select)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09705', GetDate())
GO
