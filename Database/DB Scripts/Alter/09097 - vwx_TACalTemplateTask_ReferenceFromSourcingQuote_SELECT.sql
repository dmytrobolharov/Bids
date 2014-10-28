IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingQuote_SELECT]') AND type = N'V')
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingQuote_SELECT]
GO

CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingQuote_SELECT]
AS
SELECT crt.TACalRefTaskId
	, 'Quotation' AS RefType
	, sqi.StyleQuoteItemID
	, tw.WorkflowId
	, ct.SeasonYearId
	, sqi.StyleQuoteItemNo
	, sh.StyleID
	, sh.StyleNo
	, sh.[Description]
	, sh.StyleType
	, sh.StyleCategory
	, sh.DivisionID
	, div.Custom AS DivisionName
	, sh.SizeClass
	, sh.SizeRange
	, sh.RecDate
	, sdi.StyleDevelopmentID
	, sqi.StyleQuoteItemShare
	, shi.SourcingHeaderID
	, shi.SourcingType
	, shi.SourcingName
	, sqi.TradePartnerID
	, sqi.TradePartnerVendorID
	, sqi.StyleSourcingID
	, sqi.ActualStart
	, sqi.ActualEnd
	, crt.TaskRevisedlStart
	, crt.TaskRevisedEnd
	, ctt.TaskPlanEnd
	, ctt.TaskPlanStart
	, crt.TACalTemplateTaskId
	, sqi.WorkAssignedTo
	, sqi.StyleQuoteItemStatusId AS WorkStatus
	, sqis.Custom AS WorkStatusName
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
	, tpm.TradePartnerFullName
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
FROM pTACalReferenceTask crt
	INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
	INNER JOIN pStyleQuoteItem sqi ON sqi.StyleQuoteItemID = cr.ReferenceId
	INNER JOIN pStyleQuoteItemStatus sqis ON sqis.CustomKey = sqi.StyleQuoteItemStatusId
	INNER JOIN pSourcingHeader shi ON sqi.SourcingHeaderID = shi.SourcingHeaderID
	INNER JOIN pStyleHeader sh ON sh.StyleID = sqi.StyleID
	INNER JOIN pStyleDevelopmentItem sdi ON sdi.StyleID = sh.StyleID
	INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
	INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
		AND tw.WorkflowFolder = 'SOURCING QUOTATION'
	INNER JOIN iCustom1 div ON div.CustomID = sh.DivisionID
	INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sqi.StyleQuoteTradePartnerID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerID = stp.TradePartnerID
		AND tpm.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID
	INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId
		AND LOWER(pf.PermissionFolderTypeName) = LOWER('Sourcing Folder')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09097', GetDate())
GO
