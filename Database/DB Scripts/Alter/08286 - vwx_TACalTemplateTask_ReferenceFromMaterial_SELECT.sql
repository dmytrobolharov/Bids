/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromMaterial_SELECT]    Script Date: 07/11/2014 16:32:47 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromMaterial_SELECT]'))
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromMaterial_SELECT]
GO

/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromMaterial_SELECT]    Script Date: 07/11/2014 16:32:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromMaterial_SELECT]
AS
SELECT crt.TACalRefTaskId, 'Material' as RefType, pm.MaterialID, tw.WorkflowId, ct.SeasonYearId, pm.MaterialNo, pm.MaterialName, crt.TaskAssignedToId, crt.TaskStatusId,
 crt.TaskActualStart, crt.TaskActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd   
,crt.TACalTemplateTaskId
from pTACalReferenceTask crt
INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
INNER JOIN pMaterial pm ON pm.MaterialID = cr.ReferenceId 
INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId AND LOWER(pf.PermissionFolderTypeName) = LOWER('Material Folder')


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08286', GetDate())
GO