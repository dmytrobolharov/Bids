IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_AccessStyleFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Workflow_AccessStyleFolder_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_Workflow_AccessStyleFolder_SELECT] (   
@GroupID uniqueidentifier,
@StyleTypeID int  
)  
AS   
  
  
SELECT a.Workflow, a.WorkflowID, a.WorkflowSort, a.WorkflowTypeID,  
 b.AccessStyleWorkflowID, b.AccessStyleId,  b.AccessRoleId, b.AccessView, b.AccessCreate,   
 b.AccessModify, b.AccessDelete, b.AccessPrint, b.AccessRemove,   
 b.GroupID, b.CUser, b.CDate,  b.MUser,   
 b.MDate  
FROM  pWorkflow a WITH (NOLOCK) INNER JOIN   sAccessStyleWorkflow  b WITH (NOLOCK) ON a.WorkflowID = b.WorkflowID  
WHERE (b.GroupID = @GroupID  AND b.StyleTypeID = @StyleTypeID AND a.Active = 'True') Or (b.GroupID = @GroupID  AND b.StyleTypeID = @StyleTypeID AND a.Active = 'False'and a.WorkflowTypeID = '0')
ORDER BY a.WorkflowSort, a.workflowID 


GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03083'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03083', GetDate())

END

GO

