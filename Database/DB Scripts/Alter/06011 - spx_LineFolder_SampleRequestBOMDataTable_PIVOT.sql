/****** Object:  StoredProcedure [dbo].[spx_LineFolder_SampleRequestBOMDataTable_PIVOT]    Script Date: 07/09/2013 16:38:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SampleRequestBOMDataTable_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SampleRequestBOMDataTable_PIVOT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_SampleRequestBOMDataTable_PIVOT]    Script Date: 07/09/2013 16:38:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_LineFolder_SampleRequestBOMDataTable_PIVOT] (
@LineFolderID UNIQUEIDENTIFIER,
@Filter NVARCHAR (4000),
@PrefLanguage NVARCHAR (50)
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
TradePartnerRelationshipLevelID UNIQUEIDENTIFIER,
Variation NVARCHAR(200)
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
AgentCode NVARCHAR(200),
VendorID UNIQUEIDENTIFIER,
VendorName NVARCHAR(200),
VendorCode NVARCHAR(200),
FactoryID UNIQUEIDENTIFIER,
FactoryName NVARCHAR(200),
FactoryCode NVARCHAR(200),
Link  NVARCHAR(4000),
StyleNo NVARCHAR(50) , 
Description NVARCHAR(100),
SizeClass NVARCHAR(50),
StyleCategoryID UNIQUEIDENTIFIER,
StyleCategory NVARCHAR(200),
StyleTypeID INT,
StyleType NVARCHAR(200),
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
StyleBOMDimensionItemID   NVARCHAR(200),
Variation NVARCHAR(200)
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
AgentCode NVARCHAR(200),
VendorID UNIQUEIDENTIFIER,
VendorName NVARCHAR(200),
VendorCode NVARCHAR(200),
FactoryID UNIQUEIDENTIFIER,
FactoryName NVARCHAR(200),
FactoryCode NVARCHAR(200),
Link  NVARCHAR(4000),
StyleNo NVARCHAR(50) , 
Description NVARCHAR(100),
SizeClass NVARCHAR(50),
StyleCategoryID UNIQUEIDENTIFIER,
StyleCategory NVARCHAR(200),
StyleTypeID INT,
StyleType NVARCHAR(200),
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
StyleBOMDimensionItemID   NVARCHAR(200),
Variation NVARCHAR(200)
)

DECLARE @SeasonYearID UNIQUEIDENTIFIER
SELECT @SeasonYearID = seasonYearId FROM pLineFolder WHERE LineFolderID = @LineFolderID

INSERT INTO #tmpSample1 ( 
SampleRequestTradeID, SampleWorkflow, StyleID, SampleRequestSubmitID,
TradePartnerID , Link, 
AssignedTo, ItemDim1Id,ItemDim2Id,ItemDim3Id, TechPack, StyleSet, SetNo, Season, Year,WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID, TradePartnerRelationshipLevelID, Variation )
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
<a href=''#'' onclick="javascript:window.open(''../Sample/SampleRequest_Workflow_Redirect.aspx?SRTID=' + 
CAST ( a.SampleRequestTradeID AS NVARCHAR(50)) + '&WFIID=' + CAST (isnull(b.WorkFlowItemID,'00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&SBOMDID=' + CAST (isnull(b.StyleBOMDimensionID,'00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&SBOMDIID=' + CAST (isnull(b.StyleBOMDimensionItemID,'00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&FDIM=1' + '&SWID=' + a.SampleWorkflowID + '&SN='+  CAST(a.StyleSet  as nvarchar(5)) +
''',''' +  
Replace( CAST ( a.SampleRequestTradeID AS NVARCHAR(50)) , '-', '') +
''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">' 
+
CASE 
	--WHEN d.ApprovedType = 1 Or a.Status = 4 THEN CONVERT ( NVARCHAR(50), a.EndDate , 101)
	WHEN d.ApprovedType = 1 THEN 
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
	WHEN a.Status = 4 THEN 
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
+ '&nbsp;<b>(' 
+  CAST(a.Submit AS NVARCHAR(5)) + ')</b></a></TD></TR></TABLE>'

AS Link, 
a.AssignedTo, b.ItemDim1Id, b.ItemDim2Id,  b.ItemDim3Id,  

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
END AS StyleSet, a.StyleSet as SetNo, i.Season, i.Year,b.WorkFlowItemID,b.StyleBOMDimensionID,b.StyleBOMDimensionItemID, b.TradePartnerRelationshipLevelID,
ISNULL(j.StyleDevelopmentName, 'Variation ' + CAST(j.Variation AS Varchar(2))) AS Variation
FROM dbo.pSampleRequestSubmitBOM a
INNER JOIN pSampleRequestBOMTrade b ON a.SampleRequestTradeID  = b.SampleRequestTradeID  
INNER JOIN pSampleWorkflow c ON a.SampleWorkflowId = c.SampleWorkflowID 
INNER JOIN pSampleRequestSubmitStatus d ON a.Status   = d.StatusID	
INNER JOIN pSampleRequestWorkflowBOM e ON e.SampleRequestWorkflowID = a.SampleRequestWorkflowID
										AND e.Submit = a.Submit		--Comment #01
INNER JOIN pSampleWorkflow f ON f.SampleWorkflowID  =  e.SampleWorkflowID 
INNER JOIN pStyleHeader g ON g.StyleID = b.StyleID
LEFT OUTER JOIN pStyleSeasonYear h ON h.StyleSeasonYearID =  b.StyleSeasonyearID 
LEFT OUTER JOIN pSeasonYear i ON i.SeasonYearID =  h.SeasonYearID
LEFT OUTER JOIN pStyleDevelopmentItem j ON j.StyleID = g.StyleID
WHERE e.StyleID IN ( SELECT DISTINCT StyleID FROM  pLineFolderItem WHERE LineFolderID  = @LineFolderID ) AND i.SeasonYearID = @SeasonYearID



DECLARE @SQL NVARCHAR(4000) 

DECLARE @flag INT  
SET @flag = 0



SET @SQL = 'INSERT INTO #tmpSample2 (SampleRequestTradeID, SampleWorkflow, StyleID, SampleRequestSubmitID,
TradePartnerID, TradePartnerName, AgentID, AgentName, VendorID, VendorName, FactoryID, FactoryName, 
Link, StyleNo, Description, SizeClass, Dim1Name,Dim2Name,Dim3Name, ItemDim1Id,ItemDim2Id,ItemDim3Id, TechPack, StyleSet , SetNo, Season, Year,WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID, Variation,
StyleCategoryID, StyleCategory, StyleTypeID, StyleType, AgentCode, VendorCode, FactoryCode)
SELECT a.SampleRequestTradeID, a.SampleWorkflow, a.StyleID, a.SampleRequestSubmitID, 
a.TradePartnerID, b.TradePartnerName, tpm.AgentID, tpm.AgentName, tpm.VendorID, tpm.VendorName, tpm.FactoryID, tpm.FactoryName, 
a.Link , d.StyleNo, d.Description, d.SizeClass ,g.ItemDim1Name,h.ItemDim2Name,j.ItemDim3Name, a.ItemDim1Id,a.ItemDim2Id,a.ItemDim3Id, a.TechPack, a.StyleSet, a.SetNo, a.Season, a.Year,a.WorkFlowItemID,a.StyleBOMDimensionID,a.StyleBOMDimensionItemID, Variation,
sc.StyleCategoryID, sc.StyleCategory, st.StyleTypeID, st.StyleTypeDescription, tpm.AgentCode, tpm.VendorCode, tpm.FactoryCode
FROM #tmpSample1 a
INNER JOIN uTradePartner b ON b.TradePartnerID = a.TradePartnerID
INNER JOIN pStyleHeader d ON d.StyleID = a.StyleID 
LEFT OUTER JOIN pStyleBOMDimensionItem g ON g.ItemDim1Id = a.ItemDim1Id 
LEFT OUTER JOIN pStyleBOMDimensionItem h ON h.ItemDim2Id = a.ItemDim2Id 
LEFT OUTER JOIN pStyleBOMDimensionItem j ON j.ItemDim3Id = a.ItemDim3Id 
LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationshipLevelID = a.TradePartnerRelationshipLevelID
INNER JOIN pStyleCategory sc ON sc.StyleCategoryID = d.StyleCategory
INNER JOIN pStyleType st ON st.StyleTypeID = d.StyleType
'

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
StyleNo, Description, SizeClass, Dim1Name,Dim2Name,Dim3Name, TechPack, StyleSet, SetNo, Season, Year,WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID,  
AgentID, AgentName, VendorID, VendorName, FactoryID, FactoryName, Variation, StyleType, StyleCategory
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
VALUES ('DB_Version', '0.5.0000', '06011', GetDate())
GO
