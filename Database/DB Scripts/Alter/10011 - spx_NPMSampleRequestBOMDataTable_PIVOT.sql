/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestBOMDataTable_PIVOT]    Script Date: 03/16/2015 16:50:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestBOMDataTable_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestBOMDataTable_PIVOT]
GO

CREATE PROCEDURE [dbo].[spx_NPMSampleRequestBOMDataTable_PIVOT](
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
Link  NVARCHAR(4000), 
AssignedTo INT, 
WorkFlowItemName NVARCHAR(100),
ItemDim1Id uniqueidentifier NULL,
ItemDim2Id uniqueidentifier NULL,
ItemDim3Id uniqueidentifier NULL,
TechPack NVARCHAR(4000),
StyleSet NVARCHAR(200),
SetNo INT,
Season NVARCHAR(200),
Year NVARCHAR(200),
WorkFlowItemID  NVARCHAR(200),
StyleBOMDimensionID  NVARCHAR(200),
StyleBOMDimensionItemID   NVARCHAR(200), 
TradePartnerRelationshipLevelID UNIQUEIDENTIFIER
)


CREATE TABLE #tmpSample2 (
SampleRequestTradeID UNIQUEIDENTIFIER,
SampleWorkflow NVARCHAR(200),
StyleID UNIQUEIDENTIFIER,
SampleRequestSubmitID UNIQUEIDENTIFIER, 
TradePartnerName NVARCHAR(200),
TradePartnerID UNIQUEIDENTIFIER,
AgentID UNIQUEIDENTIFIER,
AgentName NVARCHAR(200),
VendorID UNIQUEIDENTIFIER,
VendorName NVARCHAR(200),
FactoryID UNIQUEIDENTIFIER,
FactoryName NVARCHAR(200),
Link  NVARCHAR(4000),
StyleNo NVARCHAR(50) , 
Description NVARCHAR(100),
SizeClass NVARCHAR(400),
WorkFlowItemName NVARCHAR(200),
Dim1Name NVARCHAR(100),
Dim2Name NVARCHAR(100),
Dim3Name NVARCHAR(100),
ItemDim1Id uniqueidentifier NULL,
ItemDim2Id uniqueidentifier NULL,
ItemDim3Id uniqueidentifier NULL,
TechPack NVARCHAR(4000) ,
StyleSet NVARCHAR(200),
SetNo INT,
Season NVARCHAR(200),
Year NVARCHAR(200),
WorkFlowItemID  NVARCHAR(200),
StyleBOMDimensionID  NVARCHAR(200),
StyleBOMDimensionItemID   NVARCHAR(200)
)


CREATE TABLE #tmpSample3 (
SampleRequestTradeID UNIQUEIDENTIFIER,
SampleWorkflow NVARCHAR(200),
StyleID UNIQUEIDENTIFIER,
SampleRequestSubmitID UNIQUEIDENTIFIER, 
TradePartnerName NVARCHAR(200),
TradePartnerID UNIQUEIDENTIFIER,
AgentID UNIQUEIDENTIFIER,
AgentName NVARCHAR(200),
VendorID UNIQUEIDENTIFIER,
VendorName NVARCHAR(200),
FactoryID UNIQUEIDENTIFIER,
FactoryName NVARCHAR(200),
Link  NVARCHAR(4000),
StyleNo NVARCHAR(50) , 
Description NVARCHAR(100),
SizeClass NVARCHAR(400),
WorkFlowItemName NVARCHAR(200),
Dim1Name NVARCHAR(100),
Dim2Name NVARCHAR(100),
Dim3Name NVARCHAR(100),
ItemDim1Id uniqueidentifier NULL,
ItemDim2Id uniqueidentifier NULL,
ItemDim3Id uniqueidentifier NULL,
TechPack NVARCHAR(4000) ,
StyleSet NVARCHAR(200),
SetNo INT,
Season NVARCHAR(200),
Year NVARCHAR(200),
WorkFlowItemID  NVARCHAR(200),
StyleBOMDimensionID  NVARCHAR(200),
StyleBOMDimensionItemID   NVARCHAR(200)
)



INSERT INTO #tmpSample1 ( 
SampleRequestTradeID, SampleWorkflow, StyleID, SampleRequestSubmitID,
TradePartnerID , Link, 
AssignedTo,WorkFlowItemName, ItemDim1Id,ItemDim2Id,ItemDim3Id, TechPack, StyleSet, SetNo, Season, Year,WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID, TradePartnerRelationshipLevelID )
SELECT 
a.SampleRequestTradeID , f.SampleWorkflow, a.StyleID, a.SampleRequestSubmitID, 
b.TradePartnerID ,
'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
<IMG src=''' + 
CASE 
	WHEN d.ApprovedType = 1  THEN '../System/Icons/icon_ball_green.gif'
	WHEN a.Status = 4  THEN '../System/Icons/icon_ball_red.gif'
	WHEN a.Submit = 1 THEN '../System/Icons/icon_ball_blue.gif'
	ELSE '../System/Icons/icon_ball_yellow.gif'
END
+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp; 
<a href=''#'' onclick="javascript:window.open(''../Sample/SampleRequest_Workflow_Redirect.aspx?SRTID=' 
	+ CAST(a.SampleRequestTradeID AS NVARCHAR(50)) + '&WFIID=' + CAST(isnull(b.WorkFlowItemID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
	+ '&SBOMDID=' + CAST(isnull(b.StyleBOMDimensionID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
	+ '&SBOMDIID=' + CAST(isnull(b.StyleBOMDimensionItemID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
	+ '&FDIM=1' + '&SWID=' + a.SampleWorkflowID + '&SN=' + CAST(a.StyleSet AS NVARCHAR(5)) 	
	+ ''',''' + Replace(CAST(a.SampleRequestTradeID AS NVARCHAR(50)), '-', '') + 
	''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">'
 
+
CASE 
	--WHEN d.ApprovedType = 1 Or a.Status = 4 THEN CONVERT ( NVARCHAR(50), a.EndDate , 101)
	WHEN d.ApprovedType = 1 THEN 
	CASE WHEN a.EndDate IS NULL THEN 'NO DATE'
	ELSE
		CASE UPPER(@PrefLanguage)
		WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 111)
					WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 111)
					WHEN  'DA-DK'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 105)
					WHEN  'SV-FI'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 111)
					WHEN  'FR-CA'  THEN cast( YEAR(a.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(a.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(a.EndDate) AS nvarchar(4) )
					WHEN  'DE-DE'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 104)
					WHEN  'HI-IN'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 105)
					WHEN  'JA-JA'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 111)
					WHEN  'KO-KR'  THEN cast( YEAR(a.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(a.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(a.EndDate) AS nvarchar(4) )
					WHEN  'PL-PL'  THEN cast( YEAR(a.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(a.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(a.EndDate) AS nvarchar(4) )
					WHEN  'PT-PT'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 105)
					WHEN  'RU-RU'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 104)
					WHEN  'SV-SE'  THEN cast( YEAR(a.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(a.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(a.EndDate) AS nvarchar(4) )
					WHEN  'NL-NL'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 105)
					WHEN  'TR-TR'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 104)
					WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), a.EndDate , 101)
					ELSE CONVERT ( NVARCHAR(50), a.EndDate , 103)
		END
	END			
	WHEN a.Status = 4 THEN 
	CASE WHEN a.MDate IS NULL THEN 'NO DATE'
	ELSE 
		CASE UPPER(@PrefLanguage)
					WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), a.MDate , 111)
					WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), a.MDate , 111)
					WHEN  'DA-DK'  THEN CONVERT ( NVARCHAR(50), a.MDate , 105)
					WHEN  'SV-FI'  THEN CONVERT ( NVARCHAR(50), a.MDate , 111)
					WHEN  'FR-CA'  THEN cast( YEAR(a.MDate) AS nvarchar(4) ) + '-' +cast( MONTH(a.MDate) AS nvarchar(4) ) + '-' +cast( DAY(a.MDate) AS nvarchar(4) )
					WHEN  'DE-DE'  THEN CONVERT ( NVARCHAR(50), a.MDate , 104)
					WHEN  'HI-IN'  THEN CONVERT ( NVARCHAR(50), a.MDate , 105)
					WHEN  'JA-JA'  THEN CONVERT ( NVARCHAR(50), a.MDate , 111)
					WHEN  'KO-KR'  THEN cast( YEAR(a.MDate) AS nvarchar(4) ) + '-' +cast( MONTH(a.MDate) AS nvarchar(4) ) + '-' +cast( DAY(a.MDate) AS nvarchar(4) )
					WHEN  'PL-PL'  THEN cast( YEAR(a.MDate) AS nvarchar(4) ) + '-' +cast( MONTH(a.MDate) AS nvarchar(4) ) + '-' +cast( DAY(a.MDate) AS nvarchar(4) )
					WHEN  'PT-PT'  THEN CONVERT ( NVARCHAR(50), a.MDate , 105)
					WHEN  'RU-RU'  THEN CONVERT ( NVARCHAR(50), a.MDate , 104)
					WHEN  'SV-SE'  THEN cast( YEAR(a.MDate) AS nvarchar(4) ) + '-' +cast( MONTH(a.MDate) AS nvarchar(4) ) + '-' +cast( DAY(a.MDate) AS nvarchar(4) )
					WHEN  'NL-NL'  THEN CONVERT ( NVARCHAR(50), a.MDate , 105)
					WHEN  'TR-TR'  THEN CONVERT ( NVARCHAR(50), a.MDate , 104)
					WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), a.MDate , 101)
					ELSE CONVERT ( NVARCHAR(50), a.MDate , 103)
		END		
	END		
	ELSE
	CASE WHEN a.DueDate IS NULL THEN 'NO DATE'
	ELSE 
		CASE UPPER(@PrefLanguage)
					WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 111)
					WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 111)
					WHEN  'DA-DK'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 105)
					WHEN  'SV-FI'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 111)
					WHEN  'FR-CA'  THEN cast( YEAR(a.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(a.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(a.DueDate) AS nvarchar(4) )
					WHEN  'DE-DE'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 104)
					WHEN  'HI-IN'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 105)
					WHEN  'JA-JA'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 111)
					WHEN  'KO-KR'  THEN cast( YEAR(a.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(a.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(a.DueDate) AS nvarchar(4) )
					WHEN  'PL-PL'  THEN cast( YEAR(a.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(a.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(a.DueDate) AS nvarchar(4) )
					WHEN  'PT-PT'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 105)
					WHEN  'RU-RU'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 104)
					WHEN  'SV-SE'  THEN cast( YEAR(a.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(a.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(a.DueDate) AS nvarchar(4) )
					WHEN  'NL-NL'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 105)
					WHEN  'TR-TR'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 104)
					WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), a.DueDate , 101)
					ELSE CONVERT ( NVARCHAR(50), a.DueDate , 103)
		END	
	END		
END 
+ '&nbsp;<b>(' 
+  CAST(a.Submit AS NVARCHAR(5)) + ')</b></a></TD></TR></TABLE>'

AS Link, 
a.AssignedTo, wi.WorkFlowItemName ,b.ItemDim1Id, b.ItemDim2Id,  b.ItemDim3Id,  

CASE	
	WHEN  g.TechPackID IS NULL  THEN '<div align=center>-------</div>'	
	ELSE 
	'<TABLE>
			<TR>
			<TD width=''18''><IMG src=''../System/Icons/icon_packageok.gif'' border=''0''></TD>
			<TD class=''font'' align=''center'' valign=''center'' nowrap>&nbsp;
			<a href=''#'' onclick="javascript:window.open(''../Sample/SampleRequest_Workflow_Redirect.aspx?SRTID='
			+ CAST (a.SampleRequestTradeID AS NVARCHAR(50))
			+ '&FDIM=1' 
			+ '&SID=' + CAST(a.StyleID AS NVARCHAR(50)) 
			+ '&SN=' + CAST(a.StyleSet AS NVARCHAR(10)) 
			+ '&SYID=' + CAST(isnull(h.SeasonYearID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
			+ '&TP=1'' , ''' 
			+ REPLACE ( CAST ( a.SampleRequestTradeID  AS NVARCHAR(50) ), '-', '' ) 

			+ ''',  ''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'' ' 
			+ ' );" >  ' 			
			+ CASE UPPER(@PrefLanguage)
					WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 111)
					WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 111)
					WHEN  'DA-DK'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 105)
					WHEN  'SV-FI'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 111)
					WHEN  'FR-CA'  THEN cast( YEAR(g.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(g.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(g.DueDate) AS nvarchar(4) )
					WHEN  'DE-DE'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 104)
					WHEN  'HI-IN'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 105)
					WHEN  'JA-JA'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 111)
					WHEN  'KO-KR'  THEN cast( YEAR(g.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(g.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(g.DueDate) AS nvarchar(4) )
					WHEN  'PL-PL'  THEN cast( YEAR(g.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(g.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(g.DueDate) AS nvarchar(4) )
					WHEN  'PT-PT'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 105)
					WHEN  'RU-RU'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 104)
					WHEN  'SV-SE'  THEN cast( YEAR(g.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(g.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(g.DueDate) AS nvarchar(4) )
					WHEN  'NL-NL'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 105)
					WHEN  'TR-TR'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 104)
					WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), g.DueDate , 101)
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
END AS StyleSet, a.StyleSet as SetNo, i.Season, i.Year,b.WorkFlowItemID,b.StyleBOMDimensionID,b.StyleBOMDimensionItemID, b.TradePartnerRelationshipLevelID
FROM dbo.pSampleRequestSubmitBOM a
INNER JOIN pSampleRequestBOMTrade b ON a.SampleRequestTradeID  = b.SampleRequestTradeID
INNER JOIN pWorkFlowItem wi ON wi.WorkFlowItemID = b.WorkFlowItemID
INNER JOIN pSampleWorkflow c ON a.SampleWorkflowId = c.SampleWorkflowID 
INNER JOIN pSampleRequestSubmitStatus d ON a.Status   = d.StatusID	
INNER JOIN pSampleRequestWorkflowBOM e ON e.SampleRequestWorkflowID = a.SampleRequestWorkflowID
										AND e.Submit = a.Submit		--Comment #01
INNER JOIN pSampleWorkflow f ON f.SampleWorkflowID  =  e.SampleWorkflowID 
INNER JOIN pStyleHeader g ON g.StyleID = b.StyleID
LEFT OUTER JOIN pStyleSeasonYear h ON h.StyleSeasonYearID =  b.StyleSeasonyearID 
LEFT OUTER JOIN pSeasonYear i ON i.SeasonYearID =  h.SeasonYearID
WHERE e.StyleID IN (SELECT StyleID FROM pStyleDevelopmentItem WHERE StyleDevelopmentID = @StyleDevelopmentID)
	AND i.SeasonYearID = @SeasonYearID


DECLARE @SQL NVARCHAR(MAX) 

DECLARE @flag INT  
SET @flag = 0


-- because workflow item copy procedure doesn't generate new id's for ItemDim1Id, ItemDim2Id and ItemDim3Id
-- we need to join pStyleBOMDimensionItem on StyleBOMDimensionID too,
-- so the whole query won't join data from other workflow items
SET @SQL = 'INSERT INTO #tmpSample2 (SampleRequestTradeID, SampleWorkflow, StyleID, SampleRequestSubmitID,
TradePartnerID, TradePartnerName, AgentID, AgentName, VendorID, VendorName, FactoryID, FactoryName, 
Link, StyleNo, Description, SizeClass, WorkFlowItemName, Dim1Name,Dim2Name,Dim3Name, ItemDim1Id,ItemDim2Id,ItemDim3Id, TechPack, StyleSet , SetNo, Season, Year,WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID )
SELECT a.SampleRequestTradeID, a.SampleWorkflow, a.StyleID, a.SampleRequestSubmitID, 
a.TradePartnerID, b.TradePartnerName, tpm.AgentID, tpm.AgentName, tpm.VendorID, tpm.VendorName, tpm.FactoryID, tpm.FactoryName, 
a.Link , d.StyleNo, d.Description, COALESCE(sc.Custom, d.SizeClass), a.WorkFlowItemName, g.ItemDim1Name,h.ItemDim2Name,j.ItemDim3Name, a.ItemDim1Id,a.ItemDim2Id,a.ItemDim3Id, a.TechPack, a.StyleSet, a.SetNo, a.Season, a.Year,a.WorkFlowItemID,a.StyleBOMDimensionID,a.StyleBOMDimensionItemID
FROM #tmpSample1 a
INNER JOIN uTradePartner b ON b.TradePartnerID = a.TradePartnerID
INNER JOIN pStyleHeader d ON d.StyleID = a.StyleID 
LEFT OUTER JOIN pStyleBOMDimensionItem g ON g.ItemDim1Id = a.ItemDim1Id AND g.StyleBOMDimensionID = a.StyleBOMDimensionID
LEFT OUTER JOIN pStyleBOMDimensionItem h ON h.ItemDim2Id = a.ItemDim2Id AND h.StyleBOMDimensionID = a.StyleBOMDimensionID
LEFT OUTER JOIN pStyleBOMDimensionItem j ON j.ItemDim3Id = a.ItemDim3Id AND j.StyleBOMDimensionID = a.StyleBOMDimensionID
LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationshipLevelID = a.TradePartnerRelationshipLevelID 
LEFT JOIN pSizeClass sc ON sc.CustomID = d.SizeClassId
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
'SELECT SampleWorkflow, Link , SampleRequestTradeID, StyleID, TradePartnerID , TradePartnerName, 
StyleNo, Description, SizeClass,WorkFlowItemName, Dim1Name,Dim2Name,Dim3Name, TechPack, StyleSet, SetNo, Season, Year,WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID,  
AgentID, AgentName, VendorID, VendorName, FactoryID, FactoryName 
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
VALUES ('DB_Version', '6.1.0000', '10011', GetUTCDate())
GO
