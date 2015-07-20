IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_AccessStyleWorkflow_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_AccessStyleWorkflow_Select]
GO

CREATE PROCEDURE [dbo].[spx_AccessStyleWorkflow_Select] ( 
	@GroupID uniqueidentifier,  
	@StyleTypeID int

	)
AS
BEGIN
	SELECT a.WorkflowID, b.AccessStyleWorkflowID, b.AccessStyleId, b.AccessRoleId, b.AccessView, 
		b.AccessCreate, b.AccessModify, b.AccessDelete, b.AccessPrint, b.AccessRemove, b.GroupID, b.StyleTypeId  
	FROM  pWorkflow a WITH (NOLOCK) INNER JOIN   sAccessStyleWorkflow  b WITH (NOLOCK) ON a.WorkflowID = b.WorkflowID  
	WHERE b.GroupID = @GroupID AND b.StyleTypeID = @StyleTypeID
	AND (a.Active = 'True' OR a.WorkflowID IN ('40000000-0000-0000-0000-000000000051','40000000-0000-0000-0000-000000000052','40000000-0000-0000-0000-000000000053','40000000-0000-0000-0000-000000000054'))
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06985', GetDate())
GO
