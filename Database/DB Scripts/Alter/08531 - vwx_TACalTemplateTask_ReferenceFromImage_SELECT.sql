/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromImage_SELECT]    Script Date: 08/02/2014 17:52:21 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromImage_SELECT]'))
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromImage_SELECT]
GO

/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromImage_SELECT]    Script Date: 08/02/2014 17:52:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromImage_SELECT]
AS
SELECT crt.TACalRefTaskId, 'Image' as RefType, im.ImageID, tw.WorkflowId, ct.SeasonYearId, im.ImageNo, im.ImageDescription, 
im.ImageSubFolder1, im.ImageSubFolder7, im.ImageKeywords, im.TradePartnerID,
crt.TaskActualStart, crt.TaskActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd
,crt.TACalTemplateTaskId, iwp.WorkAssignedTo, iwp.WorkStatus
from pTACalReferenceTask crt
INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
INNER JOIN pImage im ON im.ImageID = cr.ReferenceId 
INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
INNER JOIN pImageWorkflowPage iwp ON iwp.ImageID = im.ImageID AND iwp.ImageWorkflowTemplateItemID = tw.WorkflowId
INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId AND LOWER(pf.PermissionFolderTypeName) = LOWER('Image Folder')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08531', GetDate())
GO
