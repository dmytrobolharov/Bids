/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromMaterial_SELECT]    Script Date: 08/11/2014 20:49:12 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromMaterial_SELECT]'))
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromMaterial_SELECT]
GO

/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromMaterial_SELECT]    Script Date: 08/11/2014 20:49:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromMaterial_SELECT]
AS
SELECT crt.TACalRefTaskId, 'Material' as RefType, pm.MaterialID, tw.WorkflowId, ct.SeasonYearId, 
pm.MaterialNo, pm.MaterialName, pm.MaterialType, 
mwp.ActualStart, mwp.ActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd, ctt.TaskPlanStart, ctt.TaskPlanEnd,
crt.TACalTemplateTaskId, mwp.WorkAssignedTo, mwp.WorkStatus, mwp.MaterialWorkflowPageID,
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
INNER JOIN pMaterial pm ON pm.MaterialID = cr.ReferenceId 
INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
LEFT JOIN pMaterialWorkflowPage mwp ON mwp.MaterialID = pm.MaterialID AND tw.WorkflowId = mwp.MaterialTemplatePageID
INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId AND LOWER(pf.PermissionFolderTypeName) = LOWER('Material Folder')




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08750', GetDate())
GO
