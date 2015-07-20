DELETE FROM w1 FROM sPermissionWorkflow as w1, sPermissionWorkflow w2
WHERE w1.PermissionFolderId = w2.PermissionFolderId		
		AND w1.PermissionWorkflowName = w2.PermissionWorkflowName
		AND w1.PermissionProductTypeId = w2.PermissionProductTypeId
		AND w1.WorkflowId = w2.WorkflowId
		AND w1.GroupId = w2.GroupId
		AND w1.PermissionWorkflowId > w2.PermissionWorkflowId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08154', GetDate())
GO
