/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingCommitment_SELECT]    Script Date: 08/10/2014 22:00:00 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingCommitment_SELECT]'))
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingCommitment_SELECT]
GO

/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingCommitment_SELECT]    Script Date: 08/10/2014 22:00:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingCommitment_SELECT]
AS
	SELECT crt.TACalRefTaskId, 'Commitment' as RefType, sci.SourcingCommitmentItemID, tw.WorkflowId, ct.SeasonYearId,
	sci.StyleCommitmentNo, sh.StyleID, sh.StyleNo, sh.[Description], sh.StyleType, sh.StyleCategory, sh.DivisionID, 
	div.Custom AS DivisionName, sh.SizeClass, sh.SizeRange, 
	shi.SourcingHeaderID, shi.SourcingType, shi.SourcingName,
	sci.ActualStart, sci.ActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd,
	crt.TACalTemplateTaskId, sci.WorkAssignedTo, sci.StyleQuoteItemStatusId AS WorkStatus,
	tpm.AgentID, tpm.AgentName, tpm.VendorID, tpm.VendorName, tpm.FactoryID, tpm.FactoryName
	from pTACalReferenceTask crt
	INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
	INNER JOIN pSourcingCommitmentItem sci ON sci.SourcingCommitmentItemID = cr.ReferenceId
	INNER JOIN pSourcingHeader shi ON sci.SourcingHeaderID = shi.SourcingHeaderID
	INNER JOIN pStyleHeader sh ON sh.StyleID = sci.StyleID 
	INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
	INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
	INNER JOIN iCustom1 div ON div.CustomID = sh.DivisionID
	INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sci.StyleQuoteTradePartnerID 
	INNER JOIN vwx_TradePartnerMgmt_SEL tpm ON tpm.TradePartnerID = stp.TradePartnerID AND tpm.RelationshipLevelID = stp.TradePartnerLevelID
	INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId AND LOWER(pf.PermissionFolderTypeName) = LOWER('Sourcing Folder')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08728', GetDate())
GO
