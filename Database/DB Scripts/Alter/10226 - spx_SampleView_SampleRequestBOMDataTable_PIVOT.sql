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
@AssignedTo NVARCHAR (MAX),
@StyleType NVARCHAR (MAX),
@StyleCategory NVARCHAR (MAX),
@SeasonYear NVARCHAR (MAX),
@Agent NVARCHAR (MAX),
@Vendor NVARCHAR (MAX),
@Factory NVARCHAR (MAX),
@PageNo INT = NULL,
@PageSize INT = NULL,
@SortOrder NVARCHAR(MAX) = NULL
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
	AND LOWER(pSampleWorkflow.Active)='yes'  
	ORDER BY SampleWorkflowSort   
	
--***  
--** PIVOT  
--***  	

CREATE TABLE #tmpSample (
SampleRequestTradeID UNIQUEIDENTIFIER,
SampleWorkflow NVARCHAR(200),
StyleID UNIQUEIDENTIFIER,
SampleRequestSubmitID UNIQUEIDENTIFIER, 
TradePartnerID UNIQUEIDENTIFIER,
TradePartnerName NVARCHAR(200),
Link  NVARCHAR(MAX),
TechPack NVARCHAR(4000),
StyleSet NVARCHAR(200),
SetNo INT,
WorkFlowItemID  NVARCHAR(200),
StyleBOMDimensionID  NVARCHAR(200),
StyleBOMDimensionItemID   NVARCHAR(200),
AssignedTo INT, 
StyleColorID UNIQUEIDENTIFIER, 
WorkFlowItemName NVARCHAR(100),
ItemDim1Id uniqueidentifier NULL,
ItemDim2Id uniqueidentifier NULL,
ItemDim3Id uniqueidentifier NULL,
ItemDim1Name NVARCHAR(200),
ItemDim2Name NVARCHAR(200),
ItemDim3Name NVARCHAR(200),
Variation NVARCHAR(200),
TradePartnerRelationshipLevelID UNIQUEIDENTIFIER,
SeasonYearID UNIQUEIDENTIFIER,
CDate DATETIME,
Submit INT,
SubmitStatus INT,
DivisionID UNIQUEIDENTIFIER,
StyleCategoryID UNIQUEIDENTIFIER,
StyleCategory NVARCHAR(200),
StyleTypeID INT,
StyleType NVARCHAR(200),
AgentID UNIQUEIDENTIFIER,
AgentName NVARCHAR(200),
AgentCode NVARCHAR(200),
VendorID UNIQUEIDENTIFIER,
VendorName NVARCHAR(200),
VendorCode NVARCHAR(200),
FactoryID UNIQUEIDENTIFIER,
FactoryName NVARCHAR(200),
FactoryCode NVARCHAR(200),
StyleNo NVARCHAR(50) , 
Description NVARCHAR(100),
SizeClass NVARCHAR(400),
SizeRange NVARCHAR(200),
DesignSketchID UNIQUEIDENTIFIER,
DesignSketchVersion INT,
CustomField3 NVARCHAR(200),
CustomField10 NVARCHAR(200),
Designer NVARCHAR(100),
TechnicalDesigner NVARCHAR(100),
ProductionManager NVARCHAR(100)
)

-- BOM sample requests
-- with statement fully dedicated to pretty formatting sample comments
;WITH CommentTypes AS (
	SELECT * FROM (VALUES ('S', N'Shared Comments', 1),
						  ('I', N'Internal Comments', 2)) 
						 V(CommentType, CommentTypeName, CommentSort)
), Comments AS (
	SELECT src1.SampleRequestWorkflowID, src1.SampleCommentType, CAST(STUFF((
		SELECT '\n' + MUser + ' - ' + dbo.fnx_DatetimeToString(MDate, @PrefLanguage) + ' ' 
			+ LTRIM(RIGHT(CONVERT(NVARCHAR(50), MDate, 100), 7)) + ' ' + SampleRequestComment 
		FROM pSampleRequestComment src2
		WHERE src1.SampleRequestWorkflowID = src2.SampleRequestWorkflowID 
			AND src1.SampleCommentType = src2.SampleCommentType
		ORDER BY src2.MDate DESC			
		FOR XML PATH('')
	), 1, 0, '') AS NVARCHAR(MAX)) AS Comment
	FROM pSampleRequestComment src1
	GROUP BY src1.SampleRequestWorkflowID, src1.SampleCommentType
), WorkflowComments AS (
	SELECT src.SampleRequestWorkflowID, c.Comment, ct.* FROM CommentTypes ct
	CROSS JOIN (SELECT DISTINCT SampleRequestWorkflowID FROM pSampleRequestWorkflowBOM) src
	LEFT JOIN Comments c ON src.SampleRequestWorkflowID = c.SampleRequestWorkflowID 
		AND ct.CommentType = c.SampleCommentType
), SampleComments AS (
	SELECT wc1.SampleRequestWorkflowID, REPLACE(STUFF((
		SELECT '\n' + CASE wc2.CommentType WHEN 'S' THEN 'Shared Comments: ' WHEN 'I' THEN 'Internal Comments: ' ELSE 'Fit Comments: ' END + ISNULL(wc2.Comment, ' * ')
		FROM WorkflowComments wc2
		WHERE wc1.SampleRequestWorkflowID = wc2.SampleRequestWorkflowID
		ORDER BY wc2.SampleRequestWorkflowID
		FOR XML PATH('')
	), 1, 0, ''), '\n', NCHAR(13)) AS Comments
	FROM WorkflowComments wc1
	GROUP BY wc1.SampleRequestWorkflowID
) INSERT INTO #tmpSample
(SampleRequestTradeID, SampleWorkflow, StyleID, SampleRequestSubmitID, TradePartnerID, TradePartnerName, Link, TechPack, StyleSet, SetNo,
WorkFlowItemID, StyleBOMDimensionID, StyleBOMDimensionItemID, AssignedTo, StyleColorID, WorkFlowItemName, ItemDim1Id, ItemDim2Id, ItemDim3Id, ItemDim1Name, ItemDim2Name, ItemDim3Name,
TradePartnerRelationshipLevelID, Variation, SeasonYearID, CDate, Submit, SubmitStatus, DivisionID, StyleCategoryID, StyleCategory, StyleTypeID, StyleType, 
AgentID, AgentName, AgentCode, VendorID, VendorName, VendorCode, FactoryID, FactoryName, FactoryCode,
StyleNo, Description, SizeClass, SizeRange, DesignSketchID, DesignSketchVersion, CustomField3, CustomField10, Designer, TechnicalDesigner, ProductionManager
)
SELECT 
	srs.SampleRequestTradeID
	, sw.SampleWorkflow
	, srs.StyleID
	, srs.SampleRequestSubmitID
	, srt.TradePartnerID
	, tp.TradePartnerName 
	, '<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
	<IMG src=''' + 
	CASE 
		WHEN srss.ApprovedType = 1  THEN '../System/Icons/icon_ball_green.gif'
		WHEN srs.Status = 4  THEN '../System/Icons/icon_ball_red.gif'
		WHEN srs.Submit = 1 THEN '../System/Icons/icon_ball_blue.gif'
		ELSE '../System/Icons/icon_ball_yellow.gif'
	END
	+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp; 
	<a href=''#'' onclick="javascript:window.open(''../Sample/SampleRequest_Workflow_Redirect.aspx?SRTID=' + 
	CAST ( srs.SampleRequestTradeID AS NVARCHAR(50)) + '&WFIID=' + CAST (isnull(srt.WorkFlowItemID,'00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&SBOMDID=' + CAST (isnull(srt.StyleBOMDimensionID,'00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&SBOMDIID=' + CAST (isnull(srt.StyleBOMDimensionItemID,'00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&FDIM=1' + '&SWID=' + srs.SampleWorkflowID + '&SN='+  CAST(srs.StyleSet  as nvarchar(5)) +
	''',''' +  
	Replace( CAST ( srs.SampleRequestTradeID AS NVARCHAR(50)) , '-', '') +
	''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');" ' 
	+ 'title="' + vsy.SeasonYear + ' '
		+ CASE WHEN gt.DimTypeName like '%color%' THEN g.ItemDim1Name
			WHEN ht.DimTypeName like '%color%' THEN h.ItemDim2Name
			WHEN jt.DimTypeName like '%color%' THEN j.ItemDim3Name ELSE '' END 
		+ CHAR(13) + 'Fit Comments: ' + ISNULL(CAST(srs.Comment AS NVARCHAR(MAX)), ' * ')
		+ ISNULL(scm.Comments, '') + '" >' 
	+
	CASE 
		WHEN srss.ApprovedType = 1 THEN dbo.fnx_DatetimeToString(srs.EndDate, @PrefLanguage)
		WHEN srs.Status = 4 THEN dbo.fnx_DatetimeToString(srs.MDate, @PrefLanguage)
		ELSE dbo.fnx_DatetimeToString(srs.DueDate, @PrefLanguage)
	END 
	+ '&nbsp;<b>(' 
	+  CAST(srs.Submit AS NVARCHAR(5)) + ')</b></a></TD></TR></TABLE>'
	AS Link
	, CASE	
		WHEN  sh.TechPackID IS NULL  THEN '<div align=center>-------</div>'	
		ELSE 
		'<TABLE>
				<TR>
				<TD width=''18''><IMG src=''../System/Icons/icon_packageok.gif'' border=''0''></TD>
				<TD class=''font'' align=''center'' valign=''center'' nowrap>&nbsp;
				<a href=''#'' onclick="javascript:window.open(''../Sample/SampleRequest_Workflow_Redirect.aspx?SRTID='
				+ CAST (srs.SampleRequestTradeID AS NVARCHAR(50))
				+ '&FDIM=1' 
				+ '&SID=' + CAST(srs.StyleID AS NVARCHAR(50)) 
				+ '&SN=' + CAST(srs.StyleSet AS NVARCHAR(10)) 
				+ '&SYID=' + CAST(ssy.SeasonYearID AS NVARCHAR(50)) 
				+ '&TP=1'' , ''' 
				+ REPLACE ( CAST ( srs.SampleRequestTradeID  AS NVARCHAR(50) ), '-', '' ) 

				+ ''',  ''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'' ' 
				+ ' );" >  ' 			
				+ dbo.fnx_DatetimeToString(sh.DueDate, @PrefLanguage)
				+ '</a></TD></TR></TABLE>'			
		END AS TechPack
	, CASE 
		WHEN srs.StyleSet = 1 THEN 
			CASE WHEN sh.PC1 Is Not Null THEN sh.PC1 ELSE '1st Set' END
		WHEN srs.StyleSet = 2 THEN 
			CASE WHEN sh.PC2 Is Not Null THEN sh.PC2 ELSE '2nd Set' END
		WHEN srs.StyleSet = 3 THEN 
			CASE WHEN sh.PC3 Is Not Null THEN sh.PC3 ELSE '3rd Set' END
		WHEN srs.StyleSet = 4 THEN 
			CASE WHEN sh.PC4 Is Not Null THEN sh.PC4 ELSE '4th Set' END 
	END AS StyleSet
	, srs.StyleSet as SetNo
	, srt.WorkFlowItemID
	, srt.StyleBOMDimensionID
	, srt.StyleBOMDimensionItemID
	, srw.AssignedTo
	, NULL as StyleColorID
	, wi.WorkFlowItemName
	, srt.ItemDim1Id
	, srt.ItemDim2Id
	, srt.ItemDim3Id
	, g.ItemDim1Name
	, h.ItemDim2Name
	, j.ItemDim3Name
	, srt.TradePartnerRelationshipLevelID
	, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS nVarchar(2))) AS Variation
	, ssy.SeasonYearID
	, srt.CDate
	, srs.Submit
	, srs.Status AS SubmitStatus
	, sh.DivisionID
	, sc.StyleCategoryID
	, sc.StyleCategory
	, st.StyleTypeID
	, st.StyleTypeDescription
	, tprl.AgentID
	, tprl.AgentName	
	, tprl.AgentCode
	, tprl.VendorID
	, tprl.VendorName
	, tprl.VendorCode
	, tprl.FactoryID
	, tprl.FactoryName
	, tprl.FactoryCode
	, sh.StyleNo
	, sh.Description
	, COALESCE(scc.Custom, sh.SizeClass)
	, COALESCE(sr.SizeRangeCode, sh.SizeRange)	
	, sh.DesignSketchID
	, sh.DesignSketchVersion	
	, sh.CustomField3
	, sh.CustomField10
	, sh.Designer
	, sh.TechnicalDesigner
	, sh.ProductionManager
FROM dbo.pSampleRequestSubmitBOM srs
	INNER JOIN pSampleRequestBOMTrade srt ON srs.SampleRequestTradeID  = srt.SampleRequestTradeID
	INNER JOIN pWorkFlowItem wi ON wi.WorkFlowItemID = srt.WorkFlowItemID
	INNER JOIN pSampleWorkflow sw ON srs.SampleWorkflowId = sw.SampleWorkflowID 
	INNER JOIN pSampleRequestSubmitStatus srss ON srs.Status = srss.StatusID	
	INNER JOIN pSampleRequestWorkflowBOM srw ON srw.SampleRequestWorkflowID = srs.SampleRequestWorkflowID AND srw.Submit = srs.Submit
	LEFt JOIN SampleComments scm ON srw.SampleRequestWorkflowID = scm.SampleRequestWorkflowID
	INNER JOIN pStyleHeader sh ON sh.StyleID = srt.StyleID
	INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	LEFT OUTER JOIN pStyleSeasonYear ssy ON srt.StyleSeasonyearID = ssy.StyleSeasonYearID
	INNER JOIN vwx_SeasonYear_SEL vsy ON ssy.SeasonYearID = vsy.SeasonYearID
	LEFT OUTER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
	LEFT OUTER JOIN uTradePartner tp ON srt.TradePartnerID = tp.TradePartnerID
	LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	LEFT OUTER JOIN pStyleBOMDimensionItem g ON g.ItemDim1Id = srt.ItemDim1Id AND g.StyleBOMDimensionID = srt.StyleBOMDimensionID
	LEFT OUTER JOIN pStyleBOMDimensionItem h ON h.ItemDim2Id = srt.ItemDim2Id AND h.StyleBOMDimensionID = srt.StyleBOMDimensionID
	LEFT OUTER JOIN pStyleBOMDimensionItem j ON j.ItemDim3Id = srt.ItemDim3Id AND j.StyleBOMDimensionID = srt.StyleBOMDimensionID
	LEFT JOIN pStyleBOMDimType gt ON g.ItemDim1TypeId = gt.DimTypeID
	LEFT JOIN pStyleBOMDimType ht ON h.ItemDim2TypeId = ht.DimTypeID
	LEFT JOIN pStyleBOMDimType jt ON j.ItemDim3TypeId = jt.DimTypeID
	INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON st.StyleTypeID = access.ProductTypeId
	LEFT JOIN pSizeClass scc ON scc.CustomId = sh.SizeClassId
	LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
WHERE (@TradePartnerId IS NULL OR @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID, srt.TradePartnerID))
AND (srs.Submit >= @NoOfSubmits OR @NoOfSubmits IS NULL OR @NoOfSubmits = '')
AND (srw.AssignedTo = @UserID OR @UserID IS NULL)
AND (srw.AssignedTo IN (SELECT value FROM dbo.fnx_Split(@AssignedTo, ',')) OR @AssignedTo IS NULL)
AND (sh.StyleType IN (SELECT value FROM dbo.fnx_Split(@StyleType, ',')) OR @StyleType IS NULL)
AND (sh.StyleCategory IN (SELECT value FROM dbo.fnx_Split(@StyleCategory, ',')) OR @StyleCategory IS NULL)
AND (ssy.SeasonYearID IN (SELECT value FROM dbo.fnx_Split(@SeasonYear, ',')) OR @SeasonYear IS NULL)
AND (tprl.AgentID IN (SELECT value FROM dbo.fnx_Split(@Agent, ',')) OR @Agent IS NULL)
AND (tprl.VendorID IN (SELECT value FROM dbo.fnx_Split(@Vendor, ',')) OR @Vendor IS NULL)
AND (tprl.FactoryID IN (SELECT value FROM dbo.fnx_Split(@Factory, ',')) OR @Factory IS NULL)
AND (access.PermissionRoleId = 3 OR access.PermissionCreate = 1)

DECLARE @SQL NVARCHAR(4000) 

SET @SQL = 'SELECT replace(SampleWorkflow,'' '',''_'') as SampleWorkflow, Link , SampleRequestTradeID, StyleID, DesignSketchID, DesignSketchVersion, TradePartnerID , TradePartnerName, 
StyleNo, Description, SizeClass, WorkFlowItemName, ItemDim1Name, ItemDim2Name, ItemDim3Name, TechPack, StyleSet, SetNo, StyleColorID, WorkFlowItemID, StyleBOMDimensionID, StyleBOMDimensionItemID,  
AgentID, AgentName, VendorID, VendorName, FactoryID, FactoryName, Variation, StyleTypeID, StyleCategoryID, SeasonYearID, CDate
FROM #tmpSample'


IF @Filter IS NOT NULL AND LEN(@Filter) > 0 
BEGIN
	SET @SQL = @SQL + ' WHERE ' + @Filter 
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
				
/*
PRINT (@SQL)
select * from #tmpSample
*/

DECLARE @PlanningFinancialIDList NVARCHAR(MAX)	
SELECT @PlanningFinancialIDList = COALESCE(@PlanningFinancialIDList + ',', '') + 
QUOTENAME(REPLACE(SampleWorkflow, ' ', '_'))
FROM pSampleWorkflow

--select @PlanningFinancialIDList


DECLARE @str NVARCHAR(MAX) = 'SELECT * INTO #tmp0 FROM
(' + @SQL +  ') AS SourceTable
PIVOT
(
MAX(Link)
FOR SampleWorkflow IN (' + @PlanningFinancialIDList + ')
) AS PivotTable;'

DECLARE @sqlString  NVARCHAR(MAX) = @str + dbo.fnx_CreatePagingString('#tmp0',@PageNo,@PageSize,'StyleNo', NULL)
exec sp_executesql @sqlString


DROP TABLE #tmpSample


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10226', GetUTCDate())
GO
