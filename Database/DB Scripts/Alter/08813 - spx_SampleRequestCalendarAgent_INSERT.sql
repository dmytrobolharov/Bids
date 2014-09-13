IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestCalendarAgent_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestCalendarAgent_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestCalendarAgent_INSERT]
	@TeamId [nvarchar](50),
	@TradePartnerId [nvarchar](50) = null,
	@CalendarId [nvarchar](50),
	@StartDate [datetime],
	@EndDate [datetime],
	@SearchCond NVARCHAR(MAX) = N'',
	@SampleStatus NVARCHAR (50) = NULL,
	@NoOfSubmits NVARCHAR (10) = NULL,
	@UserID INT = NULL,
	@AssignedTo NVARCHAR (MAX) = NULL,
	@StyleType NVARCHAR (MAX) = NULL,
	@StyleCategory NVARCHAR (MAX) = NULL,
	@SeasonYear NVARCHAR (MAX) = NULL,
	@Agent NVARCHAR (MAX) = NULL,
	@Vendor NVARCHAR (MAX) = NULL,
	@Factory NVARCHAR (MAX)	= NULL
WITH EXECUTE AS CALLER
AS

DECLARE @PrefLanguage NVARCHAR(10) = (SELECT PreferredLang FROM Users WHERE TeamID = @TeamId)

/*Holiday's INSERT SELECT Statement.*/
INSERT INTO pStyleCalendarTemp
		(CalendarID, PKeyID, CalendarLinkID, CalendarLinkSubID, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT	@CalendarID AS CalendarID, '00000000-0000-0000-0000-000000000000' AS PKeyID, '00000000-0000-0000-0000-000000000000' AS CalendarLinkID, 
	'00000000-0000-0000-0000-000000000000' AS CalendarLinkSubID, CalendarEventDate AS CalendarDate, 'Holiday' AS CalendarType, 0 AS CalendarStatus,
	CalendarEventCountry +  ' - ' + CalendarEventName as CalendarDescription
FROM	cCalendarEvent WITH (NOLOCK)

;WITH srt as (
	SELECT isrt.SampleRequestTradeID, isrt.StyleID, isrt.StyleSeasonYearID, 
		isrt.TradePartnerRelationshipLevelID, isrt.TradePartnerID, isrt.TradePartnerVendorID, 0 AS IsBOM, 
		ISNULL(sc.StyleColorName, '') AS Color,
		NULL as ItemDim1Name, NULL as ItemDim2Name, NULL as ItemDim3Name
	FROM pSampleRequestTrade isrt
	LEFT JOIN pStyleColorway sc ON isrt.StyleColorID = sc.StyleColorID
	UNION
	SELECT isrt.SampleRequestTradeID, isrt.StyleID, isrt.StyleSeasonYearID, 
		isrt.TradePartnerRelationshipLevelID, isrt.TradePartnerID, isrt.TradePartnerVendorID, 1 AS IsBOM,
		COALESCE(sbdi1.ItemDim1Name, sbdi2.ItemDim2Name, sbdi3.ItemDim3Name, '') AS Color,
		sbdi1.ItemDim1Name, sbdi2.ItemDim2Name, sbdi3.ItemDim3Name
	FROM pSampleRequestBOMTrade isrt
	LEFT JOIN pStyleBOMDimType sbdt ON LOWER(sbdt.DimTypeName) = 'color'
	LEFT JOIN pStyleBOMDimensionItem sbdi1 ON isrt.StyleBOMDimensionID = sbdi1.StyleBOMDimensionID 
		AND isrt.ItemDim1Id = sbdi1.ItemDim1Id AND sbdi1.ItemDim1TypeId = sbdt.DimTypeID
	LEFT JOIN pStyleBOMDimensionItem sbdi2 ON isrt.StyleBOMDimensionID = sbdi2.StyleBOMDimensionID 
		AND isrt.ItemDim2Id = sbdi2.ItemDim2Id AND sbdi1.ItemDim1TypeId = sbdt.DimTypeID
	LEFT JOIN pStyleBOMDimensionItem sbdi3 ON isrt.StyleBOMDimensionID = sbdi3.StyleBOMDimensionID 
		AND isrt.ItemDim3Id = sbdi3.ItemDim3Id AND sbdi1.ItemDim1TypeId = sbdt.DimTypeID
), srw as (
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, Submit, DueDate, EndDate, Status, AssignedTo FROM pSampleRequestWorkflow
	UNION
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, Submit, DueDate, EndDate, Status, AssignedTo FROM pSampleRequestWorkflowBOM
), srs as (
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, SampleRequestSubmitID, 
		Submit, AgentView, CAST(Comment AS NVARCHAR(MAX)) AS Comment 
	FROM pSampleRequestSubmit
	UNION
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, SampleRequestSubmitID, 
		Submit, AgentView, CAST(Comment AS NVARCHAR(MAX)) AS Comment 
	FROM pSampleRequestSubmitBOM
), CommentTypes AS (
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
	CROSS JOIN (SELECT DISTINCT SampleRequestWorkflowID FROM srw) src
	LEFT JOIN Comments c ON src.SampleRequestWorkflowID = c.SampleRequestWorkflowID 
		AND ct.CommentType = c.SampleCommentType
), SampleComments AS (
	SELECT wc1.SampleRequestWorkflowID, REPLACE(STUFF((
		SELECT '\n' + CASE wc2.CommentType WHEN 'S' THEN 'Shared Comments: ' WHEN 'I' THEN 'Internal Comments: ' ELSE 'Comments: ' END + ISNULL(wc2.Comment, ' * ')
		FROM WorkflowComments wc2
		WHERE wc1.SampleRequestWorkflowID = wc2.SampleRequestWorkflowID
		ORDER BY wc2.SampleRequestWorkflowID
		FOR XML PATH('')
	), 1, 0, ''), '\n', NCHAR(13)) AS Comments
	FROM WorkflowComments wc1
	GROUP BY wc1.SampleRequestWorkflowID
)
SELECT @CalendarId AS CalendarId,
	srs.SampleRequestSubmitID AS PKeyId,
	srw.SampleRequestTradeID AS CalendarLinkId,
	sw.SampleWorkflow + N' (' + CAST(srw.Submit AS nVARCHAR(4)) + ') ' AS CalendarLinkSubId,
	srw.DueDate AS CalendarDate,
	'SampleRequestSubmit' AS CalendarType,
	srw.Status AS CalendarStatus,
	'<span class="with-sample-tooltip" title="' + vsy.SeasonYear + ' ' + srt.Color + NCHAR(13) + 'Fit Comments: ' + ISNULL(srs.Comment, ' * ') + sc.Comments + '">' + 
	CASE WHEN srt.TradePartnerRelationshipLevelID IS NOT NULL
		THEN SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName, '') + ISNULL('/' + tprl.FactoryName, ''), 2, 2000)
		ELSE '<b>A: </b>' + tp.TradePartnerCode + ' / <b>V: </b>' + tpv.VendorCode
	END + '<BR>' + sh.StyleNo + ' (' + sh.SizeClass + ') ' + sh.Description + '</span>' AS CalendarDescription,
	0 AS CalendarView,
	srt.IsBOM as CalendarSN,
	-- columns for search purposes
	tp.TradePartnerID, tpv.TradePartnerVendorID,
	tprl.AgentID, tprl.VendorID, tprl.FactoryID,
	srt.ItemDim1Name, srt.ItemDim2Name, srt.ItemDim3Name,
    sh.DivisionID, sh.StyleType AS StyleTypeID, sh.StyleCategory AS StyleCategoryID,
    sh.StyleNo, sh.Description, sh.Designer, sh.TechnicalDesigner, sh.ProductionManager,
    ssy.SeasonYearID, sh.CustomField3, sh.CustomField10, sh.SizeClass, sh.SizeRange,
	srw.Submit, srw.Status, srw.AssignedTo
INTO #tmpCal
FROM srt
INNER JOIN srw ON srt.SampleRequestTradeID = srw.SampleRequestTradeID
INNER JOIN srs ON srw.SampleRequestWorkflowID = srs.SampleRequestWorkflowID AND srw.Submit = srs.Submit
INNER JOIN pSampleWorkflow sw ON srw.SampleWorkflowID = sw.SampleWorkflowID
LEFT JOIN SampleComments sc ON srw.SampleRequestWorkflowID = sc.SampleRequestWorkflowID
INNER JOIN pStyleHeader sh ON srt.StyleID = sh.StyleID
LEFT JOIN pStyleSeasonYear ssy ON srt.StyleSeasonYearID = ssy.StyleSeasonYearID
INNER JOIN vwx_SeasonYear_SEL vsy ON ssy.SeasonYearID = vsy.SeasonYearID
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
LEFT JOIN uTradePartner tp ON srt.TradePartnerID = tp.TradePartnerID AND srt.TradePartnerRelationshipLevelID IS NULL
LEFT JOIN uTradePartnerVendor tpv ON srt.TradePartnerVendorID = tpv.TradePartnerVendorID AND srt.TradePartnerRelationshipLevelID IS NULL
INNER JOIN fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamId, 5, NULL) access ON access.WorkflowId = sw.SampleWorkflowGUID AND access.ProductTypeID = sh.StyleType
WHERE 
	((srw.DueDate BETWEEN @StartDate AND @EndDate AND srw.Status NOT IN (
			SELECT StatusID FROM pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4))
	OR (srw.Status = 1 AND srw.EndDate BETWEEN @StartDate AND @EndDate))
	AND srw.SampleWorkflowID IN (
		SELECT SampleWorkflowId FROM pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)
	AND (access.PermissionView = 1 OR access.PermissionRoleId = 3)	
	AND (@TradePartnerId IS NULL OR @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID, tp.TradePartnerID))
	AND (srs.Submit >= @NoOfSubmits OR @NoOfSubmits IS NULL OR @NoOfSubmits = '')
	AND (srw.AssignedTo = @UserID OR @UserID IS NULL)
	AND (srw.AssignedTo IN (SELECT value FROM dbo.fnx_Split(@AssignedTo, ',')) OR @AssignedTo IS NULL)
	AND (sh.StyleType IN (SELECT value FROM dbo.fnx_Split(@StyleType, ',')) OR @StyleType IS NULL)
	AND (sh.StyleCategory IN (SELECT value FROM dbo.fnx_Split(@StyleCategory, ',')) OR @StyleCategory IS NULL)
	AND (ssy.SeasonYearID IN (SELECT value FROM dbo.fnx_Split(@SeasonYear, ',')) OR @SeasonYear IS NULL)
	AND (tprl.AgentID IN (SELECT value FROM dbo.fnx_Split(@Agent, ',')) OR @Agent IS NULL)
	AND (tprl.VendorID IN (SELECT value FROM dbo.fnx_Split(@Vendor, ',')) OR @Vendor IS NULL)
	AND (tprl.FactoryID IN (SELECT value FROM dbo.fnx_Split(@Factory, ',')) OR @Factory IS NULL)
ORDER BY srw.DueDate, sh.StyleNo, sw.SampleWorkflowID

DECLARE @SQL NVARCHAR(MAX) 

SET @SQL = N' INSERT INTO pStyleCalendarTemp(
	CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, 
	CalendarType, CalendarStatus, CalendarDescription, CalendarView, CalendarSN)
SELECT CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate,
	CalendarType, CalendarStatus, CalendarDescription, CalendarView, CalendarSN
FROM #tmpCal ' + @SearchCond

--select * from pStyleCalendarTemp

IF @SampleStatus IS NOT NULL
BEGIN
	IF CHARINDEX('WHERE',@SQL) = 0
		SET @SQL = @SQL + ' WHERE (Status IN (' + @SampleStatus + ')'
	ELSE
		SET @SQL = @SQL + ' AND (Status IN (' + @SampleStatus + ')'
	
	-- check for Resibmit status		
	IF CHARINDEX('1',@SampleStatus) > 0
		SET @SQL = @SQL + ' OR (Submit > 1 AND Status NOT IN (2,3,4))'

	SET @SQL = @SQL + ')'
END

EXEC (@SQL)

DROP TABLE #tmpCal

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08813', GetDate())
GO
