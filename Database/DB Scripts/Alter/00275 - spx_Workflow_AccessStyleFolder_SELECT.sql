IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_AccessStyleFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Workflow_AccessStyleFolder_SELECT]
GO  

CREATE PROCEDURE [dbo].[spx_Workflow_AccessStyleFolder_SELECT] (   
@GroupID uniqueidentifier,
@StyleTypeID int  
)  
AS   
  
  
SELECT a.Workflow, a.WorkflowID, a.WorkflowSort,  
 b.AccessStyleWorkflowID, b.AccessStyleId,  b.AccessRoleId, b.AccessView, b.AccessCreate,   
 b.AccessModify, b.AccessDelete, b.AccessPrint, b.AccessRemove,   
 b.GroupID, b.CUser, b.CDate,  b.MUser,   
 b.MDate  
FROM  pWorkflow a WITH (NOLOCK) INNER JOIN   sAccessStyleWorkflow  b WITH (NOLOCK) ON a.WorkflowID = b.WorkflowID  
WHERE b.GroupID = @GroupID  AND b.StyleTypeID = @StyleTypeID AND a.Active = 'True'
ORDER BY a.WorkflowSort 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '275', GetDate()) 