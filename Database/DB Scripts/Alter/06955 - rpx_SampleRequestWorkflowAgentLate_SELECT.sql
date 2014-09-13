IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestWorkflowAgentLate_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestWorkflowAgentLate_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_SampleRequestWorkflowAgentLate_SELECT]
    @TradePartnerID NVARCHAR(50) = NULL,
    @TeamID NVARCHAR(50),
	@Filter NVARCHAR (4000),
	@SampleStatus NVARCHAR (50),
	@NoOfSubmits NVARCHAR (10),
	@UserID NVARCHAR (10)
WITH EXECUTE AS CALLER
AS


IF  @TradePartnerID IS NULL OR @TradePartnerID=''
BEGIN
    SET @TradePartnerID = NULL
END

;WITH srt as (
	SELECT SampleRequestTradeID, StyleID, StyleSeasonYearID, TradePartnerRelationshipLevelID, TradePartnerID, TradePartnerVendorID, 0 AS IsBOM FROM pSampleRequestTrade 
	UNION
	SELECT SampleRequestTradeID, StyleID, StyleSeasonYearID, TradePartnerRelationshipLevelID, TradePartnerID, TradePartnerVendorID, 1 AS IsBOM FROM pSampleRequestBOMTrade
), srw as (
	SELECT SampleRequestTradeID, StyleID, StyleSet, SampleWorkflowID, SampleRequestWorkflowID, Submit, StartDate, DueDate, EndDate, Status, AssignedTo FROM pSampleRequestWorkflow
	UNION
	SELECT SampleRequestTradeID, StyleID, StyleSet, SampleWorkflowID, SampleRequestWorkflowID, Submit, StartDate, DueDate, EndDate, Status, AssignedTo FROM pSampleRequestWorkflowBOM
), srs as (
	SELECT SampleRequestWorkflowID, Submit, CAST(Comment AS NVARCHAR(MAX)) AS Comment FROM pSampleRequestSubmit
	UNION
	SELECT SampleRequestWorkflowID, Submit, CAST(Comment AS NVARCHAR(MAX)) AS Comment FROM pSampleRequestSubmitBOM
)
SELECT  srw.SampleRequestWorkflowID, srw.SampleWorkflowID,
        srw.SampleRequestTradeID, srt.TradePartnerVendorID,
        srt.StyleID, srw.StyleSet, srw.Status, srw.Submit, srw.StartDate,
        srw.DueDate, srw.EndDate, dbo.pSampleWorkflow.SampleWorkflow,
        dbo.pSampleWorkflow.SampleWorkflowSort, dbo.pSampleWorkflow.GroupName, srw.AssignedTo, dbo.Users.FirstName, dbo.Users.LastName, 
        dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(srw.Submit AS nvarchar(4)) + ') ' AS LateHeader,
        'TP: ' + SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode,'') + ISNULL ('/' + tprl.FactoryCode, ''), 2, 1000) + '   ' + dbo.pStyleHeader.StyleNo + ' (' +
        dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS LateDescription, srs.Comment,
        srt.TradePartnerID, tprl.AgentID, tprl.VendorID, tprl.FactoryID,
        dbo.pStyleHeader.DivisionID, dbo.pStyleHeader.StyleType AS StyleTypeID, dbo.pStyleHeader.StyleCategory AS StyleCategoryID,
        dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.Description, dbo.pStyleHeader.Designer, dbo.pStyleHeader.TechnicalDesigner, dbo.pStyleHeader.ProductionManager,
        dbo.pStyleSeasonYear.SeasonYearID, dbo.pStyleHeader.CustomField3, dbo.pStyleHeader.CustomField10, dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.SizeRange,
        srt.IsBOM
INTO #tmpSample
FROM    srw INNER JOIN 
		srt ON srw.SampleRequestTradeID = srt.SampleRequestTradeID INNER JOIN
        srs ON srs.SampleRequestWorkflowID = srw.SampleRequestWorkflowID INNER JOIN
        dbo.pSampleWorkflow WITH (NOLOCK) ON srw.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
        dbo.pStyleHeader WITH (NOLOCK) ON srw.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
        dbo.uTradePartner WITH (NOLOCK) ON srt.TradePartnerID = dbo.uTradePartner.TradePartnerID LEFT OUTER JOIN
        dbo.Users WITH (NOLOCK) ON srw.AssignedTo = dbo.Users.UserId INNER JOIN
        vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID INNER JOIN 
        dbo.pStyleSeasonYear WITH (NOLOCK) ON srt.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID
        
WHERE   (srw.DueDate <= GETDATE())
        AND (srw.Status NOT IN (2, 3, 4))
        AND (pSampleWorkflow.Active = 'Yes')
        AND
        (
            pSampleWorkflow.SampleWorkflowID IN
            (
                SELECT SampleWorkflowId
                FROM pSampleWorkflowViewSubmit WITH (NOLOCK)
                WHERE TeamId = @TeamID
            )
        )
        ORDER BY srw.DueDate, dbo.pStyleHeader.StyleNo
        
DECLARE @SQL NVARCHAR(MAX) 
        
IF @Filter IS NOT NULL AND LEN(@Filter) > 0 
	SET @SQL = 'SELECT * FROM #tmpSample WHERE ' + @Filter 
ELSE 
	SET @SQL = 'SELECT * FROM #tmpSample '

IF @TradePartnerID IS NOT NULL
	IF CHARINDEX('WHERE',@SQL) = 0
		SET @SQL = @SQL + ' WHERE (TradePartnerID = ''' + @TradePartnerID + ''' OR ''' + @TradePartnerID + ''' IN (AgentID, VendorID, FactoryID))'
	ELSE
		SET @SQL = @SQL + ' AND (TradePartnerID = ''' + @TradePartnerID + ''' OR ''' + @TradePartnerID + ''' IN (AgentID, VendorID, FactoryID))'

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

IF @UserID IS NOT NULL AND LEN(@UserID) > 0
BEGIN
	IF CHARINDEX('WHERE',@SQL) = 0
		SET @SQL = @SQL + ' WHERE AssignedTo = ' + CAST(@UserID AS NVARCHAR(10))
	ELSE
		SET @SQL = @SQL + ' AND AssignedTo = ' + CAST(@UserID AS NVARCHAR(10))
END

--PRINT (@SQL)
EXEC (@SQL)

DROP TABLE #tmpSample
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06955', GetDate())
GO
