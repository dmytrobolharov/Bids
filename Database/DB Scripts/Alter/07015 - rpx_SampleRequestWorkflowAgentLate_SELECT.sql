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
)
AS
BEGIN
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
			ELSE CAST(ABS(DATEDIFF(d, GETDATE(), srw.DueDate)) AS NVARCHAR(5)) + 'd Left'
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
		INNER JOIN pSampleWorkflowViewSubmit swvs ON sw.SampleWorkflowID = swvs.SampleWorkflowID AND swvs.TeamID = @TeamID
	WHERE
		srw.DueDate <= GETDATE()
		AND (srw.Submit >= @NoofSubmits OR @NoofSubmits IS NULL)
		AND srw.Status NOT IN (2, 3, 4)
		AND LOWER(sw.Active) = 'yes'
		AND (tprl.AgentID = @TradePartnerID OR tprl.VendorID = @TradePartnerID OR tprl.FactoryID = @TradePartnerID OR @TradePartnerID = '00000000-0000-0000-0000-000000000000')
		AND (srw.AssignedTo IN (SELECT value FROM dbo.fnx_Split(@AssignedTo, ',')) OR @AssignedTo = @UserID OR @AssignedTo = '')
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
VALUES ('DB_Version', '0.5.0000', '07015', GetDate())
GO
