IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_CalendarMilestoneSample_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_CalendarMilestoneSample_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_CalendarMilestoneSample_SELECT](
	  @CalendarHeaderID UNIQUEIDENTIFIER
	, @BOMID UNIQUEIDENTIFIER
) AS

DECLARE @SeasonYearID UNIQUEIDENTIFIER = (SELECT SeasonYearID FROM pCalendarHeader WHERE CalendarHeaderID = @CalendarHeaderID)
		
SELECT
	  sh.StyleID
	, sh.StyleNo
	, sh.Description
	, div.Custom AS Division
	, st.StyleTypeDescription
	, sh.SizeClass
	, sc.StyleCategory
	, ISNULL(sdi.StyleDevelopmentName, sdi.Variation) AS Variation
	, CASE WHEN sh.IntroSeasonYearID = @SeasonYearID THEN 'No' ELSE 'Yes' END AS IsCarryOver
	, wi.WorkFlowItemName AS BOMName
INTO #tmpCalStatic
FROM pStyleHeader sh
INNER JOIN pWorkFlowItem wi ON sh.StyleID = wi.StyleID
INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
INNER JOIN iCustom1 div ON sh.DivisionID = div.CustomID
INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
WHERE wi.WorkflowItemId = @BOMID

-- Sample Request Approved Status Count --	
SELECT
	  srw.StyleID
	, sw.SampleWorkflowRepID
	, srw.DueDate AS DueDate
	, CASE WHEN srw.Status = 3 THEN 1 ELSE 0 END AS ApprovedStatusCount
	, tprl.AgentName
	, tprl.VendorName
	, tprl.FactoryName
	, srt.TradePartnerRelationshipLevelID
	, srw.SampleRequestTradeID
INTO #tmpSampleRequest
FROM (
	SELECT StyleID, DueDate, Status, SampleWorkflowID, SampleRequestTradeID FROM pSampleRequestWorkflow
	UNION
	SELECT StyleID, DueDate, Status, SampleWorkflowID, SampleRequestTradeID FROM pSampleRequestWorkflowBOM
) srw
INNER JOIN (
	SELECT SampleRequestTradeID, TradePartnerRelationshipLevelID FROM pSampleRequestTrade
	UNION
	SELECT SampleRequestTradeID, TradePartnerRelationshipLevelID FROM pSampleRequestBOMTrade
 ) srt ON srw.SampleRequestTradeID = srt.SampleRequestTradeID
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
LEFT JOIN pSampleWorkflow sw ON srw.SampleWorkflowID = sw.SampleWorkflowID
INNER JOIN #tmpCalStatic tcs ON srw.StyleID = tcs.StyleID
ORDER BY srt.TradePartnerRelationshipLevelID, SampleWorkflowRepId

-- Sample Request Status Count --	
SELECT
	  srw.StyleID
	, sw.SampleWorkflowRepID
	, MAX(srw.DueDate) AS DueDate
	, SUM(CASE WHEN cmiws.WorkflowStatusID = srw.Status THEN 1 ELSE 0 END) AS ApprovedStatusCount
	, cmi.CalendarMilestoneItemID
INTO #tmpMilistoneSampleRequest
FROM (pCalendarMilestoneItemWorkflowStatus cmiws
INNER JOIN pCalendarMilestoneItem cmi ON cmiws.CalendarMilestoneItemID = cmi.CalendarMilestoneItemID)
CROSS JOIN
(
	SELECT StyleID, DueDate, Status, SampleWorkflowID FROM pSampleRequestWorkflow
	UNION
	SELECT StyleID, DueDate, Status, SampleWorkflowID FROM pSampleRequestWorkflowBOM
) srw
INNER JOIN #tmpCalStatic tcs ON srw.StyleID = tcs.StyleID
LEFT JOIN pSampleWorkflow sw ON srw.SampleWorkflowID = sw.SampleWorkflowID
WHERE cmi.CalendarHeaderID = @CalendarHeaderID
	AND cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000004'
GROUP BY cmi.CalendarMilestoneItemID, srw.StyleID, sw.SampleWorkflowRepID
	
-- Calendar Milestones - Sample Requests -- 
SELECT 
	  tcs.*
	, '00000000-0000-0000-0000-000000000000' AS UberGroupID
	, 'Calendar Milestones'	AS UberGroupName
	, 0 AS UberGroupSort
	, cmi.CalendarMilestoneItemID AS GroupID
	, cmi.CalendarMilestoneItemName AS GroupName
	, 3 AS GroupSort
	, NULL AS TradePartnerRelationshipLevelID
	, NULL AS SampleRequestTradeID
	, NULL AS AgentName
	, NULL AS VendorName
	, NULL AS FactoryName
	, cmi.MilestoneDate
	, CASE WHEN COUNT(CASE WHEN tmsr.ApprovedStatusCount = 0 OR tmsr.ApprovedStatusCount IS NULL THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsComplete
	, CASE 
		WHEN COUNT(CASE WHEN tmsr.ApprovedStatusCount = 0 OR tmsr.ApprovedStatusCount IS NULL THEN 1 ELSE NULL END) = 0 THEN 'Complete'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(CASE WHEN tmsr.ApprovedStatusCount = 0 THEN tmsr.DueDate ELSE NULL END)) < 0 THEN CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(CASE WHEN tmsr.ApprovedStatusCount = 0 THEN tmsr.DueDate ELSE NULL END))) AS VARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(CASE WHEN tmsr.ApprovedStatusCount = 0 THEN tmsr.DueDate ELSE NULL END))) AS VARCHAR(5)) + 'd Remain'
	  END AS DaysMessage
	, NULL AS DueDate
	, CASE 
		WHEN COUNT(CASE WHEN tmsr.ApprovedStatusCount = 0 OR tmsr.ApprovedStatusCount IS NULL THEN 1 ELSE NULL END) = 0 THEN 'LightGreen'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(CASE WHEN tmsr.ApprovedStatusCount = 0 THEN tmsr.DueDate ELSE NULL END)) < 0 THEN 'IndianRed'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(CASE WHEN tmsr.ApprovedStatusCount = 0 THEN tmsr.DueDate ELSE NULL END)) BETWEEN 0 AND 7 THEN 'Khaki'		
		ELSE 'None'
	  END AS Color
FROM #tmpCalStatic tcs
CROSS JOIN pCalendarMilestoneItem cmi
INNER JOIN pCalendarMilestoneItemWorkflow cmiw ON cmi.CalendarMilestoneItemID = cmiw.CalendarMilestoneItemID
LEFT JOIN #tmpMilistoneSampleRequest tmsr ON cmiw.WorkflowID = tmsr.SampleWorkflowRepId
	AND tcs.StyleID = tmsr.StyleID
	AND cmi.CalendarMilestoneItemID = tmsr.CalendarMilestoneItemID
WHERE cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000004' AND cmi.CalendarHeaderID = @CalendarHeaderID
GROUP BY
	  tcs.StyleID
	, tcs.StyleNo
	, tcs.Description
	, tcs.Division
	, tcs.StyleTypeDescription
	, tcs.SizeClass
	, tcs.StyleCategory
	, tcs.Variation
	, tcs.IsCarryOver
	, tcs.BOMName
	, cmi.CalendarMilestoneItemID
	, cmi.CalendarMilestoneItemName
	, cmi.MilestoneDate
UNION

-- Sample Requests --
SELECT 
	  tcs.*
	, '00000000-0000-0000-0000-000000000004' AS UberGroupID
	, (SELECT WorkflowTypeName FROM pWorkflowType WHERE WorkflowTypeID = '00000000-0000-0000-0000-000000000004')	AS UberGroupName
	, 4 AS UberGroupSort
	, cmiw.WorkflowID AS GroupID
	, sw.SampleWorkflow AS GroupName
	, sw.SampleWorkflowSort AS GroupSort
	, tsw.TradePartnerRelationshipLevelID
	, tsw.SampleRequestTradeID
	, tsw.AgentName
	, tsw.VendorName
	, tsw.FactoryName
	, NULL AS MilestoneDate
	, CASE WHEN COUNT(CASE WHEN tsw.ApprovedStatusCount = 0 OR tsw.ApprovedStatusCount IS NULL THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsComplete
	, CASE 
		WHEN COUNT(CASE WHEN tsw.ApprovedStatusCount = 0 OR tsw.ApprovedStatusCount IS NULL THEN 1 ELSE NULL END) = 0 THEN 'Approved'
		WHEN DATEDIFF(DAY, GETDATE(), MAX(tsw.DueDate)) < 0 THEN CAST(ABS(DATEDIFF(DAY, GETDATE(), MAX(tsw.DueDate))) AS VARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(DAY, GETDATE(), MAX(tsw.DueDate))) AS VARCHAR(5)) + 'd Remain'
	  END AS DaysMessage
	, MAX(tsw.DueDate) AS DueDate
	, CASE 
		WHEN COUNT(CASE WHEN tsw.ApprovedStatusCount = 0 OR tsw.ApprovedStatusCount IS NULL THEN 1 ELSE NULL END) = 0 THEN 'LightGreen'
		WHEN DATEDIFF(DAY, GETDATE(), MAX(tsw.DueDate)) < 0 THEN 'IndianRed'
		WHEN DATEDIFF(DAY, GETDATE(), MAX(tsw.DueDate)) BETWEEN 0 AND 7 THEN 'Khaki'		
		ELSE 'None'
	  END AS Color
FROM #tmpCalStatic tcs
CROSS JOIN pCalendarMilestoneItem cmi
INNER JOIN pCalendarMilestoneItemWorkflow cmiw ON cmi.CalendarMilestoneItemID = cmiw.CalendarMilestoneItemID
LEFT JOIN pSampleWorkflow sw ON cmiw.WorkflowID = sw.SampleWorkflowRepId
LEFT JOIN #tmpSampleRequest tsw ON cmiw.WorkflowID = tsw.SampleWorkflowRepId AND tcs.StyleID = tsw.StyleID
WHERE cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000004' AND cmi.CalendarHeaderID = @CalendarHeaderID
GROUP BY
	  tcs.StyleID
	, tcs.StyleNo
	, tcs.Description
	, tcs.Division
	, tcs.StyleTypeDescription
	, tcs.SizeClass
	, tcs.StyleCategory
	, tcs.Variation
	, tcs.IsCarryOver
	, tcs.BOMName
	, cmiw.WorkflowID
	, sw.SampleWorkflow
	, cmi.MilestoneDate
	, sw.SampleWorkflowSort
	, tsw.TradePartnerRelationshipLevelID
	, tsw.SampleRequestTradeID
	, tsw.AgentName
	, tsw.VendorName
	, tsw.FactoryName

DROP TABLE #tmpCalStatic
DROP TABLE #tmpSampleRequest
DROP TABLE #tmpMilistoneSampleRequest


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05518', GetDate())
GO
