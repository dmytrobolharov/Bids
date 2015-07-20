IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_CalendarMilestoneMaterial_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_CalendarMilestoneMaterial_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_CalendarMilestoneMaterial_SELECT](
	@CalendarHeaderID UNIQUEIDENTIFIER
	, @BOMID UNIQUEIDENTIFIER
) AS

DECLARE @SeasonYearID UNIQUEIDENTIFIER = (SELECT SeasonYearID FROM pCalendarHeader WHERE CalendarHeaderID = @CalendarHeaderID)

SELECT
	  m.MaterialNo
	, m.MaterialName	
	, ct.ComponentDescription
	, m.B AS Content
	, CASE WHEN m.Active = 1 THEN 'Yes' ELSE 'No' END AS Active
	, c8.Custom	
	, m.MaterialID
	, m.DueDate AS StaticDueDate
	, m.S
	, m.MaterialTemplateID
INTO #tmpMatStatic
FROM pStyleBOM sb
INNER JOIN pMaterial m ON sb.MaterialID = m.MaterialID
LEFT JOIN pComponentType ct ON m.MaterialType = ct.ComponentTypeID
LEFT JOIN xCustom8 c8 ON m.S = c8.CustomKey
WHERE sb.WorkflowItemId = @BOMID

-- Material Workflow Approved Status Count --
SELECT	
	  CASE WHEN RTRIM(LTRIM(tms.S)) <> '10' THEN 0 ELSE 1 END AS IsApproved
	, tms.StaticDueDate
	, mtp.MaterialTemplatePageID
	, MaterialID
	, mtp.MaterialTemplatePageName
	, mtp.Sort
INTO #tmpMaterialWorkflow
FROM #tmpMatStatic tms
INNER JOIN pMaterialTemplateItem mti ON tms.MaterialTemplateID = mti.MaterialTemplateID
LEFT JOIN pMaterialTemplatePage mtp ON mti.MaterialTemplatePageID = mtp.MaterialTemplatePageID	

-- Material Workflow Status Count --	
SELECT 
	  CASE WHEN COUNT(CASE WHEN cmiws.WorkflowStatusID = tms.S THEN NULL ELSE 1 END) = 0 THEN 1 ELSE 0 END AS IsApproved
	, MAX (tms.StaticDueDate) AS DueDate
	, tms.MaterialID, cmi.CalendarMilestoneItemID, cmi.CalendarMilestoneItemName, cmi.MilestoneDate
INTO #tmpMilestoneMaterialWorkflow 
FROM pCalendarMilestoneItemWorkflowStatus cmiws
INNER JOIN pCalendarMilestoneItem cmi ON cmiws.CalendarMilestoneItemID = cmi.CalendarMilestoneItemID
CROSS JOIN #tmpMatStatic tms
LEFT JOIN pMaterialTemplateItem mti ON tms.MaterialTemplateID = mti.MaterialTemplateID
LEFT JOIN pMaterialTemplatePage mtp ON mti.MaterialTemplatePageID = mtp.MaterialTemplatePageID	
WHERE cmi.CalendarHeaderID = @CalendarHeaderID
	AND cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000002'		
GROUP BY cmi.CalendarMilestoneItemID, tms.MaterialID, cmi.CalendarMilestoneItemName, cmi.MilestoneDate
	
-- Material Request Approved Status Count --
SELECT	
	  CASE WHEN mrsw.Status = 3 THEN 1 ELSE 0 END AS IsApproved
	, mrs.DueDate
	, mrw.MaterialRequestWorkflowRepID
	, mrw.MaterialRequestWorkflow
	, mrw.MaterialRequestWorkflowSort
	, tms.MaterialID	
	, tprl.AgentName
	, tprl.VendorName
	, tprl.FactoryName	
	, mrs.MaterialTradePartnerColorID
	, mtp.TradePartnerRelationshipLevelID
INTO #tmpMaterialRequest
FROM #tmpMatStatic tms
INNER JOIN pMaterialRequestSubmitWorkflow mrsw ON tms.MaterialID = mrsw.MaterialID
LEFT JOIN pMaterialRequestWorkflow mrw ON mrsw.MaterialRequestWorkflowID = mrw.MaterialRequestWorkflowID
INNER JOIN pMaterialRequestSubmit mrs ON mrsw.MaterialRequestSubmitWorkflowID = mrs.MaterialRequestSubmitWorkflowID	
LEFT JOIN pMaterialTradePartner mtp ON mrsw.MaterialTradePartnerID = mtp.MaterialTradePartnerId
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON mtp.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
WHERE mtp.SeasonYearID = @SeasonYearID AND mrsw.MaterialRequestSubmitAllColors = 0
INSERT INTO #tmpMaterialRequest(IsApproved
	, DueDate
	, MaterialRequestWorkflowRepID
	, mrw.MaterialRequestWorkflow
	, mrw.MaterialRequestWorkflowSort
	, MaterialID	
	, AgentName
	, VendorName
	, FactoryName	
	, TradePartnerRelationshipLevelID
	, MaterialTradePartnerColorID)
SELECT	
	  CASE WHEN mrsw.Status = 3 THEN 1 ELSE 0 END AS IsApproved
	, mrs.DueDate
	, mrw.MaterialRequestWorkflowRepID
	, mrw.MaterialRequestWorkflow
	, mrw.MaterialRequestWorkflowSort
	, tms.MaterialID	
	, tprl.AgentName
	, tprl.VendorName
	, tprl.FactoryName	
	, mtp.TradePartnerRelationshipLevelID
	, tmr.MaterialTradePartnerColorID
FROM #tmpMatStatic tms
INNER JOIN pMaterialRequestSubmitWorkflow mrsw ON tms.MaterialID = mrsw.MaterialID
LEFT JOIN pMaterialRequestWorkflow mrw ON mrsw.MaterialRequestWorkflowID = mrw.MaterialRequestWorkflowID
INNER JOIN pMaterialRequestSubmit mrs ON mrsw.MaterialRequestSubmitWorkflowID = mrs.MaterialRequestSubmitWorkflowID	
LEFT JOIN pMaterialTradePartner mtp ON mrsw.MaterialTradePartnerID = mtp.MaterialTradePartnerId
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON mtp.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
INNER JOIN (
	SELECT DISTINCT tmr.MaterialTradePartnerColorID, tmr.TradePartnerRelationshipLevelID FROM #tmpMaterialRequest tmr
) tmr ON mtp.TradePartnerRelationshipLevelID = tmr.TradePartnerRelationshipLevelID
WHERE mtp.SeasonYearID = @SeasonYearID AND mrsw.MaterialRequestSubmitAllColors = 1

-- Material Request Status Count --	
SELECT
	  CASE WHEN COUNT(CASE WHEN tmr.ApprovedStatusCount = 0 THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsApproved
	, MAX (tmr.DueDate) AS DueDate
	, tmr.MaterialID, tmr.CalendarMilestoneItemID, tmr.CalendarMilestoneItemName, tmr.MilestoneDate
INTO #tmpMilestoneMaterialRequest
FROM (
	SELECT
		  SUM(CASE WHEN mrsw.Status = cmiws.WorkflowStatusID THEN 1 ELSE 0 END) AS ApprovedStatusCount
		, MAX(mrs.DueDate) AS DueDate
		, mrw.MaterialRequestWorkflowRepID
		, tms.MaterialID	
		, cmi.CalendarMilestoneItemID
		, cmi.CalendarMilestoneItemName
		, cmi.MilestoneDate
	FROM pCalendarMilestoneItemWorkflowStatus cmiws
	INNER JOIN pCalendarMilestoneItem cmi ON cmiws.CalendarMilestoneItemID = cmi.CalendarMilestoneItemID
	CROSS JOIN #tmpMatStatic tms
	INNER JOIN pMaterialRequestSubmitWorkflow mrsw ON tms.MaterialID = mrsw.MaterialID
	LEFT JOIN pMaterialRequestWorkflow mrw ON mrsw.MaterialRequestWorkflowID = mrw.MaterialRequestWorkflowID
	INNER JOIN pMaterialRequestSubmit mrs ON mrsw.MaterialRequestSubmitWorkflowID = mrs.MaterialRequestSubmitWorkflowID	
	LEFT JOIN pMaterialTradePartner mtp ON mrsw.MaterialTradePartnerID = mtp.MaterialTradePartnerId
	WHERE mtp.SeasonYearID = @SeasonYearID
		AND cmi.CalendarHeaderID = @CalendarHeaderID
		AND cmi.DependentWorkflowTypeID = '00000000-0000-0000-0000-000000000003'
	GROUP BY mrw.MaterialRequestWorkflowRepID, tms.MaterialID, cmi.CalendarMilestoneItemID, cmi.CalendarMilestoneItemName, cmi.MilestoneDate) tmr
GROUP BY tmr.MaterialID, tmr.CalendarMilestoneItemID, tmr.CalendarMilestoneItemName, tmr.MilestoneDate

-- Calendar Milestones - Material Workflow --
SELECT 
	  tms.MaterialID
	, tms.MaterialNo
	, tms.MaterialName
	, tms.ComponentDescription
	, tms.Content
	, tms.Active
	, tms.Custom
	, NULL AS AgentName
	, NULL AS VendorName
	, NULL AS FactoryName
	, NULL AS MaterialTradePartnerColorID
	, NULL AS TradePartnerRelationshipLevelID
	, '00000000-0000-0000-0000-000000000000' AS UberGroupID
	, 'Calendar Milestones'	AS UberGroupName
	, 0 AS UberGroupSort
	, tmmw.CalendarMilestoneItemID AS GroupID
	, tmmw.CalendarMilestoneItemName AS GroupName
	, 0 AS GroupSort
	, tmmw.MilestoneDate
	, CASE WHEN COUNT(CASE WHEN tmmw.IsApproved = 0 OR tmmw.IsApproved IS NULL THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsComplete
	, CASE 
		WHEN COUNT(CASE WHEN tmmw.IsApproved = 0 OR tmmw.IsApproved IS NULL THEN 1 ELSE NULL END) = 0 THEN 'Complete'
		WHEN DATEDIFF(DAY, GETDATE(), tmmw.MilestoneDate) < 0 THEN CAST(ABS(DATEDIFF(DAY, GETDATE(), tmmw.MilestoneDate)) AS VARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(DAY, GETDATE(), tmmw.MilestoneDate)) AS VARCHAR(5)) + 'd Remain'
	  END AS DaysMessage
	, NULL AS DueDate
	, CASE 
		WHEN COUNT(CASE WHEN tmmw.IsApproved = 0 OR tmmw.IsApproved IS NULL THEN 1 ELSE NULL END) = 0 THEN 'LightGreen'
		WHEN DATEDIFF(DAY, GETDATE(), tmmw.MilestoneDate) < 0 THEN 'IndianRed'
		WHEN DATEDIFF(DAY, GETDATE(), tmmw.MilestoneDate) BETWEEN 0 AND 7 THEN 'Khaki'		
		ELSE 'None'
	  END AS Color
FROM #tmpMatStatic tms
LEFT JOIN #tmpMilestoneMaterialWorkflow tmmw ON tms.MaterialID = tmmw.MaterialID
GROUP BY
	  tms.MaterialID
	, tms.MaterialNo
	, tms.MaterialName
	, tms.ComponentDescription
	, tms.Content
	, tms.Active
	, tms.Custom
	, tmmw.CalendarMilestoneItemID
	, tmmw.CalendarMilestoneItemName
	, tmmw.MilestoneDate
UNION
-- Calendar Milestones - Material Request --
SELECT 
 	  tms.MaterialID
	, tms.MaterialNo
	, tms.MaterialName
	, tms.ComponentDescription
	, tms.Content
	, tms.Active
	, tms.Custom
	, NULL AS AgentName
	, NULL AS VendorName
	, NULL AS FactoryName
	, NULL AS MaterialTradePartnerColorID
	, NULL AS TradePartnerRelationshipLevelID
	, '00000000-0000-0000-0000-000000000000' AS UberGroupID
	, 'Calendar Milestones'	AS UberGroupName
	, 0 AS UberGroupSort
	, tmmr.CalendarMilestoneItemID AS GroupID
	, tmmr.CalendarMilestoneItemName AS GroupName
	, 1 AS GroupSort
	, tmmr.MilestoneDate
	, CASE WHEN COUNT(CASE WHEN tmmr.IsApproved = 0 OR tmmr.IsApproved IS NULL THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsComplete
	, CASE 
		WHEN COUNT(CASE WHEN tmmr.IsApproved = 0 OR tmmr.IsApproved IS NULL THEN 1 ELSE NULL END) = 0 THEN 'Complete'
		WHEN DATEDIFF(DAY, GETDATE(), tmmr.MilestoneDate) < 0 THEN CAST(ABS(DATEDIFF(DAY, GETDATE(), tmmr.MilestoneDate)) AS VARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(DAY, GETDATE(), tmmr.MilestoneDate)) AS VARCHAR(5)) + 'd Remain'
	  END AS DaysMessage
	, NULL AS DueDate
	, CASE 
		WHEN COUNT(CASE WHEN tmmr.IsApproved = 0 OR tmmr.IsApproved IS NULL THEN 1 ELSE NULL END) = 0 THEN 'LightGreen'
		WHEN DATEDIFF(DAY, GETDATE(), tmmr.MilestoneDate) < 0 THEN 'IndianRed'
		WHEN DATEDIFF(DAY, GETDATE(), tmmr.MilestoneDate) BETWEEN 0 AND 7 THEN 'Khaki'		
		ELSE 'None'
	  END AS Color
FROM #tmpMatStatic tms
INNER JOIN #tmpMilestoneMaterialRequest tmmr ON tms.MaterialID = tmmr.MaterialID
GROUP BY
	  tms.MaterialID
	, tms.MaterialNo
	, tms.MaterialName
	, tms.ComponentDescription
	, tms.Content
	, tms.Active
	, tms.Custom
	, tmmr.CalendarMilestoneItemID
	, tmmr.CalendarMilestoneItemName
	, tmmr.MilestoneDate
UNION
-- Material Workflow --
SELECT 
	  tms.MaterialID
	, tms.MaterialNo
	, tms.MaterialName
	, tms.ComponentDescription
	, tms.Content
	, tms.Active
	, tms.Custom	
	, NULL AS AgentName
	, NULL AS VendorName
	, NULL AS FactoryName
	, NULL AS MaterialTradePartnerColorID
	, NULL AS TradePartnerRelationshipLevelID
	, '00000000-0000-0000-0000-000000000002' AS UberGroupID
	, (SELECT WorkflowTypeName FROM pWorkflowType WHERE WorkflowTypeID = '00000000-0000-0000-0000-000000000002') AS UberGroupName
	, 2 AS UberGroupSort
	, tmw.MaterialTemplatePageID AS GroupID
	, tmw.MaterialTemplatePageName AS GroupName
	, tmw.Sort AS GroupSort
	, NULL AS MilestoneDate
	, CASE WHEN COUNT(CASE WHEN tmw.IsApproved = 0 OR tmw.IsApproved IS NULL THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsComplete
	, CASE 
		WHEN COUNT(CASE WHEN tmw.IsApproved = 0 OR tmw.IsApproved IS NULL THEN 1 ELSE NULL END) = 0 THEN 'Approved'
		WHEN DATEDIFF(DAY, GETDATE(), MAX(tmw.StaticDueDate)) < 0 THEN CAST(ABS(DATEDIFF(DAY, GETDATE(), MAX(tmw.StaticDueDate))) AS VARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(DAY, GETDATE(), MAX(tmw.StaticDueDate))) AS VARCHAR(5)) + 'd Remain'
	  END AS DaysMessage
	, MAX(tmw.StaticDueDate) AS DueDate
	, CASE 
		WHEN COUNT(CASE WHEN tmw.IsApproved = 0 OR tmw.IsApproved IS NULL THEN 1 ELSE NULL END) = 0 THEN 'LightGreen'
		WHEN DATEDIFF(DAY, GETDATE(), MAX(tmw.StaticDueDate)) < 0 THEN 'IndianRed'
		WHEN DATEDIFF(DAY, GETDATE(), MAX(tmw.StaticDueDate)) BETWEEN 0 AND 7 THEN 'Khaki'		
		ELSE 'None'
	  END AS Color
FROM #tmpMatStatic tms
INNER JOIN #tmpMaterialWorkflow tmw ON tms.MaterialID = tmw.MaterialID
GROUP BY
	  tms.MaterialID
	, tms.MaterialNo
	, tms.MaterialName
	, tms.ComponentDescription
	, tms.Content
	, tms.Active
	, tms.Custom
	, tmw.StaticDueDate
	, tmw.IsApproved
	, tmw.MaterialTemplatePageID
	, tmw.MaterialTemplatePageName
	, tmw.Sort
UNION
-- Material Requests --
SELECT 
	  tms.MaterialID
	, tms.MaterialNo
	, tms.MaterialName
	, tms.ComponentDescription
	, tms.Content
	, tms.Active
	, tms.Custom
	, tmr.AgentName
	, tmr.VendorName
	, tmr.FactoryName
	, tmr.MaterialTradePartnerColorID
	, tmr.TradePartnerRelationshipLevelID
	, '00000000-0000-0000-0000-000000000003' AS UberGroupID
	, (SELECT WorkflowTypeName FROM pWorkflowType WHERE WorkflowTypeID = '00000000-0000-0000-0000-000000000003') AS UberGroupName
	, 2 AS UberGroupSort
	, tmr.MaterialRequestWorkflowRepId AS GroupID
	, tmr.MaterialRequestWorkflow AS GroupName
	, tmr.MaterialRequestWorkflowSort AS GroupSort
	, NULL AS MilestoneDate
	, CASE WHEN COUNT(CASE WHEN tmr.IsApproved = 0 OR tmr.IsApproved IS NULL THEN 1 ELSE NULL END) = 0 THEN 1 ELSE 0 END AS IsComplete
	, CASE 
		WHEN COUNT(CASE WHEN tmr.IsApproved = 0 OR tmr.IsApproved IS NULL THEN 1 ELSE NULL END) = 0 THEN 'Approved'
		WHEN DATEDIFF(DAY, GETDATE(), MAX(tmr.DueDate)) < 0 THEN CAST(ABS(DATEDIFF(DAY, GETDATE(), MAX(tmr.DueDate))) AS VARCHAR(5)) + 'd Late'
		ELSE CAST(ABS(DATEDIFF(DAY, GETDATE(), MAX(tmr.DueDate))) AS VARCHAR(5)) + 'd Remain'
	  END AS DaysMessage
	, MAX(tmr.DueDate) AS DueDate
	, CASE 
		WHEN COUNT(CASE WHEN tmr.IsApproved = 0 OR tmr.IsApproved IS NULL THEN 1 ELSE NULL END) = 0 THEN 'LightGreen'
		WHEN DATEDIFF(DAY, GETDATE(), MAX(tmr.DueDate)) < 0 THEN 'IndianRed'
		WHEN DATEDIFF(DAY, GETDATE(), MAX(tmr.DueDate)) BETWEEN 0 AND 7 THEN 'Khaki'		
		ELSE 'None'
	  END AS Color
FROM #tmpMatStatic tms
INNER JOIN #tmpMaterialRequest tmr ON tms.MaterialID = tmr.MaterialID
GROUP BY
	  tms.MaterialID
	, tms.MaterialNo
	, tms.MaterialName
	, tms.ComponentDescription
	, tms.Content
	, tms.Active
	, tms.Custom
	, tmr.AgentName
	, tmr.VendorName
	, tmr.FactoryName
	, tmr.MaterialRequestWorkflowRepId
	, tmr.MaterialRequestWorkflow
	, tmr.MaterialRequestWorkflowSort
	, tmr.MaterialTradePartnerColorID
	, tmr.TradePartnerRelationshipLevelID



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05546', GetDate())
GO
