IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingSampleRequestSubmit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSourcingSampleRequestSubmit_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleSourcingSampleRequestSubmit_SELECT] (
@StyleSourcingID UNIQUEIDENTIFIER 
)
AS 


SELECT a.SampleWorkflowID as tb_pivot , c.SampleWorkflowSort
INTO #tmpSampleStyleWorkflow 
FROM dbo.pSampleRequestSubmit a
INNER JOIN pSampleRequestTrade b ON a.SampleRequestTradeID  = b.SampleRequestTradeID  
INNER JOIN pSampleWorkflow c ON a.SampleWorkflowId = c.SampleWorkflowID 
WHERE b.StyleSourcingID = @StyleSourcingID 
ORDER BY SampleWorkflowSort 

DECLARE @sql nvarchar(max)
DECLARE @PIVOT nvarchar(max)
DECLARE @flag int 
SET @flag = 0 

SET @PIVOT = ''
set @sql= ''

SELECT @PIVOT=@PIVOT + '''_srsi_' + tb_pivot + ''' =  MAX( CASE a.SampleWorkflowID WHEN ''' + tb_pivot 
+ ''' THEN  CASE WHEN a.SampleRequestSubmitID  IS NULL THEN '''' ELSE CAST(a.SampleRequestSubmitID AS NVARCHAR(50)) END END ) ,'
FROM #tmpSampleStyleWorkflow

if LEN(@PIVOT) > 1
BEGIN
	SET @PIVOT=LEFT(@PIVOT, LEN(@PIVOT)-1)
	SET @flag = 1 
END

SET @sql = 'SELECT a.SampleRequestTradeID , d.VendorName , e.TradePartnerName as AgentName, 
g.StyleColorName, f.StyleNo,  f.SizeClass, f.Description, f.StyleSet, 

CASE 
	WHEN  b.TechPackID IS NULL  OR b.TechPackID  = ''00000000-0000-0000-0000-000000000000'' THEN ''<div align=center>-------</div>''
	ELSE  
	''<TABLE>
			<TR>
			<TD width=''''18''''><IMG src=''''../System/Icons/icon_packageok.gif'''' border=''''0''''></TD>
			<TD class=''''font'''' align=''''center'''' valign=''''center'''' nowrap>&nbsp;

			<a href=''''#'''' onclick="javascript:window.open(''''../Sample/SampleRequest_Workflow_Redirect.aspx?SRTID=''

			+ CAST (a.SampleRequestTradeID AS NVARCHAR(50))
			+ ''&SN='' + CAST(f.StyleSet AS NVARCHAR(10)) 
			+ ''&TP=1'''','' 

			+ '' '''''' + REPLACE ( CAST ( a.SampleRequestTradeID  AS NVARCHAR(50) ) , ''-'', '''' ) 

			+ '''''',   ''''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes''''    '' 
			+ '' );" >  '' 
			
			+ CONVERT ( NVARCHAR(50), f.DueDate , 101)   +  ''</a>

			</TD></TR></TABLE>''
	END AS TechPack

' 

IF  LEN (@PIVOT) >  0 
	SET @sql = @sql +  ' , ' + @PIVOT

SET @sql = @sql + '		

FROM dbo.pSampleRequestSubmit a
INNER JOIN pSampleRequestTrade b ON a.SampleRequestTradeID  = b.SampleRequestTradeID  
INNER JOIN pSampleRequestSubmitStatus c ON a.Status  = c.StatusID 
INNER JOIN uTradepartnerVendor d ON a.TradePartnerVendorID = d.TradePartnerVendorID 
INNER JOIN uTradePartner e ON  a.TradePartnerID  = e.TradePartnerID 
INNER JOIN pStyleHeader f ON a.StyleID = f.StyleID 

LEFT OUTER JOIN pStyleColorway g ON a.StyleColorID  = g.StyleColorID
WHERE b.StyleSourcingID = ''' +  CAST (@StyleSourcingID  AS NVARCHAR(50)) + '''  
GROUP BY  a.SampleRequestTradeID , d.VendorName , e.TradePartnerName, g.StyleColorName,
f.StyleNo,  f.SizeClass, f.Description, f.StyleSet, b.TechPackID, f.DueDate 
'

EXEC (@sql )

--PRINT @sql 

drop table #tmpSampleStyleWorkflow

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03829', GetDate())
GO
