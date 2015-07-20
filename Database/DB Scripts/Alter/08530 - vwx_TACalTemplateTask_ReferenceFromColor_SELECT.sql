/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromColor_SELECT]    Script Date: 08/02/2014 17:51:54 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromColor_SELECT]'))
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromColor_SELECT]
GO

/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromColor_SELECT]    Script Date: 08/02/2014 17:51:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromColor_SELECT]
AS
SELECT crt.TACalRefTaskId, 'Color' as RefType, cf.ColorFolderID, cf.ColorTypeID, tw.WorkflowId, 
ct.SeasonYearId, cf.ColorFolderDescription, 
crt.TaskActualStart, crt.TaskActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd 
, crt.TACalTemplateTaskId, cwp.WorkAssignedTo, cwp.WorkStatus
from pTACalReferenceTask crt
INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
INNER JOIN pColorFolder cf ON cf.ColorFolderID = cr.ReferenceId 
INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId 
INNER JOIN pColorFolderWorkflowPage cwp ON cwp.ColorFolderID = cf.ColorFolderID AND cwp.ColorFolderWorkflowID = tw.WorkflowId 
INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId AND LOWER(pf.PermissionFolderTypeName) = LOWER('Color Folder')




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08530', GetDate())
GO
