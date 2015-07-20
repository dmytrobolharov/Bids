/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromImage_SELECT]    Script Date: 08/11/2014 20:45:45 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromImage_SELECT]'))
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromImage_SELECT]
GO

/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromImage_SELECT]    Script Date: 08/11/2014 20:45:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromImage_SELECT]
AS
SELECT crt.TACalRefTaskId, 'Image' as RefType, im.ImageID, tw.WorkflowId, ct.SeasonYearId, im.ImageNo, im.ImageDescription, 
im.ImageSubFolder1, im.ImageSubFolder7, im.ImageKeywords, im.TradePartnerID,
iwp.ActualStart, iwp.ActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd, ctt.TaskPlanEnd, ctt.TaskPlanStart, 
crt.TACalTemplateTaskId, iwp.WorkAssignedTo, iwp.WorkStatus, iwp.ImageWorkflowPageID,
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
INNER JOIN pImage im ON im.ImageID = cr.ReferenceId 
INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
LEFT JOIN pImageWorkflowPage iwp ON iwp.ImageID = im.ImageID AND iwp.ImageWorkflowTemplateItemID = tw.WorkflowId
INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId AND LOWER(pf.PermissionFolderTypeName) = LOWER('Image Folder')



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08749', GetDate())
GO
