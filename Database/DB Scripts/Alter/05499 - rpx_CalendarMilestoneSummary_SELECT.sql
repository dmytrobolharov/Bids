IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_CalendarMilestoneSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_CalendarMilestoneSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_CalendarMilestoneSummary_SELECT](
	@CalendarHeaderID UNIQUEIDENTIFIER
	, @LineList NVARCHAR(MAX)
	, @Division NVARCHAR(MAX)
	, @StyleType NVARCHAR(MAX)
	, @StyleCategory NVARCHAR(MAX)
	, @SizeClass NVARCHAR(MAX)
	, @StyleTheme NVARCHAR(MAX)
) AS

SELECT CAST(value AS UNIQUEIDENTIFIER) AS LineFolderID INTO #tmpLineList FROM fnx_Split(@LineList,',')
SELECT CAST(value AS UNIQUEIDENTIFIER) AS DivivsionID INTO #tmpDivision FROM fnx_Split(@Division,',')

CREATE TABLE #tmpStyleType (StyleTypeID INT)
IF -1 NOT IN (SELECT items FROM Split(@StyleType,','))
	INSERT INTO #tmpStyleType SELECT CAST(value AS INT) FROM fnx_Split(@StyleType,',')
ELSE
	INSERT INTO #tmpStyleType SELECT StyleTypeID FROM pStyleType
	
CREATE TABLE #tmpStyleCategory (StyleCategoryID UNIQUEIDENTIFIER)
IF '00000000-0000-0000-0000-000000000000' NOT IN (SELECT items FROM Split(@StyleCategory,','))
	INSERT INTO #tmpStyleCategory SELECT CAST(value AS UNIQUEIDENTIFIER) FROM fnx_Split(@StyleCategory,',')
ELSE
	INSERT INTO #tmpStyleCategory SELECT StyleCategoryId FROM pStyleCategory		

SELECT value AS SizeClass INTO #tmpSizeClass FROM fnx_Split(@SizeClass,',')
SELECT CAST(value AS UNIQUEIDENTIFIER) AS StyleThemeID INTO #tmpStyleTheme FROM fnx_Split(@StyleTheme,',')
IF (SELECT COUNT(StyleThemeID) FROM #tmpStyleTheme WHERE StyleThemeID = '00000000-0000-0000-0000-000000000000')>0
	INSERT INTO #tmpStyleTheme VALUES (NULL)

SELECT 
	  sh.StyleID
	, sh.StyleNo
	, sh.Description
	, div.Custom AS Division
	, st.StyleTypeDescription
	, sh.SizeClass
	, sc.StyleCategory
	, ISNULL(sdi.StyleDevelopmentName, sdi.Variation) AS Variation
	, CASE WHEN sh.IntroSeasonYearID = ssy.SeasonYearID THEN 'No' ELSE 'Yes' END AS IsCarryOver
	, lfi.StyleBOMWorkflowItemID AS BOMID
	, wi.WorkFlowItemName AS BOMName	
INTO #tmpCalStatic
FROM pCalendarHeader ch
INNER JOIN pCalendarLineFolder clf ON ch.CalendarHeaderID = clf.CalendarHeaderID
INNER JOIN pLineFolderItem lfi ON clf.LineFolderID = lfi.LineFolderID
INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID
INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
INNER JOIN iCustom1 div ON sh.DivisionID = div.CustomID
INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
INNER JOIN pStyleSeasonYear ssy ON lfi.StyleSeasonYearID = ssy.StyleSeasonYearID
LEFT JOIN pWorkFlowItem wi ON lfi.StyleBOMWorkflowItemID = wi.WorkFlowItemID
INNER JOIN #tmpLineList tll ON lfi.LineFolderID = tll.LineFolderID
INNER JOIN #tmpDivision td ON div.CustomID = td.DivivsionID
INNER JOIN #tmpStyleCategory tsc ON sh.StyleCategory = tsc.StyleCategoryID
INNER JOIN #tmpSizeClass tscl ON sh.SizeClass = tscl.SizeClass
INNER JOIN #tmpStyleType tst ON sh.StyleType = tst.StyleTypeID
INNER JOIN #tmpStyleTheme tsth ON sh.StyleThemeID = tsth.StyleThemeID
WHERE ch.CalendarHeaderID = @CalendarHeaderID

-- Material Request Approved Status Count --
SELECT	
	  SUM(CASE WHEN mrsw.Status = 3 THEN 1 ELSE 0 END) AS ApprovedStatusCount
	, MAX(mrs.DueDate) AS DueDate
	, mrw.MaterialRequestWorkflowRepID
	, sb.WorkflowItemId
INTO #tmpMaterialRequest
FROM pStyleBOM sb
INNER JOIN pMaterial m ON sb.MaterialID = m.MaterialID
INNER JOIN pMaterialRequestSubmitWorkflow mrsw ON sb.MaterialID = mrsw.MaterialID
LEFT JOIN pMaterialRequestWorkflow mrw ON mrsw.MaterialRequestWorkflowID = mrw.MaterialRequestWorkflowID
INNER JOIN pMaterialRequestSubmit mrs ON mrsw.MaterialRequestSubmitWorkflowID = mrs.MaterialRequestSubmitWorkflowID	
WHERE WorkflowItemId IN (SELECT DISTINCT BOMID FROM #tmpCalStatic)
GROUP BY
	  mrw.MaterialRequestWorkflowRepID
	, sb.WorkflowItemId

-- Material Request Status Count --	
SELECT 
	  SUM(CASE WHEN cmiws.WorkflowStatusID = mrsw.Status THEN 1 ELSE 0 END) AS ApprovedStatusCount
	, MAX(mrs.DueDate) AS DueDate
	, mrw.MaterialRequestWorkflowRepId
	, sb.WorkflowItemId
	, cmi.CalendarMilestoneItemID
	, mrw.MaterialRequestWorkflow
INTO #tmpMilestoneMaterialRequest
FROM (pCalendarMilestoneItemWorkflowStatus cmiws
INNER JOIN pCalendarMilestoneItem cmi ON cmiws.CalendarMilestoneItemID = cmi.CalendarMilestoneItemID)
CROSS JOIN pMaterialRequestSubmitWorkflow mrsw
LEFT JOIN pMaterialRequestWorkflow mrw ON mrsw.MaterialRequestWorkflowID = mrw.MaterialRequestWorkflowID
INNER JOIN pMaterialRequestSubmit mrs ON mrsw.MaterialRequestSubmitWorkflowID = mrs.MaterialRequestSubmitWorkflowID	
INNER JOIN pStyleBOM sb ON mrsw.MaterialID = sb.MaterialID
WHERE cmi.CalendarHeaderID = @CalendarHeaderID
	AND cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000003'
	AND sb.WorkflowItemId IN (SELECT DISTINCT BOMID FROM #tmpCalStatic)
GROUP BY cmi.CalendarMilestoneItemID, mrw.MaterialRequestWorkflowRepId, sb.WorkflowItemId, mrw.MaterialRequestWorkflow
ORDER BY CalendarMilestoneItemID
	
-- Material Workflow Approved Status Count --
SELECT	
	  CASE WHEN COUNT(CASE WHEN RTRIM(LTRIM(m.S)) <> '10' THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsApproved
	, MAX(m.DueDate) AS DueDate
	, mtp.MaterialTemplatePageID
	, sb.WorkflowItemId
INTO #tmpMaterialWorkflow
FROM pStyleBOM sb
INNER JOIN pMaterial m ON sb.MaterialID = m.MaterialID
INNER JOIN pMaterialTemplateItem mti ON m.MaterialTemplateID = mti.MaterialTemplateID
LEFT JOIN pMaterialTemplatePage mtp ON mti.MaterialTemplatePageID = mtp.MaterialTemplatePageID
WHERE WorkflowItemId IN (SELECT DISTINCT BOMID FROM #tmpCalStatic)
GROUP BY
	  mtp.MaterialTemplatePageID
	, sb.WorkflowItemId

-- Material Workflow Status Count --	
SELECT
	  CASE WHEN COUNT(CASE WHEN tmmw.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsApproved
	, MAX (tmmw.DueDate) AS DueDate
	, tmmw.MaterialTemplatePageID
	, tmmw.WorkflowItemId
	, tmmw.CalendarMilestoneItemID
	, tmmw.MaterialTemplatePageName
INTO #tmpMilestoneMaterialWorkflow
FROM (
	SELECT 
		  SUM(CASE WHEN cmiws.WorkflowStatusID = m.S THEN 1 ELSE 0 END) AS ApprovedStatusCount
		, MAX(m.DueDate) AS DueDate
		, m.MaterialID, mti.MaterialTemplatePageID, sb.WorkflowItemId, cmi.CalendarMilestoneItemID, mtp.MaterialTemplatePageName
	FROM pCalendarMilestoneItemWorkflowStatus cmiws
	INNER JOIN pCalendarMilestoneItem cmi ON cmiws.CalendarMilestoneItemID = cmi.CalendarMilestoneItemID
	CROSS JOIN pMaterial m
	INNER JOIN pMaterialTemplateItem mti ON m.MaterialTemplateID = mti.MaterialTemplateID
	LEFT JOIN pMaterialTemplatePage mtp ON mti.MaterialTemplatePageID = mtp.MaterialTemplatePageID
	INNER JOIN pStyleBOM sb ON m.MaterialID = sb.MaterialID
	WHERE cmi.CalendarHeaderID = @CalendarHeaderID
		AND cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000002'
		AND sb.WorkflowItemId IN (SELECT DISTINCT BOMID FROM #tmpCalStatic)
	GROUP BY cmi.CalendarMilestoneItemID, mti.MaterialTemplatePageID, sb.WorkflowItemId, mtp.MaterialTemplatePageName, m.MaterialID
) tmmw
GROUP BY tmmw.MaterialTemplatePageID, tmmw.WorkflowItemId, tmmw.CalendarMilestoneItemID, tmmw.MaterialTemplatePageName

-- Style Workflow Approved Status Count --
SELECT 
	  StyleID
	, WorkflowID
	, MAX(WorkDue) AS DueDate
	, SUM(CASE WHEN sw.WorkStatus = 100 THEN 1 ELSE 0 END) AS ApprovedStatusCount
INTO #tmpStyleWorkflow
FROM pStyleWorkflow sw
WHERE sw.StyleID IN (SELECT DISTINCT StyleID FROM #tmpCalStatic)
GROUP BY
	  StyleID
	, WorkflowID

-- Style Workflow Status Count --
SELECT 
	  sw.StyleID
	, sw.WorkflowID
	, SUM(CASE WHEN cmiws.WorkflowStatusID = sw.WorkStatus THEN 1 ELSE 0 END) AS ApprovedStatusCount
	, MAX(sw.WorkDue) AS DueDate
	, cmi.CalendarMilestoneItemID
INTO #tmpMilestoneStyleWorkflow
FROM pCalendarMilestoneItemWorkflowStatus cmiws
INNER JOIN pCalendarMilestoneItem cmi ON cmiws.CalendarMilestoneItemID = cmi.CalendarMilestoneItemID
CROSS JOIN pStyleWorkflow sw
WHERE cmi.CalendarHeaderID = @CalendarHeaderID
	AND cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000001'
	AND sw.StyleID IN (SELECT DISTINCT StyleID FROM #tmpCalStatic)
GROUP BY cmi.CalendarMilestoneItemID, sw.StyleID, sw.WorkflowID

-- Sample Request Approved Status Count --	
SELECT 
	  srw.StyleID
	, sw.SampleWorkflowRepID
	, MAX(srw.DueDate) AS DueDate
	, SUM(CASE WHEN srw.Status = 3 THEN 1 ELSE 0 END) AS ApprovedStatusCount
INTO #tmpSampleRequest
FROM (
	SELECT StyleID, DueDate, Status, SampleWorkflowID FROM pSampleRequestWorkflow
	UNION
	SELECT StyleID, DueDate, Status, SampleWorkflowID FROM pSampleRequestWorkflowBOM
) srw
LEFT JOIN pSampleWorkflow sw ON srw.SampleWorkflowID = sw.SampleWorkflowID
WHERE srw.StyleID IN (SELECT DISTINCT StyleID FROM #tmpCalStatic)
GROUP BY
	  StyleID
	, sw.SampleWorkflowRepID

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
LEFT JOIN pSampleWorkflow sw ON srw.SampleWorkflowID = sw.SampleWorkflowID
WHERE cmi.CalendarHeaderID = @CalendarHeaderID
	AND cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000004'
	AND srw.StyleID IN (SELECT DISTINCT StyleID FROM #tmpCalStatic)
GROUP BY cmi.CalendarMilestoneItemID, srw.StyleID, sw.SampleWorkflowRepID
	
-- Calendar Milestones - Material Workflow --
SELECT 
	  tcs.*
	, '00000000-0000-0000-0000-000000000000' AS UberGroupID
	, 'Calendar Milestones'	AS UberGroupName
	, 0 AS UberGroupSort
	, cmi.CalendarMilestoneItemID AS GroupID
	, cmi.CalendarMilestoneItemName AS GroupName
	, 0 AS GroupSort
	, cmi.MilestoneDate
	, CASE WHEN COUNT(CASE WHEN tmmw.IsApproved = 0 THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsComplete
	, CASE 
		WHEN COUNT(CASE WHEN tmmw.IsApproved = 0 THEN 1 ELSE NULL END) = 0 THEN 'Complete'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmmw.DueDate)) < 0 THEN CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmmw.DueDate))) AS VARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmmw.DueDate))) AS VARCHAR(5)) + 'd Remain'
	  END AS DaysMessage
	, NULL AS DueDate
	, CASE 
		WHEN COUNT(CASE WHEN tmmw.IsApproved = 0 THEN 1 ELSE NULL END) = 0 THEN 'LightGreen'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmmw.DueDate)) < 0 THEN 'IndianRed'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmmw.DueDate)) BETWEEN 0 AND 7 THEN 'Khaki'		
		ELSE 'None'
	  END AS Color
FROM #tmpCalStatic tcs
CROSS JOIN pCalendarMilestoneItem cmi
INNER JOIN pCalendarMilestoneItemWorkflow cmiw ON cmi.CalendarMilestoneItemID = cmiw.CalendarMilestoneItemID
INNER JOIN #tmpMilestoneMaterialWorkflow tmmw ON cmiw.WorkflowID = tmmw.MaterialTemplatePageID 
	AND tcs.BOMID = tmmw.WorkflowItemId 
	AND cmi.CalendarMilestoneItemID = tmmw.CalendarMilestoneItemID
WHERE cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000002' AND cmi.CalendarHeaderID = @CalendarHeaderID
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
	, tcs.BOMID
	, tcs.BOMName
	, cmi.CalendarMilestoneItemID
	, cmi.CalendarMilestoneItemName
	, cmi.MilestoneDate
UNION
-- Calendar Milestones - Material Request --
SELECT 
	  tcs.*
	, '00000000-0000-0000-0000-000000000000' AS UberGroupID
	, 'Calendar Milestones'	AS UberGroupName
	, 0 AS UberGroupSort
	, cmi.CalendarMilestoneItemID AS GroupID
	, cmi.CalendarMilestoneItemName AS GroupName
	, 1 AS GroupSort
	, cmi.MilestoneDate
	, CASE WHEN COUNT(CASE WHEN tmmr.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsComplete
	, CASE 
		WHEN COUNT(CASE WHEN tmmr.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 'Complete'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmmr.DueDate)) < 0 THEN CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmmr.DueDate))) AS VARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmmr.DueDate))) AS VARCHAR(5)) + 'd Remain'
	  END AS DaysMessage
	, NULL AS DueDate
	, CASE 
		WHEN COUNT(CASE WHEN tmmr.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 'LightGreen'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmmr.DueDate)) < 0 THEN 'IndianRed'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmmr.DueDate)) BETWEEN 0 AND 7 THEN 'Khaki'		
		ELSE 'None'
	  END AS Color
FROM #tmpCalStatic tcs
CROSS JOIN pCalendarMilestoneItem cmi
INNER JOIN pCalendarMilestoneItemWorkflow cmiw ON cmi.CalendarMilestoneItemID = cmiw.CalendarMilestoneItemID
INNER JOIN #tmpMilestoneMaterialRequest tmmr ON cmiw.WorkflowID = tmmr.MaterialRequestWorkflowRepId 
	AND tcs.BOMID = tmmr.WorkflowItemId 
	AND cmi.CalendarMilestoneItemID = tmmr.CalendarMilestoneItemID
WHERE cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000003' AND cmi.CalendarHeaderID = @CalendarHeaderID
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
	, tcs.BOMID
	, tcs.BOMName
	, cmi.CalendarMilestoneItemID
	, cmi.CalendarMilestoneItemName
	, cmi.MilestoneDate

UNION 
-- Calendar Milestones - Style Workows -- 
SELECT 
	  tcs.*
	, '00000000-0000-0000-0000-000000000000' AS UberGroupID
	, 'Calendar Milestones'	AS UberGroupName
	, 0 AS UberGroupSort
	, cmi.CalendarMilestoneItemID AS GroupID
	, cmi.CalendarMilestoneItemName AS GroupName
	, 2 AS GroupSort
	, cmi.MilestoneDate
	, CASE WHEN COUNT(CASE WHEN tmsw.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsComplete
	, CASE 
		WHEN COUNT(CASE WHEN tmsw.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 'Complete'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmsw.DueDate)) < 0 THEN CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmsw.DueDate))) AS VARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmsw.DueDate))) AS VARCHAR(5)) + 'd Remain'
	  END AS DaysMessage
	, NULL AS DueDate
	, CASE 
		WHEN COUNT(CASE WHEN tmsw.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 'LightGreen'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmsw.DueDate)) < 0 THEN 'IndianRed'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmsw.DueDate)) BETWEEN 0 AND 7 THEN 'Khaki'		
		ELSE 'None'
	  END AS Color
FROM #tmpCalStatic tcs
CROSS JOIN pCalendarMilestoneItem cmi
INNER JOIN pCalendarMilestoneItemWorkflow cmiw ON cmi.CalendarMilestoneItemID = cmiw.CalendarMilestoneItemID
INNER JOIN #tmpMilestoneStyleWorkflow tmsw ON cmiw.WorkflowID = tmsw.WorkflowID AND tcs.StyleID = tmsw.StyleID AND cmi.CalendarMilestoneItemID = tmsw.CalendarMilestoneItemID
WHERE cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000001' AND cmi.CalendarHeaderID = @CalendarHeaderID
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
	, tcs.BOMID
	, tcs.BOMName
	, cmi.CalendarMilestoneItemID
	, cmi.CalendarMilestoneItemName
	, cmi.MilestoneDate
	
UNION
-- Calendar Milestones - Sample Requests -- 
SELECT 
	  tcs.*
	, '00000000-0000-0000-0000-000000000000' AS UberGroupID
	, 'Calendar Milestones'	AS UberGroupName
	, 0 AS UberGroupSort
	, cmi.CalendarMilestoneItemID AS GroupID
	, cmi.CalendarMilestoneItemName AS GroupName
	, 3 AS GroupSort
	, cmi.MilestoneDate
	, CASE WHEN COUNT(CASE WHEN tmsr.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsComplete
	, CASE 
		WHEN COUNT(CASE WHEN tmsr.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 'Complete'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmsr.DueDate)) < 0 THEN CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmsr.DueDate))) AS VARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmsr.DueDate))) AS VARCHAR(5)) + 'd Remain'
	  END AS DaysMessage
	, NULL AS DueDate
	, CASE 
		WHEN COUNT(CASE WHEN tmsr.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 'LightGreen'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmsr.DueDate)) < 0 THEN 'IndianRed'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmsr.DueDate)) BETWEEN 0 AND 7 THEN 'Khaki'		
		ELSE 'None'
	  END AS Color
FROM #tmpCalStatic tcs
CROSS JOIN pCalendarMilestoneItem cmi
INNER JOIN pCalendarMilestoneItemWorkflow cmiw ON cmi.CalendarMilestoneItemID = cmiw.CalendarMilestoneItemID
INNER JOIN #tmpMilistoneSampleRequest tmsr ON cmiw.WorkflowID = tmsr.SampleWorkflowRepId
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
	, tcs.BOMID
	, tcs.BOMName
	, cmi.CalendarMilestoneItemID
	, cmi.CalendarMilestoneItemName
	, cmi.MilestoneDate
UNION
-- Material Workflow --
SELECT 
	  tcs.*
	, '00000000-0000-0000-0000-000000000002' AS UberGroupID
	, (SELECT WorkflowTypeName FROM pWorkflowType WHERE WorkflowTypeID = '00000000-0000-0000-0000-000000000002') AS UberGroupName
	, 2 AS UberGroupSort
	, cmiw.WorkflowID AS GroupID
	, mtp.MaterialTemplatePageName AS GroupName
	, mtp.Sort AS GroupSort
	, NULL AS MilestoneDate
	, CASE WHEN COUNT(CASE WHEN tmw.IsApproved = 0 THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsComplete
	, CASE 
		WHEN COUNT(CASE WHEN tmw.IsApproved = 0 THEN 1 ELSE NULL END) = 0 THEN 'Approved'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmw.DueDate)) < 0 THEN CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmw.DueDate))) AS VARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmw.DueDate))) AS VARCHAR(5)) + 'd Remain'
	  END AS DaysMessage
	, MAX(tmw.DueDate) AS DueDate
	, CASE 
		WHEN COUNT(CASE WHEN tmw.IsApproved = 0 THEN 1 ELSE NULL END) = 0 THEN 'LightGreen'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmw.DueDate)) < 0 THEN 'IndianRed'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmw.DueDate)) BETWEEN 0 AND 7 THEN 'Khaki'		
		ELSE 'None'
	  END AS Color
FROM #tmpCalStatic tcs
CROSS JOIN pCalendarMilestoneItem cmi
INNER JOIN pCalendarMilestoneItemWorkflow cmiw ON cmi.CalendarMilestoneItemID = cmiw.CalendarMilestoneItemID
LEFT JOIN pMaterialTemplatePage mtp ON cmiw.WorkflowID = mtp.MaterialTemplatePageID
INNER JOIN #tmpMaterialWorkflow tmw ON cmiw.WorkflowID = tmw.MaterialTemplatePageID AND tcs.BOMID = tmw.WorkflowItemId
WHERE cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000002' AND cmi.CalendarHeaderID = @CalendarHeaderID
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
	, tcs.BOMID
	, tcs.BOMName
	, cmiw.WorkflowID
	, mtp.MaterialTemplatePageName
	, cmi.MilestoneDate
	, mtp.Sort
UNION
-- Material Requests --
SELECT 
	  tcs.*
	, '00000000-0000-0000-0000-000000000003' AS UberGroupID
	, (SELECT WorkflowTypeName FROM pWorkflowType WHERE WorkflowTypeID = '00000000-0000-0000-0000-000000000003') AS UberGroupName
	, 2 AS UberGroupSort
	, cmiw.WorkflowID AS GroupID
	, mrw.MaterialRequestWorkflow AS GroupName
	, mrw.MaterialRequestWorkflowSort AS GroupSort
	, NULL AS MilestoneDate
	, CASE WHEN COUNT(CASE WHEN tmr.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsComplete
	, CASE 
		WHEN COUNT(CASE WHEN tmr.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 'Approved'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmr.DueDate)) < 0 THEN CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmr.DueDate))) AS VARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmr.DueDate))) AS VARCHAR(5)) + 'd Remain'
	  END AS DaysMessage
	, MAX(tmr.DueDate) AS DueDate
	, CASE 
		WHEN COUNT(CASE WHEN tmr.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 'LightGreen'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmr.DueDate)) < 0 THEN 'IndianRed'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tmr.DueDate)) BETWEEN 0 AND 7 THEN 'Khaki'		
		ELSE 'None'
	  END AS Color
FROM #tmpCalStatic tcs
CROSS JOIN pCalendarMilestoneItem cmi
INNER JOIN pCalendarMilestoneItemWorkflow cmiw ON cmi.CalendarMilestoneItemID = cmiw.CalendarMilestoneItemID
LEFT JOIN pMaterialRequestWorkflow mrw ON cmiw.WorkflowID = mrw.MaterialRequestWorkflowRepId
INNER JOIN #tmpMaterialRequest tmr ON cmiw.WorkflowID = tmr.MaterialRequestWorkflowRepId AND tcs.BOMID = tmr.WorkflowItemId
WHERE cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000003' AND cmi.CalendarHeaderID = @CalendarHeaderID
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
	, tcs.BOMID
	, tcs.BOMName
	, cmiw.WorkflowID
	, mrw.MaterialRequestWorkflow
	, cmi.MilestoneDate
	, mrw.MaterialRequestWorkflowSort
UNION
-- Style Workows --
SELECT 
	  tcs.*
	, '00000000-0000-0000-0000-000000000001' AS UberGroupID
	, (SELECT WorkflowTypeName FROM pWorkflowType WHERE WorkflowTypeID = '00000000-0000-0000-0000-000000000001')	AS UberGroupName
	, 3 AS UberGroupSort
	, cmiw.WorkflowID AS GroupID
	, w.Workflow AS GroupName
	, w.WorkflowSort AS GroupSort
	, NULL AS MilestoneDate
	, CASE WHEN COUNT(CASE WHEN tsw.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsComplete
	, CASE 
		WHEN COUNT(CASE WHEN tsw.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 'Approved'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tsw.DueDate)) < 0 THEN CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tsw.DueDate))) AS VARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tsw.DueDate))) AS VARCHAR(5)) + 'd Remain'
	  END AS DaysMessage
	, MAX(tsw.DueDate) AS DueDate
	, CASE 
		WHEN COUNT(CASE WHEN tsw.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 'LightGreen'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tsw.DueDate)) < 0 THEN 'IndianRed'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tsw.DueDate)) BETWEEN 0 AND 7 THEN 'Khaki'		
		ELSE 'None'
	  END AS Color
FROM #tmpCalStatic tcs
CROSS JOIN pCalendarMilestoneItem cmi
INNER JOIN pCalendarMilestoneItemWorkflow cmiw ON cmi.CalendarMilestoneItemID = cmiw.CalendarMilestoneItemID
LEFT JOIN pWorkflow w ON cmiw.WorkflowID = w.WorkflowID
INNER JOIN #tmpStyleWorkflow tsw ON cmiw.WorkflowID = tsw.WorkflowID AND tcs.StyleID = tsw.StyleID
WHERE cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000001' AND cmi.CalendarHeaderID = @CalendarHeaderID
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
	, tcs.BOMID
	, tcs.BOMName
	, cmiw.WorkflowID
	, w.Workflow
	, cmi.MilestoneDate
	, w.WorkflowSort
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
	, NULL AS MilestoneDate
	, CASE WHEN COUNT(CASE WHEN tsw.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsComplete
	, CASE 
		WHEN COUNT(CASE WHEN tsw.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 'Approved'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tsw.DueDate)) < 0 THEN CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tsw.DueDate))) AS VARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(DAY, cmi.MilestoneDate, MAX(tsw.DueDate))) AS VARCHAR(5)) + 'd Remain'
	  END AS DaysMessage
	, MAX(tsw.DueDate) AS DueDate
	, CASE 
		WHEN COUNT(CASE WHEN tsw.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 'LightGreen'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tsw.DueDate)) < 0 THEN 'IndianRed'
		WHEN DATEDIFF(DAY, cmi.MilestoneDate, MAX(tsw.DueDate)) BETWEEN 0 AND 7 THEN 'Khaki'		
		ELSE 'None'
	  END AS Color
FROM #tmpCalStatic tcs
CROSS JOIN pCalendarMilestoneItem cmi
INNER JOIN pCalendarMilestoneItemWorkflow cmiw ON cmi.CalendarMilestoneItemID = cmiw.CalendarMilestoneItemID
LEFT JOIN pSampleWorkflow sw ON cmiw.WorkflowID = sw.SampleWorkflowRepId
INNER JOIN #tmpSampleRequest tsw ON cmiw.WorkflowID = tsw.SampleWorkflowRepId AND tcs.StyleID = tsw.StyleID
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
	, tcs.BOMID
	, tcs.BOMName
	, cmiw.WorkflowID
	, sw.SampleWorkflow
	, cmi.MilestoneDate
	, sw.SampleWorkflowSort

DROP TABLE #tmpCalStatic
DROP TABLE #tmpMaterialRequest
DROP TABLE #tmpStyleWorkflow
DROP TABLE #tmpSampleRequest
DROP TABLE #tmpStyleType
DROP TABLE #tmpStyleCategory

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05499', GetDate())
GO
