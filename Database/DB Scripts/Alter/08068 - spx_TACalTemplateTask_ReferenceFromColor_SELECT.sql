/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_ReferenceFromColor_SELECT]    Script Date: 06/25/2014 14:44:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalTemplateTask_ReferenceFromColor_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalTemplateTask_ReferenceFromColor_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalTemplateTask_ReferenceFromColor_SELECT]    Script Date: 06/25/2014 14:44:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TACalTemplateTask_ReferenceFromColor_SELECT](
	@TACalTemplateTaskID uniqueidentifier
)

AS 


DECLARE @ColorFolderID integer
DECLARE @TACalTemplateId uniqueidentifier 

SELECT @ColorFolderID=PermissionFolderTypeId from sPermissionFolderType where LOWER(PermissionFolderTypeName) = LOWER('Color Folder')

SELECT crt.TACalRefTaskId, 'Color' as RefType, cf.ColorFolderID, cf.ColorTypeID, tw.WorkflowId, ct.SeasonYearId, cf.ColorFolderDescription, crt.TaskAssignedToId, crt.TaskStatusId, crt.TaskActualStart, crt.TaskActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd 
from pTACalReferenceTask crt
INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
INNER JOIN pColorFolder cf ON cf.ColorFolderID = cr.ReferenceId 
INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
Where crt.TACalTemplateTaskId=@TACalTemplateTaskID and cr.TACalReferenceTypeId = @ColorFolderID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08068', GetDate())
GO