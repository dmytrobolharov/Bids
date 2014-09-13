/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromImage_CREATE]    Script Date: 08/12/2014 16:39:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromImage_CREATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromImage_CREATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalReferenceFromImage_CREATE]    Script Date: 08/12/2014 16:39:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_TACalReferenceFromImage_CREATE](
	@TACalTemplateID uniqueidentifier,
	@ImageID uniqueidentifier,
	@CUser nvarchar(100),
	@CDate datetime,
	@ForCreate int = 0
)

AS 

DECLARE @FolderID integer
DECLARE @TACalReferenceId uniqueidentifier = newid()

SELECT @FolderID=PermissionFolderTypeId from sPermissionFolderType where LOWER(PermissionFolderTypeName) = LOWER('Image Folder')
--add TACAlReference to current style
INSERT INTO pTACalReference ( TACalReferenceId, TACalTemplateId, TACalReferenceTypeId , ReferenceId, MUser, MDate, CUser, CDate, Active)
VALUES (@TACalReferenceId, @TACalTemplateId, @FolderID, @ImageID, @CUser, @CDate, @CUser, @CDate, 1)


INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
select @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, NULL, NULL, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
where tw.WorkflowFolder='IMAGE' and tt.TACalTemplateId=@TACalTemplateId 
AND tw.WorkflowId in (SELECT wi.ImageWorkflowTemplateItemID FROM pImage i
			LEFT JOIN pImageWorkflowTemplate wt ON wt.ImageWorkflowTemplateID = i.ImageWorkflowTemplateID
			INNER JOIN pImageWorkflowTemplateEntry we ON we.ImageWorkflowTemplateID = wt.ImageWorkflowTemplateID
			LEFT JOIN pImageWorkflowTemplateItem wi ON wi.ImageWorkflowTemplateItemID = we.ImageWorkflowTemplateItemID
			WHERE i.ImageID = @ImageID) 
			
UPDATE pImageWorkflowPage SET pImageWorkflowPage.WorkAssignedTo = u.UserID
FROM pTACalTemplateTask  tt
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
LEFT JOIN vwx_UserGroupDropDown_SEL u ON tt.TaskAssignedToId = u.TeamID
where tw.WorkflowFolder='IMAGE' and tt.TACalTemplateId=@TACalTemplateId  and tt.New=1 
AND pImageWorkflowPage.ImageWorkflowTemplateItemID = tw.WorkflowId and pImageWorkflowPage.ImageID = @ImageID AND ((pImageWorkflowPage.WorkAssignedTo = 0 OR pImageWorkflowPage.WorkAssignedTo IS NULL) OR @ForCreate=1)			

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08758', GetDate())
GO