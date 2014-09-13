/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingCommitment_SELECT]    Script Date: 08/12/2014 13:29:35 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingCommitment_SELECT]'))
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingCommitment_SELECT]
GO

/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingCommitment_SELECT]    Script Date: 08/12/2014 13:29:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingCommitment_SELECT]
AS
	SELECT crt.TACalRefTaskId, 'Commitment' as RefType, sci.SourcingCommitmentItemID, tw.WorkflowId, ct.SeasonYearId,
	sci.StyleCommitmentNo, sh.StyleID, sh.StyleNo, sh.[Description], sh.StyleType, sh.StyleCategory, sh.DivisionID, 
	div.Custom AS DivisionName, sh.SizeClass, sh.SizeRange, sdi.StyleDevelopmentID, sci.TradePartnerID, sci.TradePartnerVendorID,
	shi.SourcingHeaderID, shi.SourcingType, shi.SourcingName, sci.StyleQuoteItemID, sci.StyleSourcingID, sci.StyleQuoteItemShare, 
	sci.ActualStart, sci.ActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd, ctt.TaskPlanStart, ctt.TaskPlanEnd, 
	crt.TACalTemplateTaskId, sci.WorkAssignedTo, sci.StyleQuoteItemStatusId AS WorkStatus,
	tpm.AgentID, tpm.AgentName, tpm.VendorID, tpm.VendorName, tpm.FactoryID, tpm.FactoryName,
	CASE WHEN ActualEnd IS NULL THEN 0 ELSE 1 END AS Ended,
	CASE
		WHEN ActualEnd IS NOT NULL THEN
			CASE WHEN 
				(CAST(ActualEnd AS DATE) > CAST(TaskPlanEnd AS DATE)) OR
				(CAST(ActualEnd AS DATE) > CAST(TaskRevisedEnd AS DATE))
			THEN 1
			ELSE 0
			END
		ELSE
			CASE WHEN TaskRevisedEnd IS NULL THEN
				CASE WHEN CAST(CURRENT_TIMESTAMP AS DATE) > CAST(TaskPlanEnd AS DATE) 
				THEN 1
				ELSE 0
				END
			ELSE
				CASE WHEN CAST(TaskPlanEnd AS DATE) >= CAST(TaskRevisedEnd AS DATE) THEN
					CASE WHEN CAST(CURRENT_TIMESTAMP AS DATE) > CAST(TaskPlanEnd AS DATE) OR
								CAST(CURRENT_TIMESTAMP AS DATE) > CAST(TaskRevisedEnd AS DATE)
					THEN 1
					ELSE 0
					END
				ELSE 1
				END
			END
	END	AS Late
	from pTACalReferenceTask crt
	INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
	INNER JOIN pSourcingCommitmentItem sci ON sci.SourcingCommitmentItemID = cr.ReferenceId
	INNER JOIN pSourcingHeader shi ON sci.SourcingHeaderID = shi.SourcingHeaderID
	INNER JOIN pStyleHeader sh ON sh.StyleID = sci.StyleID 
	INNER JOIN pStyleDevelopmentItem sdi ON sdi.StyleID = sh.StyleID 
	INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
	INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId AND tw.WorkflowFolder = 'SOURCING COMMITMENT'
	INNER JOIN iCustom1 div ON div.CustomID = sh.DivisionID
	INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sci.StyleQuoteTradePartnerID 
	INNER JOIN vwx_TradePartnerMgmt_SEL tpm ON tpm.TradePartnerID = stp.TradePartnerID AND tpm.RelationshipLevelID = stp.TradePartnerLevelID
	INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId AND LOWER(pf.PermissionFolderTypeName) = LOWER('Sourcing Folder')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08753', GetDate())
GO
