IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestCalendarAgent_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestCalendarAgent_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestCalendarAgent_INSERT]
	@TeamId [varchar](50),
	@TradePartnerId [varchar](50) = null,
	@CalendarId [varchar](50),
	@StartDate [datetime],
	@EndDate [datetime],
	@SearchCond NVARCHAR(MAX) = N'',
	@SampleStatus NVARCHAR (50) = NULL,
	@NoOfSubmits NVARCHAR (10) = NULL,
	@UserID INT = NULL
WITH EXECUTE AS CALLER
AS
/*Holiday's INSERT SELECT Statement.*/
INSERT INTO pStyleCalendarTemp
		(CalendarID, PKeyID, CalendarLinkID, CalendarLinkSubID, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT	@CalendarID AS CalendarID, '00000000-0000-0000-0000-000000000000' AS PKeyID, '00000000-0000-0000-0000-000000000000' AS CalendarLinkID, 
	'00000000-0000-0000-0000-000000000000' AS CalendarLinkSubID, CalendarEventDate AS CalendarDate, 'Holiday' AS CalendarType, 0 AS CalendarStatus,
	CalendarEventCountry +  ' - ' + CalendarEventName as CalendarDescription
FROM	cCalendarEvent WITH (NOLOCK)

;WITH srt as (
	SELECT SampleRequestTradeID, StyleID, StyleSeasonYearID, TradePartnerRelationshipLevelID, TradePartnerID, TradePartnerVendorID, 0 AS IsBOM FROM pSampleRequestTrade 
	UNION
	SELECT SampleRequestTradeID, StyleID, StyleSeasonYearID, TradePartnerRelationshipLevelID, TradePartnerID, TradePartnerVendorID, 1 AS IsBOM FROM pSampleRequestBOMTrade
), srw as (
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, Submit, DueDate, EndDate, Status, AssignedTo FROM pSampleRequestWorkflow
	UNION
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, Submit, DueDate, EndDate, Status, AssignedTo FROM pSampleRequestWorkflowBOM
), srs as (
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, SampleRequestSubmitID, Submit, AgentView FROM pSampleRequestSubmit
	UNION
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, SampleRequestSubmitID, Submit, AgentView FROM pSampleRequestSubmitBOM
)
SELECT @CalendarId AS CalendarId,
	srs.SampleRequestSubmitID AS PKeyId,
	srw.SampleRequestTradeID AS CalendarLinkId,
	sw.SampleWorkflow + N' (' + CAST(srw.Submit AS nVARCHAR(4)) + ') ' AS CalendarLinkSubId,
	srw.DueDate AS CalendarDate,
	'SampleRequestSubmit' AS CalendarType,
	srw.Status AS CalendarStatus,
	CASE WHEN srt.TradePartnerRelationshipLevelID IS NOT NULL
		THEN SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName, '') + ISNULL('/' + tprl.FactoryName, ''), 2, 2000)
		ELSE '<b>A: </b>' + tp.TradePartnerCode + ' / <b>V: </b>' + tpv.VendorCode
	END + '<BR>' + sh.StyleNo + ' (' + sh.SizeClass + ') ' + sh.Description AS CalendarDescription,
	0 AS CalendarView,
	srt.IsBOM as CalendarSN,
	-- columns for search purposes
	tp.TradePartnerID, tpv.TradePartnerVendorID,
	tprl.AgentID, tprl.VendorID, tprl.FactoryID,
    sh.DivisionID, sh.StyleType AS StyleTypeID, sh.StyleCategory AS StyleCategoryID,
    sh.StyleNo, sh.Description, sh.Designer, sh.TechnicalDesigner, sh.ProductionManager,
    ssy.SeasonYearID, sh.CustomField3, sh.CustomField10, sh.SizeClass, sh.SizeRange,
	srw.Submit, srw.Status, srw.AssignedTo
INTO #tmpCal
FROM srt
INNER JOIN srw ON srt.SampleRequestTradeID = srw.SampleRequestTradeID
INNER JOIN srs ON srw.SampleRequestWorkflowID = srs.SampleRequestWorkflowID AND srw.Submit = srs.Submit
INNER JOIN pSampleWorkflow sw ON srw.SampleWorkflowID = sw.SampleWorkflowID
INNER JOIN pStyleHeader sh ON srt.StyleID = sh.StyleID
INNER JOIN pStyleSeasonYear ssy ON srt.StyleSeasonYearID = ssy.StyleSeasonYearID
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
LEFT JOIN uTradePartner tp ON srt.TradePartnerID = tp.TradePartnerID AND srt.TradePartnerRelationshipLevelID IS NULL
LEFT JOIN uTradePartnerVendor tpv ON srt.TradePartnerVendorID = tpv.TradePartnerVendorID AND srt.TradePartnerRelationshipLevelID IS NULL
WHERE 
	((srw.DueDate BETWEEN @StartDate AND @EndDate AND srw.Status NOT IN (
			SELECT StatusID FROM pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4))
	OR (srw.Status = 1 AND srw.EndDate BETWEEN @StartDate AND @EndDate))
	AND srw.SampleWorkflowID IN (
		SELECT SampleWorkflowId FROM pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)
	AND sw.SampleWorkflowID IN (
		SELECT SampleTypeId FROM sAccessSampleFolder WITH (NOLOCK) 
		WHERE TeamId = @TeamId AND (AccessRoleId = 3 OR AccessView = 1))		
	AND (@TradePartnerId IS NULL OR @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID, tp.TradePartnerID))
ORDER BY srw.DueDate, sh.StyleNo, sw.SampleWorkflowID

DECLARE @SQL NVARCHAR(MAX) 

SET @SQL = N' INSERT INTO pStyleCalendarTemp(
	CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, 
	CalendarType, CalendarStatus, CalendarDescription, CalendarView, CalendarSN)
SELECT CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate,
	CalendarType, CalendarStatus, CalendarDescription, CalendarView, CalendarSN
FROM #tmpCal ' + @SearchCond

IF @NoOfSubmits IS NOT NULL AND LEN(@NoOfSubmits) > 0 
BEGIN
	IF CHARINDEX('WHERE',@SQL) = 0
		SET @SQL = @SQL + ' WHERE Submit >= ' + @NoOfSubmits
	ELSE
		SET @SQL = @SQL + ' AND Submit >= ' + @NoOfSubmits
END

IF @SampleStatus IS NOT NULL AND LEN(@SampleStatus) > 0 
BEGIN
	IF CHARINDEX('WHERE',@SQL) = 0
		SET @SQL = @SQL + ' WHERE Status IN (' + @SampleStatus + ')'
	ELSE
		SET @SQL = @SQL + ' AND Status IN (' + @SampleStatus + ')'
END

IF @UserID IS NOT NULL
BEGIN
	IF CHARINDEX('WHERE',@SQL) = 0
		SET @SQL = @SQL + ' WHERE AssignedTo = ' + CAST(@UserID AS NVARCHAR(10))
	ELSE
		SET @SQL = @SQL + ' AND AssignedTo = ' + CAST(@UserID AS NVARCHAR(10))
END

EXEC (@SQL)

DROP TABLE #tmpCal

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06956', GetDate())
GO
