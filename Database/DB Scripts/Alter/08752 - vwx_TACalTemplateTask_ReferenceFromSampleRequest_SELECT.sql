/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromSampleRequest_SELECT]    Script Date: 08/11/2014 22:41:19 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromSampleRequest_SELECT]'))
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromSampleRequest_SELECT]
GO

/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromSampleRequest_SELECT]    Script Date: 08/11/2014 22:41:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromSampleRequest_SELECT]
AS
SELECT *,
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
 FROM (
	SELECT crt.TACalRefTaskId, 'Sample Request' as RefType, sh.styleID, tw.WorkflowId, ct.SeasonYearId, 
	sh.StyleNo, sh.Description, sh.StyleType AS StyleTypeID, st.StyleTypeDescription, sh.DivisionID, div.Custom AS DivisionName, 
	sh.SizeClass, sh.SizeRange, sh.StyleCategory AS StyleCategoryID, sc.StyleCategory, sh.IntroSeasonYearID,
	srw.StartDate AS ActualStart, srsb.EndDate AS ActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd,crt.TACalTemplateTaskId, ctt.TaskPlanStart, ctt.TaskPlanEnd, 
	srb.SampleRequestTradeID, srb.StyleBOMDimensionID, bdi.ItemDim1Id, bdi.ItemDim2Id, bdi.ItemDim3Id,
	bdi.ItemDim1Name, bdi.ItemDim2Name, bdi.Itemdim3name,sw.SampleWorkflowID, srw.SampleRequestWorkflowID, 1 AS FlagBOM,
	tpm.TradePartnerID, tpm.RelationshipLevelID, tpm.AgentID, tpm.AgentName, tpm.VendorID, tpm.VendorName, tpm.FactoryID, tpm.FactoryName,
	srw.AssignedTo AS WorkAssignedTo, srw.[Status] AS WorkStatus, stat.[Status] AS WorkStatusName
	from pTACalReferenceTask crt
	INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
	INNER JOIN pSampleRequestBOMTrade srb ON srb.SampleRequestTradeID = cr.ReferenceId
	INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
	INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
	INNER JOIN pSampleWorkflow sw ON sw.SampleWorkflowGUID = tw.WorkflowId
	INNER JOIN pStyleHeader sh ON sh.StyleID = srb.StyleID
	LEFT OUTER JOIN pStyleBOMDimensionItems bdi ON bdi.StyleBOMDimensionItemID = srb.StyleBOMDimensionItemID
	INNER JOIN vwx_TradePartnerMgmt_SEL tpm ON tpm.RelationshipLevelID = srb.TradePartnerRelationshipLevelID AND tpm.TradePartnerID = srb.TradePartnerID
	INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	INNER JOIN iCustom1 div ON div.CustomID = sh.DivisionID
	INNER JOIN pStyleCategory sc ON sc.StyleCategoryId = sh.StyleCategory
	INNER JOIN pSampleRequestWorkflowBOM srw ON srw.SampleRequestTradeID = srb.SampleRequestTradeID AND srw.SampleWorkflowID = sw.SampleWorkflowID
	INNER JOIN pSampleRequestSubmitBOM srsb ON srsb.SampleRequestWorkflowID = srw.SampleRequestWorkflowID AND srsb.Submit = srw.Submit
	LEFT OUTER JOIN pSampleRequestSubmitStatus stat ON stat.StatusID = srw.[Status]
	INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId AND LOWER(pf.PermissionFolderTypeName) = LOWER('Sample Folder')
	UNION
	SELECT crt.TACalRefTaskId, 'Sample Request' as RefType, sh.styleID, tw.WorkflowId, ct.SeasonYearId, 
	sh.StyleNo, sh.Description, sh.StyleType AS StyleTypeID, st.StyleTypeDescription, sh.DivisionID, div.Custom AS DivisionName, 
	sh.SizeClass, sh.SizeRange, sh.StyleCategory AS StyleCategoryID, sc.StyleCategory, sh.IntroSeasonYearID,
	srw.StartDate AS ActualStart, srsb.EndDate AS ActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd, crt.TACalTemplateTaskId, ctt.TaskPlanStart, ctt.TaskPlanEnd,
	sr.SampleRequestTradeID, NULL AS StyleBOMDimensionID, NULL AS ItemDim1Id, NULL AS ItemDim2Id, NULL AS ItemDim3Id, 
	NULL AS ItemDim1Name, NULL AS ItemDim2Name, NULL AS ItemDim3Name, sw.SampleWorkflowID, srw.SampleRequestWorkflowID, 0 AS FlagBOM,
	tpm.TradePartnerID, tpm.RelationshipLevelID, tpm.AgentID, tpm.AgentName, tpm.VendorID, tpm.VendorName, tpm.FactoryID, tpm.FactoryName,
	srw.AssignedTo AS WorkAssignedTo, srw.[Status] AS WorkStatus, stat.[Status] AS WorkStatusName
	from pTACalReferenceTask crt
	INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
	INNER JOIN pSampleRequestTrade sr ON sr.SampleRequestTradeID = cr.ReferenceId
	INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
	INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
	INNER JOIN pStyleHeader sh ON sh.StyleID = sr.StyleID
	INNER JOIN pSampleWorkflow sw ON sw.SampleWorkflowGUID = tw.WorkflowId
	INNER JOIN vwx_TradePartnerMgmt_SEL tpm ON tpm.RelationshipLevelID = sr.TradePartnerRelationshipLevelID AND tpm.TradePartnerID = sr.TradePartnerID
	INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	INNER JOIN iCustom1 div ON div.CustomID = sh.DivisionID
	INNER JOIN pStyleCategory sc ON sc.StyleCategoryId = sh.StyleCategory
	INNER JOIN pSampleRequestWorkflow srw ON srw.SampleRequestTradeID = sr.SampleRequestTradeID AND srw.SampleWorkflowID = sw.SampleWorkflowID
	INNER JOIN pSampleRequestSubmit srsb ON srsb.SampleRequestWorkflowID = srw.SampleRequestWorkflowID AND srsb.Submit = srw.Submit
	LEFT OUTER JOIN pSampleRequestSubmitStatus stat ON stat.StatusID = srw.[Status]
	INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId AND LOWER(pf.PermissionFolderTypeName) = LOWER('Sample Folder')
) AS DataSource



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08752', GetDate())
GO
