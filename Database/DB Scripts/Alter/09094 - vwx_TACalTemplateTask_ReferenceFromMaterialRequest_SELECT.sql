IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromMaterialRequest_SELECT]') AND type = N'V')
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromMaterialRequest_SELECT]
GO

CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromMaterialRequest_SELECT]
AS
SELECT *
	, CASE 
		WHEN ActualEnd IS NULL
			THEN 0
		ELSE 1
		END AS Ended
	, CASE 
		WHEN ActualEnd IS NOT NULL
			THEN CASE 
					WHEN (CAST(ActualEnd AS DATE) > CAST(TaskPlanEnd AS DATE))
						OR (CAST(ActualEnd AS DATE) > CAST(TaskRevisedEnd AS DATE))
						THEN 1
					ELSE 0
					END
		ELSE CASE 
				WHEN TaskRevisedEnd IS NULL
					THEN CASE 
							WHEN CAST(CURRENT_TIMESTAMP AS DATE) > CAST(TaskPlanEnd AS DATE)
								THEN 1
							ELSE 0
							END
				ELSE CASE 
						WHEN CAST(TaskPlanEnd AS DATE) >= CAST(TaskRevisedEnd AS DATE)
							THEN CASE 
									WHEN CAST(CURRENT_TIMESTAMP AS DATE) > CAST(TaskPlanEnd AS DATE)
										OR CAST(CURRENT_TIMESTAMP AS DATE) > CAST(TaskRevisedEnd AS DATE)
										THEN 1
									ELSE 0
									END
						ELSE 1
						END
				END
		END AS Late
	, dbo.fnx_TACal_HighlightColor(ActualEnd, TaskRevisedEnd, TaskPlanEnd) AS HighlightColor
FROM (
	SELECT crt.TACalRefTaskId
		, 'Material Request' AS RefType
		, pm.MaterialID
		, tw.WorkflowId
		, ct.SeasonYearId
		, pm.MaterialNo
		, pm.MaterialName
		, pm.MaterialType
		, mtp.MaterialTradePartnerID
		, CASE 
			WHEN MAX(CASE 
						WHEN mrsw.StartDate IS NULL
							THEN 1
						ELSE 0
						END) = 0
				THEN MAX(mrsw.StartDate)
			END AS ActualStart
		, CASE 
			WHEN MAX(CASE 
						WHEN mrsw.EndDate IS NULL
							THEN 1
						ELSE 0
						END) = 0
				THEN MAX(mrsw.EndDate)
			END AS ActualEnd
		, crt.TaskRevisedlStart
		, crt.TaskRevisedEnd
		, crt.TACalTemplateTaskId
		, ctt.TaskPlanStart
		, ctt.TaskPlanEnd
		, tpm.AgentID
		, tpm.AgentName
		, tpm.VendorID
		, tpm.VendorName
		, tpm.FactoryID
		, tpm.FactoryName
		, tw.WorkflowName
		, tw.WorkflowFolder
		, ctt.TaskTypeId
		, ct.TACalTemplateId
		, mrsw.AssignedTo AS WorkAssignedTo
		, mrsw.Status AS WorkStatus
		, tpm.TradePartnerFullName
	FROM pTACalReferenceTask crt
	INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
	INNER JOIN pMaterialTradePartner mtp ON mtp.MaterialTradePartnerId = cr.ReferenceId
	INNER JOIN pMaterial pm ON pm.MaterialID = mtp.MaterialId
	INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
	INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
	INNER JOIN pMaterialRequestWorkflow mrw ON mrw.MaterialRequestWorkflowGUIDID = tw.WorkflowId
	INNER JOIN pMaterialRequestSubmitWorkflow mrsw ON mrsw.MaterialTradePartnerID = mtp.MaterialTradePartnerId
		AND mrw.MaterialRequestWorkflowID = mrsw.MaterialRequestWorkflowID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerID = mtp.TradepartnerId
		AND tpm.TradePartnerRelationshipLevelID = mtp.TradePartnerRelationshipLevelID
	INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId
		AND LOWER(pf.PermissionFolderTypeName) = LOWER('Material Request')
	GROUP BY crt.TACalRefTaskId
		, pm.MaterialID
		, tw.WorkflowId
		, ct.SeasonYearId
		, pm.MaterialNo
		, pm.MaterialName
		, pm.MaterialType
		, mtp.MaterialTradePartnerID
		, crt.TaskRevisedlStart
		, crt.TaskRevisedEnd
		, crt.TACalTemplateTaskId
		, ctt.TaskPlanStart
		, ctt.TaskPlanEnd
		, tpm.AgentID
		, tpm.AgentName
		, tpm.VendorID
		, tpm.VendorName
		, tpm.FactoryID
		, tpm.FactoryName
		, tw.WorkflowName
		, tw.WorkflowFolder
		, ctt.TaskTypeId
		, ct.TACalTemplateId
		, mrsw.AssignedTo
		, mrsw.Status
		, tpm.TradePartnerFullName
	) AS DataSource
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09094', GetDate())
GO
