/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromMaterial_CREATE]    Script Date: 08/09/2014 14:03:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromMaterial_CREATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromMaterial_CREATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromMaterial_CREATE]    Script Date: 08/09/2014 14:03:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
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

DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
DECLARE @SeasonYearId uniqueidentifier
DECLARE @IntroSeasonYear uniqueidentifier
SELECT  @SeasonYearId =  SeasonYearId  FROM pTACalTemplate WHERE TACalTemplateId = @TACalTemplateID

SELECT @IntroSeasonYear = IntroSeasonYearID FROM pMaterial where MaterialID = @MaterialID

INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
select @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, NULL, NULL, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
where tw.WorkflowFolder='MATERIAL' and tt.TACalTemplateId=@TACalTemplateId  and ((tt.New=1 AND @SeasonYearId = @IntroSeasonYear) OR (tt.CarryOver = 1 AND @SeasonYearId <> @IntroSeasonYear)) 
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
VALUES ('DB_Version', '0.5.0000', '08664', GetDate())
GO