IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestActivityCalendarAgent_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestActivityCalendarAgent_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestActivityCalendarAgent_INSERT]
	@TeamId [varchar](50),
	@TradePartnerId [varchar](50)=null,
	@CalendarId [varchar](50),
	@StartDate [datetime],
	@EndDate [datetime],
	@SearchCond NVARCHAR(MAX) = N'',
	@UserID INT = NULL,
	@AssignedTo NVARCHAR (200) = NULL	
WITH EXECUTE AS CALLER
AS

DECLARE @PrefLanguage NVARCHAR(10) = (SELECT PreferredLang FROM Users WHERE TeamID = @TeamId)

;WITH srt as (
	SELECT isrt.SampleRequestTradeID, isrt.StyleID, isrt.StyleSeasonYearID, 
		isrt.TradePartnerRelationshipLevelID, isrt.TradePartnerID, isrt.TradePartnerVendorID, 0 AS IsBOM, 
		ISNULL(sc.StyleColorName, '') AS Color
	FROM pSampleRequestTrade isrt
	LEFT JOIN pStyleColorway sc ON isrt.StyleColorID = sc.StyleColorID
	UNION
	SELECT isrt.SampleRequestTradeID, isrt.StyleID, isrt.StyleSeasonYearID, 
		isrt.TradePartnerRelationshipLevelID, isrt.TradePartnerID, isrt.TradePartnerVendorID, 1 AS IsBOM,
		COALESCE(sbdi1.ItemDim1Name, sbdi2.ItemDim2Name, sbdi3.ItemDim3Name, '') AS Color
	FROM pSampleRequestBOMTrade isrt
	LEFT JOIN pStyleBOMDimType sbdt ON LOWER(sbdt.DimTypeName) = 'color'
	LEFT JOIN pStyleBOMDimensionItem sbdi1 ON isrt.StyleBOMDimensionID = sbdi1.StyleBOMDimensionID 
		AND isrt.ItemDim1Id = sbdi1.ItemDim1Id AND sbdi1.ItemDim1TypeId = sbdt.DimTypeID
	LEFT JOIN pStyleBOMDimensionItem sbdi2 ON isrt.StyleBOMDimensionID = sbdi2.StyleBOMDimensionID 
		AND isrt.ItemDim2Id = sbdi2.ItemDim2Id AND sbdi1.ItemDim1TypeId = sbdt.DimTypeID
	LEFT JOIN pStyleBOMDimensionItem sbdi3 ON isrt.StyleBOMDimensionID = sbdi3.StyleBOMDimensionID 
		AND isrt.ItemDim3Id = sbdi3.ItemDim3Id AND sbdi1.ItemDim1TypeId = sbdt.DimTypeID
), srs as (
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, SampleRequestSubmitID, 
		Submit, AgentView, CAST(Comment AS NVARCHAR(MAX)) AS Comment 
	FROM pSampleRequestSubmit
	UNION
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, SampleRequestSubmitID, 
		Submit, AgentView, CAST(Comment AS NVARCHAR(MAX)) AS Comment 
	FROM pSampleRequestSubmitBOM
), srw as (
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, Submit, DueDate, EndDate, Status, AssignedTo FROM pSampleRequestWorkflow
	UNION
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, Submit, DueDate, EndDate, Status, AssignedTo FROM pSampleRequestWorkflowBOM
), sra as (
	SELECT SampleRequestSubmitID, ActivityType, TradePartner, CDate FROM pSampleRequestActivity
	UNION
	SELECT SampleRequestSubmitID, ActivityType, TradePartner, CDate FROM pSampleRequestBOMActivity
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
	srs.SampleRequestWorkflowID AS PKeyId,
	srs.SampleRequestTradeID AS CalendarLinkId,
	sw.SampleWorkflow + N' (' + CAST(srs.Submit AS nVARCHAR(4)) + ') ' AS CalendarLinkSubId,
	sra.CDate AS CalendarDate,
	'SampleActivity' AS CalendarType,
	sra.ActivityType AS CalendarStatus,
	'<span class="with-sample-tooltip" title="' + vsy.SeasonYear + ' ' + srt.Color + NCHAR(13) + 'Fit Comments: ' + ISNULL(srs.Comment, ' * ') + sc.Comments + '">' + 
	CASE WHEN srt.TradePartnerRelationshipLevelID IS NOT NULL
		THEN SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName, '') + ISNULL('/' + tprl.FactoryName, ''), 2, 2000)
		ELSE '<b>A: </b>' + tp.TradePartnerCode + ' / <b>V: </b>' + tpv.VendorCode
	END + '<BR>' + sh.StyleNo + ' (' + sh.SizeClass + ') ' + sh.Description + '</span>' AS CalendarDescription,
	srs.AgentView AS CalendarView,
	srt.IsBOM as CalendarSN,
	-- columns for search purposes
	tp.TradePartnerID, tpv.TradePartnerVendorID,
	tprl.AgentID, tprl.VendorID, tprl.FactoryID,
    sh.DivisionID, sh.StyleType AS StyleTypeID, sh.StyleCategory AS StyleCategoryID,
    sh.StyleNo, sh.Description, sh.Designer, sh.TechnicalDesigner, sh.ProductionManager,
    ssy.SeasonYearID, sh.CustomField3, sh.CustomField10, sh.SizeClass, sh.SizeRange,
    srw.AssignedTo
INTO #tmpCal
FROM srt
INNER JOIN srs ON srt.SampleRequestTradeID = srs.SampleRequestTradeID
INNER JOIN srw ON srs.SampleRequestWorkflowID = srw.SampleRequestWorkflowID
INNER JOIN pSampleWorkflow sw ON srs.SampleWorkflowID = sw.SampleWorkflowID
LEFT JOIN SampleComments sc ON srw.SampleRequestWorkflowID = sc.SampleRequestWorkflowID
INNER JOIN sra ON srs.SampleRequestSubmitID = sra.SampleRequestSubmitID
INNER JOIN pStyleHeader sh ON srt.StyleID = sh.StyleID
INNER JOIN pStyleSeasonYear ssy ON srt.StyleSeasonYearID = ssy.StyleSeasonYearID
INNER JOIN vwx_SeasonYear_SEL vsy ON ssy.SeasonYearID = vsy.SeasonYearID
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
LEFT JOIN uTradePartner tp ON srt.TradePartnerID = tp.TradePartnerID AND srt.TradePartnerRelationshipLevelID IS NULL
LEFT JOIN uTradePartnerVendor tpv ON srt.TradePartnerVendorID = tpv.TradePartnerVendorID AND srt.TradePartnerRelationshipLevelID IS NULL
WHERE sra.TradePartner = 0
	AND sra.CDate BETWEEN @StartDate AND @EndDate
	AND sra.ActivityType NOT IN ('V', 'U')
	AND srs.SampleWorkflowID IN (
		SELECT SampleWorkflowId FROM pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)
	AND sw.SampleWorkflowID IN (
		SELECT SampleTypeId FROM sAccessSampleFolder WITH (NOLOCK)
		WHERE TeamId = @TeamId AND (AccessRoleId = 3 OR AccessView = 1))
	AND (@TradePartnerId IS NULL OR @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID, tp.TradePartnerID))
ORDER BY sra.CDate DESC, sh.StyleNo, sw.SampleWorkflowID

DECLARE @SQL NVARCHAR(MAX) 

SET @SQL = N'INSERT INTO pStyleCalendarTemp(
	CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, 
	CalendarType, CalendarStatus, CalendarDescription, CalendarView, CalendarSN)
SELECT CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, 
	CalendarType, CalendarStatus, CalendarDescription, CalendarView, CalendarSN
FROM #tmpCal ' + @SearchCond

IF @UserID IS NOT NULL
BEGIN
	IF CHARINDEX('WHERE',@SQL) = 0
		SET @SQL = @SQL + ' WHERE AssignedTo = ' + CAST(@UserID AS NVARCHAR(10))
	ELSE
		SET @SQL = @SQL + ' AND AssignedTo = ' + CAST(@UserID AS NVARCHAR(10))
END

IF @AssignedTo IS NOT NULL AND LEN(@AssignedTo) > 0 
BEGIN
	IF CHARINDEX('WHERE',@SQL) = 0
		SET @SQL = @SQL + ' WHERE AssignedTo IN (' + @AssignedTo + ')'
	ELSE
		SET @SQL = @SQL + ' AND AssignedTo IN (' + @AssignedTo + ')'
END

EXEC (@SQL)

DROP TABLE #tmpCal


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07069', GetDate())
GO
