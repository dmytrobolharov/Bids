IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorWorkflowTACalendar_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorWorkflowTACalendar_SEL]
GO


CREATE PROCEDURE [dbo].[spx_ColorWorkflowTACalendar_SEL] (
	@ColorFolderID uniqueidentifier,
	@TACalReferenceId uniqueidentifier
)
AS
BEGIN
	DECLARE @TACalReferenceIdString nVARCHAR(50)
	SET @TACalReferenceIdString = CAST(@TACalReferenceId AS nVARCHAR(50));
	
	IF @TACalReferenceIdString  = '0000000-0000-0000-0000-000000000000' OR ISNULL(@TACalReferenceIdString, '') = ''
	BEGIN
		SELECT * FROM vwx_ColorWorkflowCalendarItems WHERE ColorFolderID = @ColorFolderID	
	END
	ELSE
	BEGIN
		SELECT * FROM vwx_ColorWorkflowCalendarItems vcwi
		LEFT OUTER JOIN(
			SELECT rt.TACalReferenceId, tt.TaskPlanStart, tt.TaskPlanEnd, rt.TaskRevisedlStart, rt.TaskRevisedEnd, 
				tw.WorkflowId,tt.TaskAssignedToId,rt.TACalRefTaskId, tw.WorkflowName AS WFName, tw.WorkflowFolder AS WFFolder
			FROM pTACalReferenceTask rt
			INNER JOIN  pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
			INNER JOIN  pTATaskWorkflow tw ON tt.TaskWorkflowId=tw.TATaskWorkflowId 
			WHERE rt.TACalReferenceId = @TACalReferenceId) ds 
				ON vcwi.WorkflowName = ds.WFName AND vcwi.WorkflowFolder = ds.WFFolder
		WHERE vcwi.ColorFolderID = @ColorFolderID 
	END
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08649', GetDate())
GO