IF OBJECT_ID(N'[dbo].[spx_SampleRequestSilhoDataTable_PIVOT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestSilhoDataTable_PIVOT]
GO

/*
Comments:

#01 - Ryan Cabanas - December 4, 2009
	Modified the JOIN between 'pSampleRequestSubmit' and 'pSampleRequestWorkflow' so
that the latest submit is SELECTED.

*/

CREATE PROCEDURE [dbo].[spx_SampleRequestSilhoDataTable_PIVOT](
@StyleDevelopmentID	UNIQUEIDENTIFIER, 
@UserID	INT, 
@Filter NVARCHAR (4000),
@PrefLanguage NVARCHAR (50),
@SeasonYearID UNIQUEIDENTIFIER
)
AS 


CREATE TABLE #tmpSample1 (
SampleRequestTradeID UNIQUEIDENTIFIER,
SampleWorkflow NVARCHAR(200),
StyleID UNIQUEIDENTIFIER,
SampleRequestSubmitID UNIQUEIDENTIFIER, 
TradePartnerID UNIQUEIDENTIFIER, 
TradePartnerVendorID UNIQUEIDENTIFIER,
Link  NVARCHAR(4000), 
AssignedTo INT, 
StyleColorID UNIQUEIDENTIFIER ,
TechPack NVARCHAR(4000),
StyleSet NVARCHAR(200),
SetNo INT,
Season NVARCHAR(200),
Year NVARCHAR(200)
)


CREATE TABLE #tmpSample2 (
SampleRequestTradeID UNIQUEIDENTIFIER,
SampleWorkflow NVARCHAR(200),
StyleID UNIQUEIDENTIFIER,
SampleRequestSubmitID UNIQUEIDENTIFIER, 
TradePartnerName NVARCHAR(200),
VendorName NVARCHAR(200),
TradePartnerID UNIQUEIDENTIFIER, 
TradePartnerVendorID UNIQUEIDENTIFIER,
Link  NVARCHAR(4000),
StyleNo NVARCHAR(50) , 
Description NVARCHAR(100),
SizeClass NVARCHAR(400),
Colorway NVARCHAR (200),
TechPack NVARCHAR(4000) ,
StyleSet NVARCHAR(200),
SetNo INT,
Season NVARCHAR(200),
Year NVARCHAR(200)
)


CREATE TABLE #tmpSample3 (
SampleRequestTradeID UNIQUEIDENTIFIER,
SampleWorkflow NVARCHAR(200),
StyleID UNIQUEIDENTIFIER,
SampleRequestSubmitID UNIQUEIDENTIFIER, 
TradePartnerName NVARCHAR(200),
VendorName NVARCHAR(200),
TradePartnerID UNIQUEIDENTIFIER, 
TradePartnerVendorID UNIQUEIDENTIFIER,
Link  NVARCHAR(4000),
StyleNo NVARCHAR(50) , 
Description NVARCHAR(100),
SizeClass NVARCHAR(400),
Colorway NVARCHAR (200),
TechPack NVARCHAR(4000) ,
StyleSet NVARCHAR(200),
SetNo INT,
Season NVARCHAR(200),
Year NVARCHAR(200)
)



INSERT INTO #tmpSample1 ( 
SampleRequestTradeID, SampleWorkflow, StyleID, SampleRequestSubmitID,
TradePartnerID , TradePartnerVendorID, Link, 
AssignedTo, StyleColorID, TechPack, StyleSet, SetNo, Season, Year  )
SELECT 
a.SampleRequestTradeID , f.SampleWorkflow, a.StyleID, a.SampleRequestSubmitID, 
b.TradePartnerID , b.TradePartnerVendorID, 
'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
<IMG src=''' + 
CASE 
	WHEN d.ApprovedType = 1  THEN '../System/Icons/icon_ball_green.gif'
	WHEN a.Status = 4  THEN '../System/Icons/icon_ball_red.gif'
	WHEN a.Submit = 1 THEN '../System/Icons/icon_ball_blue.gif'
	ELSE '../System/Icons/icon_ball_yellow.gif'
END
+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp; 
<a href=''#'' onclick="javascript:window.open(''../Sample/SampleRequest_Workflow_Redirect.aspx?SRTID=' + 
CAST ( a.SampleRequestTradeID AS NVARCHAR(50)) + '&SWID=' + a.SampleWorkflowID + '&SN='+  CAST(a.StyleSet  as nvarchar(5)) +
''',''' +  
Replace( CAST ( a.SampleRequestTradeID AS NVARCHAR(50)) , '-', '') +
''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">' 
+
CASE 
	--WHEN d.ApprovedType = 1 Or a.Status = 4 THEN CONVERT ( NVARCHAR(50), a.EndDate , 101)
	WHEN d.ApprovedType = 1 THEN 
		CASE UPPER(@PrefLanguage)
			WHEN 'EN-US'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 101)
			WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 111)
			WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 111)
			ELSE CONVERT ( NVARCHAR(50), a.EndDate , 103)
		END		
	WHEN a.Status = 4 THEN 
		CASE UPPER(@PrefLanguage)
			WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), a.MDate , 101)	
			WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), a.MDate , 111)
			WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), a.MDate , 111)			
			ELSE CONVERT ( NVARCHAR(50), a.MDate , 103)
		END				
	ELSE 
		CASE UPPER(@PrefLanguage)
			WHEN 'EN-US'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 101)
			WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 111)
			WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 111)
			ELSE CONVERT ( NVARCHAR(50), a.DueDate , 103)
		END			
END 
+ '&nbsp;<b>(' 
+  CAST(a.Submit AS NVARCHAR(5)) + ')</b></a></TD></TR></TABLE>'

AS Link, 
a.AssignedTo, b.StyleColorID , 

CASE	
	WHEN  g.TechPackID IS NULL  THEN '<div align=center>-------</div>'	
	ELSE 
	'<TABLE>
			<TR>
			<TD width=''18''><IMG src=''../System/Icons/icon_packageok.gif'' border=''0''></TD>
			<TD class=''font'' align=''center'' valign=''center'' nowrap>&nbsp;
			<a href=''#'' onclick="javascript:window.open(''../Sample/SampleRequest_Workflow_Redirect.aspx?SRTID='
			+ CAST (a.SampleRequestTradeID AS NVARCHAR(50))
			+ '&SN=' + CAST(a.StyleSet AS NVARCHAR(10)) 
			+ '&SYID=' + CAST(isnull(h.SeasonYearID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
			+ '&TP=1'' , ''' 
			+ REPLACE ( CAST ( a.SampleRequestTradeID  AS NVARCHAR(50) ), '-', '' ) 

			+ ''',  ''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'' ' 
			+ ' );" >  ' 			
			+ CASE UPPER(@PrefLanguage)
					WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 101)
					WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 111)
					WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 111)
					ELSE CONVERT ( NVARCHAR(50), g.DueDate , 103)
			  END			
			+ '</a></TD></TR></TABLE>'			
	END AS TechPack ,

CASE 
	WHEN a.StyleSet = 1 THEN 
		CASE WHEN g.PC1 Is Not Null THEN g.PC1 ELSE '1st Set' END
	WHEN a.StyleSet = 2 THEN 
		CASE WHEN g.PC2 Is Not Null THEN g.PC2 ELSE '2nd Set' END
	WHEN a.StyleSet = 3 THEN 
		CASE WHEN g.PC3 Is Not Null THEN g.PC3 ELSE '3rd Set' END
	WHEN a.StyleSet = 4 THEN 
		CASE WHEN g.PC4 Is Not Null THEN g.PC4 ELSE '4th Set' END 
END AS StyleSet, a.StyleSet as SetNo, i.Season, i.Year 
FROM dbo.pSampleRequestSubmit a
INNER JOIN pSampleRequestTrade b ON a.SampleRequestTradeID  = b.SampleRequestTradeID  
INNER JOIN pSampleWorkflow c ON a.SampleWorkflowId = c.SampleWorkflowID 
INNER JOIN pSampleRequestSubmitStatus d ON a.Status   = d.StatusID	
INNER JOIN pSampleRequestWorkflow e ON e.SampleRequestWorkflowID = a.SampleRequestWorkflowID
										AND e.Submit = a.Submit		--Comment #01
INNER JOIN pSampleWorkflow f ON f.SampleWorkflowID  =  e.SampleWorkflowID 
INNER JOIN pStyleHeader g ON g.StyleID = b.StyleID
LEFT OUTER JOIN pStyleSeasonYear h ON h.StyleSeasonYearID =  b.StyleSeasonyearID 
LEFT OUTER JOIN pSeasonYear i ON i.SeasonYearID =  h.SeasonYearID
WHERE e.StyleID IN ( 
	SELECT wi.StyleID FROM pWorkFlowItemLinked link
	INNER JOIN pWorkflowItem wi ON wi.WorkFlowItemID = link.WorkFlowItemID
	INNER JOIN pStyleDevelopmentItem sdi ON sdi.StyleID = link.StyleID
	WHERE wi.WorkflowID = '40000000-0000-0000-0000-000000000050'
	AND sdi.StyleDevelopmentID = @StyleDevelopmentID
)
	AND i.SeasonYearID = @SeasonYearID


DECLARE @SQL NVARCHAR(4000) 

DECLARE @flag INT  
SET @flag = 0



SET @SQL = 'INSERT INTO #tmpSample2 (SampleRequestTradeID, SampleWorkflow, StyleID, SampleRequestSubmitID,
TradePartnerID, TradePartnerVendorID , TradePartnerName,VendorName,
Link, StyleNo, Description, SizeClass, Colorway, TechPack, StyleSet , SetNo, Season, Year  )
SELECT a.SampleRequestTradeID, a.SampleWorkflow, a.StyleID, a.SampleRequestSubmitID, 
a.TradePartnerID, a.TradePartnerVendorID , b.TradePartnerName,c.VendorName,
a.Link , d.StyleNo, d.Description, COALESCE(sc.Custom, d.SizeClass), g.StyleColorName, a.TechPack, a.StyleSet, a.SetNo, a.Season, a.Year
FROM #tmpSample1 a
INNER JOIN uTradePartner b ON b.TradePartnerID = a.TradePartnerID
INNER JOIN uTradePartnerVendor c ON c.TradePartnerVendorID = a.TradePartnerVendorID  
INNER JOIN pStyleHeader d ON d.StyleID = a.StyleID 
LEFT OUTER JOIN pStyleColorway g ON g.StyleColorID = a.StyleColorID
LEFT JOIN pSizeClass sc ON sc.CustomId = d.SizeClassId
'

IF @UserID IS NOT NULL AND @UserID > 0
BEGIN
	SET @SQL = @SQL + ' WHERE a.AssignedTo = '  + CAST ( @UserID AS NVARCHAR (10)) 
END 

EXEC (@SQL)

IF @Filter IS NOT NULL AND LEN(@Filter) > 0 
	SET @SQL = 'INSERT INTO #tmpSample3  SELECT * FROM #tmpSample2 WHERE ' + @Filter 
ELSE 
	SET @SQL = 'INSERT INTO #tmpSample3  
				SELECT * FROM #tmpSample2 '

EXEC (@SQL) 

/*
PRINT (@SQL)
select * from #tmpSample2
select * from #tmpSample3
*/




EXECUTE spx_Crosstab 
'SELECT SampleWorkflow, Link , SampleRequestTradeID, StyleID, TradePartnerID , TradePartnerVendorID, TradePartnerName, 
VendorName, StyleNo, Description, SizeClass, Colorway, TechPack, StyleSet, SetNo, Season, Year  
FROM #tmpSample3',
NULL,
NULL,
'SampleWorkflow',
'Link',
'MAX'

DROP TABLE #tmpSample1
DROP TABLE #tmpSample2
DROP TABLE #tmpSample3


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09712', GetDate())
GO
