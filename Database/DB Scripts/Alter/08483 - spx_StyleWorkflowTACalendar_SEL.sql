IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowTACalendar_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowTACalendar_SEL]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowTACalendar_SEL] (
	@StyleID uniqueidentifier,
	@WorkflowTemplateID uniqueidentifier,
	@SeasonYearID uniqueidentifier,
	@TACalReferenceId uniqueidentifier
	)
AS
BEGIN
	declare @TACalReferenceIdString nvarchar(50)
	SET @TACalReferenceIdString = CAST(@TACalReferenceId as nvarchar(50));
	
	IF @TACalReferenceIdString  = '0000000-0000-0000-0000-000000000000' OR @TACalReferenceIdString = '' OR @TACalReferenceIdString IS NULL
		BEGIN
			SELECT * FROM vwx_StyleWorkflowCalendarItems vswi 
			WHERE vswi.StyleID = @StyleID AND vswi.StyleSet = 1 
			AND vswi.WorkflowTemplateID = @WorkflowTemplateID 
			AND (IsSeasonal = 1 AND SeasonYearID = @SeasonYearID OR IsSeasonal <> 1) 
			ORDER BY WorkflowSort, vswi.WorkflowID	
		END

	ELSE
		BEGIN
			SELECT WorkAssignedTo,* FROM vwx_StyleWorkflowCalendarItems vswi 
			LEFT OUTER JOIN(select rt.TACalReferenceId, tt.TaskPlanStart, tt.TaskPlanEnd, rt.TaskRevisedlStart, rt.TaskRevisedEnd,tw.WorkflowId,tt.TaskAssignedToId,rt.TACalRefTaskId 
			from pTACalReferenceTask rt
			INNER JOIN  pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
			INNER JOIN  pTATaskWorkflow tw ON tt.TaskWorkflowId=tw.TATaskWorkflowId WHERE rt.TACalReferenceId=@TACalReferenceId) ds ON vswi.WorkflowID = ds.WorkflowId
			WHERE vswi.StyleID = @StyleID AND vswi.StyleSet = 1 
			AND vswi.WorkflowTemplateID = @WorkflowTemplateID 
			AND (IsSeasonal = 1 AND SeasonYearID = @SeasonYearID OR IsSeasonal <> 1) 
			ORDER BY WorkflowSort, vswi.WorkflowID		
		END
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08483', GetDate())
GO

