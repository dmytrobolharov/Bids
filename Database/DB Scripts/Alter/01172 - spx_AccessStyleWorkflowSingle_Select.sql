IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_AccessStyleWorkflowSingle_Select]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_AccessStyleWorkflowSingle_Select]
GO
CREATE PROCEDURE [dbo].[spx_AccessStyleWorkflowSingle_Select] ( 
	@WorkflowID uniqueidentifier,
	@GroupID uniqueidentifier,  
	@StyleTypeID int
	)
AS
BEGIN
	SELECT a.WorkflowID, b.AccessStyleWorkflowID, b.AccessStyleId, b.AccessRoleId, b.AccessView, 
		b.AccessCreate, b.AccessModify, b.AccessDelete, b.AccessPrint, b.AccessRemove, b.GroupID, b.StyleTypeId  
	FROM  pWorkflow a WITH (NOLOCK) INNER JOIN   sAccessStyleWorkflow  b WITH (NOLOCK) ON a.WorkflowID = b.WorkflowID  
	WHERE b.GroupID = @GroupID AND b.StyleTypeID = @StyleTypeID AND a.WorkflowId = @WorkflowID AND a.Active = 'True'
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01172', GetDate())
GO