IF EXISTS(select * from information_schema.routines where specific_name = N'spx_SampleRequestGridAgentShared_SELECT_NEW')
   DROP PROCEDURE spx_SampleRequestGridAgentShared_SELECT_NEW
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestGridAgentShared_SELECT_NEW] 
(
@TradePartnerID nvarchar(50),
@StyleNo nvarchar(200) = NULL,
@StyleDescription nvarchar(200) = NULL,
@sqlSelect varchar(8000) = NULL
)
AS

DECLARE @UserID varchar(10), @sql varchar(8000), @delim varchar(1), @select varchar(8000), @enddate varchar(100), @duedate varchar(100), @pivot varchar(100), @table varchar(100)

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

SELECT @select = 'SELECT TOP 100  uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName,  pSampleRequestWorkflow.SampleRequestTradeID, 
	pSampleRequestWorkflow.StyleColorID, pSampleRequestWorkflow.StyleID, 
	pSampleRequestWorkflow.StyleSet, pStyleHeader.StyleNo AS [Style No], 
	pStyleHeader.SizeRange AS [Size], pStyleHeader.Description, 
CASE 
WHEN pSampleRequestWorkflow.StyleSet = 1 THEN 
	CASE WHEN pStyleHeader.PC1 Is Not Null THEN pStyleHeader.PC1 ELSE ''1st Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 2 THEN 
	CASE WHEN pStyleHeader.PC2 Is Not Null THEN pStyleHeader.PC2 ELSE ''2nd Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 3 THEN 
	CASE WHEN pStyleHeader.PC3 Is Not Null THEN pStyleHeader.PC3 ELSE ''3rd Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 4 THEN 
	CASE WHEN pStyleHeader.PC4 Is Not Null THEN pStyleHeader.PC4 ELSE ''4th Set'' END 
END AS [Style Set], pStyleColorway.MainColor AS Color FROM pSampleRequestWorkflow INNER JOIN
	pStyleHeader ON pSampleRequestWorkflow.StyleID = pStyleHeader.StyleID LEFT OUTER JOIN
	pStyleColorway ON pSampleRequestWorkflow.StyleColorID = pStyleColorway.StyleColorID INNER JOIN
	pSampleRequestTrade ON pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID

	INNER JOIN  uTradePartner ON pSampleRequestWorkflow.TradePartnerID =  uTradePartner.TradePartnerID INNER JOIN
	uTradePartnerVendor ON  pSampleRequestWorkflow.TradePartnerVendorID =  uTradePartnerVendor.TradePartnerVendorID

GROUP BY pSampleRequestWorkflow.SampleRequestTradeID, pSampleRequestWorkflow.StyleID, pSampleRequestWorkflow.StyleColorID, 
   pSampleRequestWorkflow.StyleSet, pStyleHeader.StyleNo, pStyleHeader.SizeRange, pStyleHeader.Description, 
   pSampleRequestWorkflow.StyleSet, pStyleHeader.Pc1, pStyleHeader.Pc2, pStyleHeader.Pc3, pStyleHeader.Pc4, 
   pSampleRequestWorkflow.TradePartnerID, pStyleColorway.MainColor, pSampleRequestTrade.SampleRequestShare,

   uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName	

HAVING pSampleRequestWorkflow.TradePartnerID = ''' + @TradePartnerID + ''' AND (pSampleRequestTrade.SampleRequestShare = 1) AND
	pSampleRequestWorkflow.SampleRequestTradeID IN (' + @sqlSelect + ')'

--IF @StyleNo IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.StyleNo LIKE ''%' + @StyleNo + '%''' 
--IF @StyleDescription IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.Description LIKE ''%' + @StyleDescription + '%''' 

SELECT @select = @select + ' ORDER BY pStyleHeader.StyleNo, pSampleRequestWorkflow.StyleSet '

SELECT @enddate = 'MAX(pSampleRequestWorkflow.EndDate)'
SELECT @duedate = 'MAX(pSampleRequestWorkflow.DueDate)'
SELECT @pivot = 'pSampleRequestWorkflow.SampleWorkflowID'
SELECt @table = 'pSampleRequestWorkflow'

--PRINT ('SELECT ' + @pivot + ' AS pivot INTO ##tmpSampleWorkflow FROM ' + @table + ' WHERE 1=2')
EXEC ('SELECT ' + @pivot + ' AS pivot INTO ##tmpSampleWorkflow FROM ' + @table + ' WHERE 1=2 AND SampleRequestTradeID IN (' + @sqlSelect + ')')

--PRINT ('INSERT INTO ##tmpSampleWorkflow SELECT DISTINCT ' + @pivot + ' FROM ' + @table + ' WHERE TradePartnerID = ''{' + @TradePartnerID + '}''' + ' AND ' + @pivot + ' Is Not Null')
EXEC ('INSERT INTO ##tmpSampleWorkflow SELECT DISTINCT ' + @pivot + ' FROM ' + @table + ' WHERE SampleRequestTradeID IN (' + @sqlSelect + ')' + ' AND ' + @pivot + ' Is Not Null')

SELECT @sql='',  @duedate=stuff(@duedate, len(@duedate), 1, ' END)' )
SELECT @sql=@sql + '',  @enddate=stuff(@enddate, len(@enddate), 1, ' END)' )

SELECT @delim=CASE Sign( CharIndex('char', data_type) + CharIndex('date', data_type) ) 
	WHEN 0 THEN '''' ELSE '''' END 
	FROM tempdb.information_schema.columns 
WHERE table_name='##tmpSampleWorkflow' AND column_name='pivot'

SELECT @sql=@sql + '''D_' + convert(varchar(100), @pivot) + ''' = ' + 
	stuff(@duedate,charindex( '(', @duedate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
	+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
	+ '''E_' + convert(varchar(100), @pivot) + ''' = ' + 
	stuff(@enddate,charindex( '(', @enddate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
	+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
FROM ##tmpSampleWorkflow

IF @sql is not null AND LEN(@SQL) > 0
begin 
	SELECT @sql=left(@sql, len(@sql)-1)
	SELECT @select=stuff(@select, charindex(' FROM ', @select)+1, 0, ', ' + @sql + ' ')
end 

DROP TABLE ##tmpSampleWorkflow

-- PRINT (@select)
EXEC (@select)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01362', GetDate())

GO