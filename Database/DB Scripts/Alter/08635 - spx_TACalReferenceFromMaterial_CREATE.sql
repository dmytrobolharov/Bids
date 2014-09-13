IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromMaterial_CREATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromMaterial_CREATE]
GO

CREATE PROCEDURE [dbo].[spx_TACalReferenceFromMaterial_CREATE](
	@TACalTemplateID uniqueidentifier,
	@MaterialID uniqueidentifier,
	@CUser nvarchar(100),
	@CDate datetime
)

AS 

DECLARE @FolderID integer
DECLARE @TACalReferenceId uniqueidentifier = newid()

SELECT @FolderID=PermissionFolderTypeId from sPermissionFolderType where LOWER(PermissionFolderTypeName) = LOWER('Material Folder')
--add TACAlReference to current style
INSERT INTO pTACalReference ( TACalReferenceId, TACalTemplateId, TACalReferenceTypeId , ReferenceId, MUser, MDate, CUser, CDate, Active)
VALUES (@TACalReferenceId, @TACalTemplateId, @FolderID, @MaterialID, @CUser, @CDate, @CUser, @CDate, 1)


INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
select @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
where tw.WorkflowFolder='MATERIAL' and tt.TACalTemplateId=@TACalTemplateId  and tt.New=1 
AND tw.WorkflowId in (SELECT  ti.MaterialTemplatePageID 
            FROM pMaterialTemplateItem ti 
             INNER JOIN pMaterialTemplatePage tp ON ti.MaterialTemplatePageID = tp.MaterialTemplatePageID 
             INNER JOIN pMaterial  pm on ti.MaterialTemplateID = pm.MaterialTemplateID
             Where pm.MaterialID=@MaterialID) 
             
-- update assigned to? if there is none
UPDATE mwp SET WorkAssignedTo = ug.UserID
FROM pMaterialWorkflowPage mwp
INNER JOIN pTACalReferenceTask rt 
	INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId 
	ON mwp.MaterialTemplatePageID = tw.WorkflowId AND rt.TACalReferenceId = @TACalReferenceId
INNER JOIN vwx_UserGroupDropDown_SEL ug ON tt.TaskAssignedToId = ug.TeamID
WHERE mwp.MaterialID = @MaterialID 
	AND (mwp.WorkAssignedTo IS NULL OR mwp.WorkAssignedTo = 0)

-- save added calendar into material
UPDATE pMaterial SET TACalTemplateId = @TACalTemplateID
WHERE MaterialID = @MaterialID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08635', GetDate())
GO
