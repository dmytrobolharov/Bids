/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromSampleRequest_SELECT]    Script Date: 08/01/2014 15:51:16 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromSampleRequest_SELECT]'))
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromSampleRequest_SELECT]
GO

/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromSampleRequest_SELECT]    Script Date: 08/01/2014 15:51:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromSampleRequest_SELECT]
AS
SELECT crt.TACalRefTaskId, 'Sample Request' as RefType, sh.styleID, tw.WorkflowId, ct.SeasonYearId, 
sh.StyleNo, sh.Description, sh.StyleType, sh.DivisionID, sh.SizeClass, sh.SizeRange, sh.StyleCategory, sh.IntroSeasonYearID,
crt.TaskAssignedToId, crt.TaskStatusId, crt.TaskActualStart, crt.TaskActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd,crt.TACalTemplateTaskId
from pTACalReferenceTask crt
INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
INNER JOIN pSampleRequestBOMTrade srb ON srb.SampleRequestTradeID = cr.ReferenceId
INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
INNER JOIN pStyleHeader sh ON sh.StyleID = srb.StyleID
INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId AND LOWER(pf.PermissionFolderTypeName) = LOWER('Sample Folder')

UNION
SELECT crt.TACalRefTaskId, 'Sample Request' as RefType, sh.styleID, tw.WorkflowId, ct.SeasonYearId, 
sh.StyleNo, sh.Description, sh.StyleType, sh.DivisionID, sh.SizeClass, sh.SizeRange, sh.StyleCategory, sh.IntroSeasonYearID,
crt.TaskAssignedToId, crt.TaskStatusId, crt.TaskActualStart, crt.TaskActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd, crt.TACalTemplateTaskId
from pTACalReferenceTask crt
INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
INNER JOIN pSampleRequestTrade sr ON sr.SampleRequestTradeID = cr.ReferenceId
INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
INNER JOIN pStyleHeader sh ON sh.StyleID = sr.StyleID
INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId AND LOWER(pf.PermissionFolderTypeName) = LOWER('Sample Folder')




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08516', GetDate())
GO
