/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromColor_CREATE]    Script Date: 08/07/2014 16:12:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromColor_CREATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromColor_CREATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromColor_CREATE]    Script Date: 08/07/2014 16:12:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TACalReferenceFromColor_CREATE](
	@TACalTemplateID uniqueidentifier,
	@ColorPaletteID uniqueidentifier,
	@CUser nvarchar(100),
	@CDate datetime
)

AS 

DECLARE @FolderID integer
DECLARE @TACalReferenceId uniqueidentifier = newid()

SELECT @FolderID=PermissionFolderTypeId from sPermissionFolderType where LOWER(PermissionFolderTypeName) = LOWER('Color Folder')
--add TACAlReference to current style
INSERT INTO pTACalReference ( TACalReferenceId, TACalTemplateId, TACalReferenceTypeId , ReferenceId, MUser, MDate, CUser, CDate, Active)
VALUES (@TACalReferenceId, @TACalTemplateId, @FolderID, @ColorPaletteID, @CUser, @CDate, @CUser, @CDate, 1)



INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
select @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, NULL, NULL, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
where tw.WorkflowFolder='COLOR' and tt.TACalTemplateId=@TACalTemplateId   

UPDATE pColorFolderWorkflowPage SET pColorFolderWorkflowPage.WorkAssignedTo = u.UserID
FROM pTACalTemplateTask  tt
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
LEFT JOIN vwx_UserGroupDropDown_SEL u ON tt.TaskAssignedToId = u.TeamID
WHERE tw.WorkflowFolder = 'COLOR' AND tt.TACalTemplateId = @TACalTemplateId AND tt.New = 1 
	AND pColorFolderWorkflowPage.ColorFolderID = @ColorPaletteID 
	AND (pColorFolderWorkflowPage.WorkAssignedTo = 0 OR pColorFolderWorkflowPage.WorkAssignedTo IS NULL)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08619', GetDate())
GO