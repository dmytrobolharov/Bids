/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromMaterialRequest_SELECT]    Script Date: 08/11/2014 11:31:06 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromMaterialRequest_SELECT]'))
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromMaterialRequest_SELECT]
GO

/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromMaterialRequest_SELECT]    Script Date: 08/11/2014 11:31:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromMaterialRequest_SELECT]
AS
	SELECT DISTINCT crt.TACalRefTaskId, 'Material Request' as RefType, pm.MaterialID, tw.WorkflowId, ct.SeasonYearId, 
	pm.MaterialNo, pm.MaterialName, pm.MaterialType, 
	NULL AS TaskActualStart, NULL AS TaskActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd,
	crt.TACalTemplateTaskId,
	tpm.AgentID, tpm.AgentName, tpm.VendorID, tpm.VendorName, tpm.FactoryID, tpm.FactoryName
	from pTACalReferenceTask crt
	INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
	INNER JOIN pMaterialTradePartner mtp ON mtp.MaterialTradePartnerId = cr.ReferenceId
	INNER JOIN pMaterial pm ON pm.MaterialID = mtp.MaterialId
	INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
	INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
	INNER JOIN vwx_TradePartnerMgmt_SEL tpm ON tpm.TradePartnerID = mtp.TradepartnerId AND tpm.RelationshipLevelID = mtp.TradePartnerRelationshipLevelID 
	INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId AND LOWER(pf.PermissionFolderTypeName) = LOWER('Material Request')


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08726', GetDate())
GO
