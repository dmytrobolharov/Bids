/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_ReferenceFromMaterial_SELECT]    Script Date: 06/25/2014 14:44:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalTemplateTask_ReferenceFromMaterial_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalTemplateTask_ReferenceFromMaterial_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_ReferenceFromMaterial_SELECT]    Script Date: 06/25/2014 14:44:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TACalTemplateTask_ReferenceFromMaterial_SELECT](
	@TACalTemplateTaskID uniqueidentifier
)

AS 


DECLARE @StyleFolderID integer
DECLARE @TACalTemplateId uniqueidentifier 

SELECT @StyleFolderID=PermissionFolderTypeId from sPermissionFolderType where LOWER(PermissionFolderTypeName) = LOWER('Material Folder')

SELECT crt.TACalRefTaskId, 'Material' as RefType, pm.MaterialID, tw.WorkflowId, ct.SeasonYearId, pm.MaterialNo, pm.MaterialName, crt.TaskAssignedToId, crt.TaskStatusId, crt.TaskActualStart, crt.TaskActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd 
from pTACalReferenceTask crt
INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
INNER JOIN pMaterial pm ON pm.MaterialID = cr.ReferenceId 
INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
Where crt.TACalTemplateTaskId=@TACalTemplateTaskID and cr.TACalReferenceTypeId = @StyleFolderID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08066', GetDate())
GO