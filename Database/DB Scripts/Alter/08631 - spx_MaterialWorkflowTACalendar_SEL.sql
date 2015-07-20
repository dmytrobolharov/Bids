IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowTACalendar_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflowTACalendar_SEL]
GO

CREATE PROCEDURE [dbo].[spx_MaterialWorkflowTACalendar_SEL]
	@MaterialID UNIQUEIDENTIFIER,
	@TACalReferenceId UNIQUEIDENTIFIER,
	@ShowOnlyTrackedPages INT
AS

SELECT *
FROM vwx_MaterialPageWorkflows_SEL mpw
INNER JOIN pMaterial m ON mpw.MaterialID = m.MaterialID
LEFT JOIN pTACalReferenceTask rt
	INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
	ON rt.TACalReferenceId = @TACalReferenceId
		AND tw.WorkflowID = mpw.MaterialTemplatePageID
WHERE mpw.MaterialID = @MaterialID
	AND (@ShowOnlyTrackedPages = 1 AND rt.TACalReferenceId IS NOT NULL OR @ShowOnlyTrackedPages = 0)
ORDER BY mpw.Sort, mpw.MaterialTemplatePageName

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08631', GetDate())
GO
