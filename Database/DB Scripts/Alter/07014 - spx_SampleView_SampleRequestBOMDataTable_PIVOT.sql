IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleView_SampleRequestBOMDataTable_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleView_SampleRequestBOMDataTable_PIVOT]
GO


CREATE PROCEDURE [dbo].[spx_SampleView_SampleRequestBOMDataTable_PIVOT] (
@TradepartnerID UNIQUEIDENTIFIER = NULL,   
@TeamID UNIQUEIDENTIFIER,   
@Filter NVARCHAR (4000),
@SampleStatus NVARCHAR (50),
@NoOfSubmits NVARCHAR (10),
@PrefLanguage NVARCHAR (50),
@UserID INT,
@AssignedTo NVARCHAR (200)
)
AS 

	SELECT SampleWorkflow,
		REPLACE(SampleWorkflow, ' ', '_') AS SampleWorkflowField, 
		SampleWorkflowSort
	FROM pSampleWorkflow WITH (NOLOCK)
	WHERE
	(
		SampleWorkflowID IN
		(
			SELECT SampleWorkflowId
			FROM pSampleWorkflowViewSubmit WITH (NOLOCK)
			WHERE TeamId = @TeamId
		)
	)
	AND pSampleWorkflow.Active='Yes'  
	ORDER BY SampleWorkflowSort   
	
--***  
--** PIVOT  
--***  	

CREATE TABLE #tmpSample1 (
SampleRequestTradeID UNIQUEIDENTIFIER,
SampleWorkflow NVARCHAR(200),
StyleID UNIQUEIDENTIFIER,
SampleRequestSubmitID UNIQUEIDENTIFIER, 
TradePartnerID UNIQUEIDENTIFIER, 
Link  NVARCHAR(4000), 
AssignedTo INT, 
StyleColorID UNIQUEIDENTIFIER, 
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
Variation NVARCHAR(200),
SeasonYearID UNIQUEIDENTIFIER,
CDate DATETIME,
Submit INT,
SubmitStatus INT
)


CREATE TABLE #tmpSample2 (
SampleRequestTradeID UNIQUEIDENTIFIER,
SampleWorkflow NVARCHAR(200),
StyleID UNIQUEIDENTIFIER,
DesignSketchID UNIQUEIDENTIFIER,
DesignSketchVersion INT,
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
AssignedTo INT, 
StyleNo NVARCHAR(50) , 
Description NVARCHAR(100),
SizeClass NVARCHAR(50),
SizeRange NVARCHAR(50),
DivisionID UNIQUEIDENTIFIER,
StyleCategoryID UNIQUEIDENTIFIER,
StyleCategory NVARCHAR(200),
StyleTypeID INT,
StyleType NVARCHAR(200),
Dim1Name NVARCHAR(100),
Dim2Name NVARCHAR(100),
Dim3Name NVARCHAR(100),
StyleColorID UNIQUEIDENTIFIER, 
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
Variation NVARCHAR(200),
CustomField3 NVARCHAR(200),
CustomField10 NVARCHAR(200),
SeasonYearID UNIQUEIDENTIFIER,
CDate DATETIME,
Submit INT,
SubmitStatus INT,
Designer NVARCHAR(100),
TechnicalDesigner NVARCHAR(100),
ProductionManager NVARCHAR(100)
)


CREATE TABLE #tmpSample3 (
SampleRequestTradeID UNIQUEIDENTIFIER,
SampleWorkflow NVARCHAR(200),
StyleID UNIQUEIDENTIFIER,
DesignSketchID UNIQUEIDENTIFIER,
DesignSketchVersion INT,
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
AssignedTo INT, 
StyleNo NVARCHAR(50) , 
Description NVARCHAR(100),
SizeClass NVARCHAR(50),
SizeRange NVARCHAR(50),
DivisionID UNIQUEIDENTIFIER,
StyleCategoryID UNIQUEIDENTIFIER,
StyleCategory NVARCHAR(200),
StyleTypeID INT,
StyleType NVARCHAR(200),
Dim1Name NVARCHAR(100),
Dim2Name NVARCHAR(100),
Dim3Name NVARCHAR(100),
StyleColorID UNIQUEIDENTIFIER, 
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
Variation NVARCHAR(200),
CustomField3 NVARCHAR(200),
CustomField10 NVARCHAR(200),
SeasonYearID UNIQUEIDENTIFIER,
CDate DATETIME,
Submit INT,
SubmitStatus INT,
Designer NVARCHAR(100),
TechnicalDesigner NVARCHAR(100),
ProductionManager NVARCHAR(100)
)

-- BOM sample requests
INSERT INTO #tmpSample1 ( 
SampleRequestTradeID, SampleWorkflow, StyleID, SampleRequestSubmitID,
TradePartnerID , Link, 
AssignedTo, StyleColorID, ItemDim1Id,ItemDim2Id,ItemDim3Id, TechPack, StyleSet, SetNo, Season, Year,
WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID, TradePartnerRelationshipLevelID, Variation, 
SeasonYearID, CDate, Submit, SubmitStatus)
SELECT 
a.SampleRequestTradeID, f.SampleWorkflow, a.StyleID, a.SampleRequestSubmitID, 
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
	WHEN d.ApprovedType = 1 THEN dbo.fnx_DatetimeToString(a.EndDate, @PrefLanguage)
	WHEN a.Status = 4 THEN dbo.fnx_DatetimeToString(a.MDate, @PrefLanguage)
	ELSE dbo.fnx_DatetimeToString(a.DueDate, @PrefLanguage)
END 
+ '&nbsp;<b>(' 
+  CAST(a.Submit AS NVARCHAR(5)) + ')</b></a></TD></TR></TABLE>'
AS Link, 
a.AssignedTo, NULL as StyleColorID, b.ItemDim1Id, b.ItemDim2Id,  b.ItemDim3Id,  

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
			+ '&SYID=' + CAST(h.SeasonYearID AS NVARCHAR(50)) 
			+ '&TP=1'' , ''' 
			+ REPLACE ( CAST ( a.SampleRequestTradeID  AS NVARCHAR(50) ), '-', '' ) 

			+ ''',  ''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'' ' 
			+ ' );" >  ' 			
			+ dbo.fnx_DatetimeToString(g.DueDate, @PrefLanguage)
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
ISNULL(j.StyleDevelopmentName, 'Variation ' + CAST(j.Variation AS nVarchar(2))) AS Variation, 
i.SeasonYearID, b.CDate, a.Submit, a.Status
FROM dbo.pSampleRequestSubmitBOM a
INNER JOIN pSampleRequestBOMTrade b ON a.SampleRequestTradeID  = b.SampleRequestTradeID  
INNER JOIN pSampleWorkflow c ON a.SampleWorkflowId = c.SampleWorkflowID 
INNER JOIN pSampleRequestSubmitStatus d ON a.Status   = d.StatusID	
INNER JOIN pSampleRequestWorkflowBOM e ON e.SampleRequestWorkflowID = a.SampleRequestWorkflowID
										AND e.Submit = a.Submit
INNER JOIN pSampleWorkflow f ON f.SampleWorkflowID  =  e.SampleWorkflowID 
INNER JOIN pStyleHeader g ON g.StyleID = b.StyleID
LEFT OUTER JOIN pStyleSeasonYear h ON h.StyleSeasonYearID =  b.StyleSeasonyearID 
LEFT OUTER JOIN pSeasonYear i ON i.SeasonYearID =  h.SeasonYearID
LEFT OUTER JOIN pStyleDevelopmentItem j ON j.StyleID = g.StyleID
LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON b.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
WHERE (@TradePartnerId IS NULL OR @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID, b.TradePartnerID))

-- not BOM sample requests
INSERT INTO #tmpSample1 ( 
SampleRequestTradeID, SampleWorkflow, StyleID, SampleRequestSubmitID,
TradePartnerID , Link, 
AssignedTo, StyleColorID, ItemDim1Id,ItemDim2Id,ItemDim3Id, TechPack, StyleSet, SetNo, Season, Year,
WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID, TradePartnerRelationshipLevelID, Variation, 
SeasonYearID, CDate, Submit, SubmitStatus)
SELECT 
a.SampleRequestTradeID, f.SampleWorkflow, a.StyleID, a.SampleRequestSubmitID, 
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
CAST ( a.SampleRequestTradeID AS NVARCHAR(50)) + '&SWID=' + a.SampleWorkflowID + '&SN='+  CAST(a.StyleSet  as nvarchar(5)) +
''',''' +  
Replace( CAST ( a.SampleRequestTradeID AS NVARCHAR(50)) , '-', '') +
''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">' 
+
CASE 
	WHEN d.ApprovedType = 1 THEN dbo.fnx_DatetimeToString(a.EndDate, @PrefLanguage)
	WHEN a.Status = 4 THEN dbo.fnx_DatetimeToString(a.MDate, @PrefLanguage)
	ELSE dbo.fnx_DatetimeToString(a.DueDate, @PrefLanguage)
END 
+ '&nbsp;<b>(' 
+  CAST(a.Submit AS NVARCHAR(5)) + ')</b></a></TD></TR></TABLE>'
AS Link, 
a.AssignedTo, b.StyleColorID, NULL as ItemDim1Id, NULL as ItemDim2Id, NULL as ItemDim3Id,  

CASE	
	WHEN  g.TechPackID IS NULL  THEN '<div align=center>-------</div>'	
	ELSE 
	'<TABLE>
			<TR>
			<TD width=''18''><IMG src=''../System/Icons/icon_packageok.gif'' border=''0''></TD>
			<TD class=''font'' align=''center'' valign=''center'' nowrap>&nbsp;
			<a href=''#'' onclick="javascript:window.open(''../Sample/SampleRequest_Workflow_Redirect.aspx?SRTID='
			+ CAST (a.SampleRequestTradeID AS NVARCHAR(50))
			+ '&FDIM=0' 
			+ '&SID=' + CAST(a.StyleID AS NVARCHAR(50)) 
			+ '&SN=' + CAST(a.StyleSet AS NVARCHAR(10)) 
			+ '&SYID=' + CAST(h.SeasonYearID AS NVARCHAR(50)) 
			+ '&TP=1'' , ''' 
			+ REPLACE ( CAST ( a.SampleRequestTradeID  AS NVARCHAR(50) ), '-', '' ) 

			+ ''',  ''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'' ' 
			+ ' );" >  ' 			
			+ dbo.fnx_DatetimeToString(g.DueDate, @PrefLanguage)
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
END AS StyleSet, a.StyleSet as SetNo, i.Season, i.Year, NULL as WorkFlowItemID, NULL as StyleBOMDimensionID, NULL as StyleBOMDimensionItemID, b.TradePartnerRelationshipLevelID,
ISNULL(j.StyleDevelopmentName, 'Variation ' + CAST(j.Variation AS nVarchar(2))) AS Variation, 
i.SeasonYearID, b.CDate, a.Submit, a.Status
FROM dbo.pSampleRequestSubmit a
INNER JOIN pSampleRequestTrade b ON a.SampleRequestTradeID  = b.SampleRequestTradeID  
INNER JOIN pSampleWorkflow c ON a.SampleWorkflowId = c.SampleWorkflowID 
INNER JOIN pSampleRequestSubmitStatus d ON a.Status   = d.StatusID	
INNER JOIN pSampleRequestWorkflow e ON e.SampleRequestWorkflowID = a.SampleRequestWorkflowID
										AND e.Submit = a.Submit
INNER JOIN pSampleWorkflow f ON f.SampleWorkflowID  =  e.SampleWorkflowID 
INNER JOIN pStyleHeader g ON g.StyleID = b.StyleID
LEFT OUTER JOIN pStyleSeasonYear h ON h.StyleSeasonYearID =  b.StyleSeasonyearID 
LEFT OUTER JOIN pSeasonYear i ON i.SeasonYearID =  h.SeasonYearID
LEFT OUTER JOIN pStyleDevelopmentItem j ON j.StyleID = g.StyleID
LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON b.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
WHERE (@TradePartnerId IS NULL OR @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID, b.TradePartnerID))


DECLARE @SQL NVARCHAR(4000) 

DECLARE @flag INT  
SET @flag = 0



SET @SQL = 'INSERT INTO #tmpSample2 (SampleRequestTradeID, SampleWorkflow, StyleID, DesignSketchID, DesignSketchVersion, SampleRequestSubmitID,
TradePartnerID, TradePartnerName, AgentID, AgentName, VendorID, VendorName, FactoryID, FactoryName, 
Link, AssignedTo, StyleNo, Description, SizeClass, SizeRange, Dim1Name,Dim2Name,Dim3Name, StyleColorID, ItemDim1Id,ItemDim2Id,ItemDim3Id, TechPack, StyleSet , SetNo, Season, Year,WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID, Variation, CDate,
DivisionID, StyleCategoryID, StyleCategory, StyleTypeID, StyleType, AgentCode, VendorCode, FactoryCode,
CustomField3, CustomField10, SeasonYearID, Submit, SubmitStatus, Designer, TechnicalDesigner, ProductionManager)
SELECT a.SampleRequestTradeID, replace(a.SampleWorkflow,'' '',''_''), a.StyleID, d.DesignSketchID, d.DesignSketchVersion, a.SampleRequestSubmitID, 
a.TradePartnerID, b.TradePartnerName, tpm.AgentID, tpm.AgentName, tpm.VendorID, tpm.VendorName, tpm.FactoryID, tpm.FactoryName, 
a.Link, a.AssignedTo, d.StyleNo, d.Description, d.SizeClass, d.SizeRange, g.ItemDim1Name,h.ItemDim2Name,j.ItemDim3Name, a.StyleColorID, a.ItemDim1Id,a.ItemDim2Id,a.ItemDim3Id, a.TechPack, a.StyleSet, a.SetNo, a.Season, a.Year,a.WorkFlowItemID,a.StyleBOMDimensionID,a.StyleBOMDimensionItemID, Variation, a.CDate, 
d.DivisionID, sc.StyleCategoryID, sc.StyleCategory, st.StyleTypeID, st.StyleTypeDescription, tpm.AgentCode, tpm.VendorCode, tpm.FactoryCode,
d.CustomField3, d.CustomField10, a.SeasonYearID, a.Submit, a.SubmitStatus, d.Designer, d.TechnicalDesigner, d.ProductionManager
FROM #tmpSample1 a
INNER JOIN uTradePartner b ON b.TradePartnerID = a.TradePartnerID
INNER JOIN pStyleHeader d ON d.StyleID = a.StyleID 
LEFT OUTER JOIN pStyleBOMDimensionItem g ON g.ItemDim1Id = a.ItemDim1Id AND g.StyleBOMDimensionID = a.StyleBOMDimensionID
LEFT OUTER JOIN pStyleBOMDimensionItem h ON h.ItemDim2Id = a.ItemDim2Id AND h.StyleBOMDimensionID = a.StyleBOMDimensionID
LEFT OUTER JOIN pStyleBOMDimensionItem j ON j.ItemDim3Id = a.ItemDim3Id AND j.StyleBOMDimensionID = a.StyleBOMDimensionID
LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationshipLevelID = a.TradePartnerRelationshipLevelID
INNER JOIN pStyleCategory sc ON sc.StyleCategoryID = d.StyleCategory
INNER JOIN pStyleType st ON st.StyleTypeID = d.StyleType
'

EXEC (@SQL)


IF @Filter IS NOT NULL AND LEN(@Filter) > 0 
BEGIN
	SET @SQL = 'INSERT INTO #tmpSample3  SELECT * FROM #tmpSample2 WHERE ' + @Filter 
END
ELSE 
BEGIN
	SET @SQL = 'INSERT INTO #tmpSample3  
				SELECT * FROM #tmpSample2 '
END

IF @NoOfSubmits IS NOT NULL AND LEN(@NoOfSubmits) > 0 
BEGIN
	IF CHARINDEX('WHERE',@SQL) = 0
		SET @SQL = @SQL + ' WHERE Submit >= ' + @NoOfSubmits
	ELSE
		SET @SQL = @SQL + ' AND Submit >= ' + @NoOfSubmits
END

IF @SampleStatus IS NOT NULL
BEGIN
	IF CHARINDEX('WHERE',@SQL) = 0
		SET @SQL = @SQL + ' WHERE (SubmitStatus IN (' + @SampleStatus + ')'
	ELSE
		SET @SQL = @SQL + ' AND (SubmitStatus IN (' + @SampleStatus + ')'
	
	-- check for Resibmit status		
	IF CHARINDEX('1',@SampleStatus) > 0
		SET @SQL = @SQL + ' OR (Submit > 1 AND SubmitStatus NOT IN (2,3,4))'

	SET @SQL = @SQL + ')'
END

IF @UserID IS NOT NULL
BEGIN
	IF CHARINDEX('WHERE',@SQL) = 0
		SET @SQL = @SQL + ' WHERE AssignedTo = ' + CAST(@UserID AS NVARCHAR(10))
	ELSE
		SET @SQL = @SQL + ' AND AssignedTo = ' + CAST(@UserID AS NVARCHAR(10))
END

IF @AssignedTo IS NOT NULL
BEGIN
	IF CHARINDEX('WHERE',@SQL) = 0
		SET @SQL = @SQL + ' WHERE AssignedTo IN (' + @AssignedTo + ')'
	ELSE
		SET @SQL = @SQL + ' AND AssignedTo IN (' + @AssignedTo + ')'
END
				
EXEC (@SQL) 

/*
PRINT (@SQL)
select * from #tmpSample2
select * from #tmpSample3
*/




EXECUTE spx_Crosstab 
'SELECT SampleWorkflow, Link , SampleRequestTradeID, StyleID, DesignSketchID, DesignSketchVersion, TradePartnerID , TradePartnerName, 
StyleNo, Description, SizeClass, Dim1Name, Dim2Name, Dim3Name, TechPack, StyleSet, SetNo, Season, Year, StyleColorID, WorkFlowItemID, StyleBOMDimensionID, StyleBOMDimensionItemID,  
AgentID, AgentName, VendorID, VendorName, FactoryID, FactoryName, Variation, StyleType, StyleCategory, CDate
FROM #tmpSample3',
NULL,
NULL,
'SampleWorkflow',
'Link',
'MAX',
NULL,
0,
NULL,
NULL,
0,
'CDate DESC'

DROP TABLE #tmpSample1
DROP TABLE #tmpSample2
DROP TABLE #tmpSample3

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07014', GetDate())
GO
