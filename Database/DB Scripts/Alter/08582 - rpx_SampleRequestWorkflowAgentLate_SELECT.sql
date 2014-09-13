IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestWorkflowAgentLate_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestWorkflowAgentLate_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_SampleRequestWorkflowAgentLate_SELECT]
(
    @TradePartnerID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
	, @TeamID UNIQUEIDENTIFIER
	, @Filter NVARCHAR(MAX)
	, @UserID NVARCHAR(10)
	, @AssignedTo NVARCHAR(MAX)
	, @NoofSubmits INT = NULL
	, @StyleType NVARCHAR (MAX)
	, @StyleCategory NVARCHAR (MAX)
	, @SeasonYear NVARCHAR (MAX)
	, @Agent NVARCHAR (MAX)
	, @Vendor NVARCHAR (MAX)
	, @Factory NVARCHAR (MAX)
	
)
AS
BEGIN

	DECLARE @PrefLanguage NVARCHAR(10) = (SELECT PreferredLang FROM Users WHERE TeamID = @TeamId)

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
	)
	SELECT
		sh.StyleNo
		, sh.Description
		, sc.StyleCategory
		, sh.SizeClass
		, ISNULL(sdi.StyleDevelopmentName, sdi.Variation) AS VariationName
		, sh.StyleSet
		, sh.TechPackDate
		, sy.Season + ' ' + sy.Year AS SeasonYear
		, sdi.Variation
		, sh.SizeRange
		, sh.StyleCategory AS StyleCategoryID
		, wfi.WorkFlowItemName
		, di1.ItemDim1Name
		, di2.ItemDim2Name
		, di3.ItemDim3Name
		, tprl.AgentName
		, tprl.VendorName
		, tprl.FactoryName
		, sw.SampleWorkflow
		, srw.DueDate
		, srw.Status
		, CASE
			WHEN srw.Status = 2 OR srw.Status = 3 THEN 'Apprvd'
			WHEN DATEDIFF(d, GETDATE(), srw.DueDate)<0 THEN CAST(ABS(DATEDIFF(d, GETDATE(), srw.DueDate)) AS NVARCHAR(5)) + 'd Late'
			ELSE CAST(ABS(DATEDIFF(d, GETDATE(), srw.DueDate)) AS NVARCHAR(5)) + 'd Remain'
		  END AS TextMessage	
		, CASE
			WHEN srw.Status = 2 OR srw.Status = 3 THEN 'PaleGreen'
			WHEN DATEDIFF(d, GETDATE(), srw.DueDate)<=0 THEN 'IndianRed'
			ELSE 'No Color'
		  END AS Color
		, ISNULL(tprl.AgentID, '00000000-0000-0000-0000-000000000000') AS AgentID
		, ISNULL(tprl.VendorID, '00000000-0000-0000-0000-000000000000') AS VendorID
		, ISNULL(tprl.FactoryID, '00000000-0000-0000-0000-000000000000') AS FactoryID
		, sr.SampleRequestTradeID
		, srw.SampleWorkflowID
		, sh.DivisionID
		, sh.StyleType AS StyleTypeID
		, sh.Designer
		, sh.TechnicalDesigner
		, sh.ProductionManager
		, ssy.SeasonYearID
		, sh.CustomField3
		, sh.CustomField10
		, srw.Submit
		, sy.Season + ' ' + sy.Year + ' ' + CASE 
			WHEN gt.DimTypeName LIKE '%color%'
				THEN di1.ItemDim1Name
			WHEN ht.DimTypeName LIKE '%color%'
				THEN di2.ItemDim2Name
			WHEN jt.DimTypeName LIKE '%color%'
				THEN di3.ItemDim3Name
			ELSE ''
			END + NCHAR(13) + 'Fit Comments: ' + REPLACE(ISNULL(CAST(srs.Comment AS NVARCHAR(MAX)), ' * '), 'span', 'u') + REPLACE(scom.Comments, 'span', 'u') AS Comments
	INTO #tmpInfo
	FROM
		pStyleHeader sh
		INNER JOIN pStyleSeasonYear ssy
			INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		ON sh.StyleID = ssy.StyleID
		INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
		INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
		INNER JOIN pSampleRequestBOMTrade sr ON sh.StyleID = sr.StyleID AND ssy.StyleSeasonYearID = sr.StyleSeasonYearID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON sr.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		INNER JOIN pSampleRequestWorkflowBOM srw
			INNER JOIN pSampleWorkflow sw ON srw.SampleWorkflowID = sw.SampleWorkflowID
		ON sr.SampleRequestTradeID = srw.SampleRequestTradeID
		LEFT JOIN pStyleBOMDimensionItem di1 ON sr.ItemDim1ID=di1.ItemDim1ID AND sr.StyleBOMDimensionID = di1.StyleBOMDimensionID
		LEFT JOIN pStyleBOMDimensionItem di2 ON sr.ItemDim2ID=di2.ItemDim2ID AND sr.StyleBOMDimensionID = di2.StyleBOMDimensionID
		LEFT JOIN pStyleBOMDimensionItem di3 ON sr.ItemDim3ID=di3.ItemDim3ID AND sr.StyleBOMDimensionID = di3.StyleBOMDimensionID
		LEFT JOIN pStyleBOMDimType gt ON di1.ItemDim1TypeId = gt.DimTypeID
		LEFT JOIN pStyleBOMDimType ht ON di2.ItemDim2TypeId = ht.DimTypeID
		LEFT JOIN pStyleBOMDimType jt ON di3.ItemDim3TypeId = jt.DimTypeID
		LEFT JOIN pStyleBOM sb
			INNER JOIN pWorkFlowItem wfi ON sb.WorkflowItemId = wfi.WorkFlowItemID
		ON sr.StyleBOMDimensionID = sb.StyleBOMDimensionID
		INNER JOIN pSampleWorkflowViewSubmit swvs ON sw.SampleWorkflowID = swvs.SampleWorkflowID AND swvs.TeamID = @TeamID
		LEFT JOIN SampleComments scom ON srw.SampleRequestWorkflowID = scom.SampleRequestWorkflowID
		INNER JOIN pSampleRequestSubmitBOM srs ON srw.SampleRequestWorkflowID = srs.SampleRequestWorkflowID AND srw.Submit = srs.Submit
	WHERE
		srw.DueDate <= GETDATE()
		AND (srw.Submit >= @NoofSubmits OR @NoofSubmits IS NULL)
		AND srw.Status NOT IN (2, 3, 4)
		AND LOWER(sw.Active) = 'yes'
		AND (tprl.AgentID = @TradePartnerID OR tprl.VendorID = @TradePartnerID OR tprl.FactoryID = @TradePartnerID OR @TradePartnerID = '00000000-0000-0000-0000-000000000000')
		AND (srw.AssignedTo = @UserID OR @UserID IS NULL OR @UserID = '')
		AND (srw.AssignedTo IN (SELECT value FROM dbo.fnx_Split(@AssignedTo, ',')) OR @AssignedTo IS NULL OR @AssignedTo = '')
		AND (sh.StyleType IN (SELECT value FROM dbo.fnx_Split(@StyleType, ',')) OR @StyleType IS NULL OR @StyleType = '')
		AND (sh.StyleCategory IN (SELECT value FROM dbo.fnx_Split(@StyleCategory, ',')) OR @StyleCategory IS NULL OR @StyleCategory = '')
		AND (sy.SeasonYearID IN (SELECT value FROM dbo.fnx_Split(@SeasonYear, ',')) OR @SeasonYear IS NULL OR @SeasonYear = '')
		AND (tprl.AgentID IN (SELECT value FROM dbo.fnx_Split(@Agent, ',')) OR @Agent IS NULL OR @Agent = '')
		AND (tprl.VendorID IN (SELECT value FROM dbo.fnx_Split(@Vendor, ',')) OR @Vendor IS NULL OR @Vendor = '')
		AND (tprl.FactoryID IN (SELECT value FROM dbo.fnx_Split(@Factory, ',')) OR @Factory IS NULL OR @Factory = '')
	ORDER BY
		sh.StyleNo
		, SeasonYear
		, sdi.Variation


	IF LEN(@Filter)>0
		EXEC ('SELECT * FROM #tmpInfo WHERE ' + @Filter)
	ELSE
		EXEC ('SELECT * FROM #tmpInfo')
	
	DROP TABLE #tmpInfo		
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08582', GetDate())
GO
