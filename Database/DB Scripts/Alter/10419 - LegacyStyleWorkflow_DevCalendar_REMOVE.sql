-- delete Dev. Calendar task references for all removed style workflows
BEGIN TRY
	BEGIN TRAN

	DELETE ttd
	FROM pTACalTemplateTaskDep ttd
	INNER JOIN pTACalTemplateTask tt ON ttd.TACalTemplateTaskParentId = tt.TACalTemplateTaskId
		OR ttd.TACalTemplateTaskChildId = tt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
	LEFT JOIN Mapping m ON tw.WorkflowId = m.Map
	WHERE tw.WorkflowFolder = N'STYLE'
		AND m.Map IS NULL

	DELETE rt
	FROM pTACalReferenceTask rt
	INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
	LEFT JOIN Mapping m ON tw.WorkflowId = m.Map
	WHERE tw.WorkflowFolder = N'STYLE'
		AND m.Map IS NULL

	DELETE tt
	FROM pTACalTemplateTask tt
	INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
	LEFT JOIN Mapping m ON tw.WorkflowId = m.Map
	WHERE tw.WorkflowFolder = N'STYLE'
		AND m.Map IS NULL

	DELETE tw 
	FROM pTATaskWorkflow tw
	LEFT JOIN Mapping m ON tw.WorkflowId = m.Map
	WHERE tw.WorkflowFolder = N'STYLE'
		AND m.Map IS NULL

	COMMIT
END TRY
BEGIN CATCH
	IF XACT_STATE() <> 0 ROLLBACK
END CATCH
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10419', GetUTCDate())
GO
