/****** Object:  StoredProcedure [dbo].[spx_Workflow_GuidProductPermissions_SELECT]    Script Date: 12.01.2015 15:36:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_GuidProductPermissions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Workflow_GuidProductPermissions_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Workflow_GuidProductPermissions_SELECT]    Script Date: 12.01.2015 15:36:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Workflow_GuidProductPermissions_SELECT]
	@GroupID uniqueidentifier,
	@ProductTypeID uniqueidentifier  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;
  
 ;WITH cte AS
 (
SELECT PermissionWorkflowId, 
PermissionProductTypeMapId, 
PermissionWorkflowName AS TypeName, 
WorkflowId, 
ParentWorkflowID,
0 AS level,
ROW_NUMBER()OVER(PARTITION BY ParentWorkflowID ORDER BY PermissionWorkflowName) / POWER(100.0, 0) AS x,
PermissionRoleId, 
PermissionView, 
PermissionCreate, 
PermissionRemove, 
PermissionModify, 
PermissionDelete, 
PermissionPrint,
Active
FROM sPermissionWorkflow 
WHERE PermissionProductTypeId = @ProductTypeID AND GroupId = @GroupID
AND ParentWorkflowID IS NULL
UNION ALL
SELECT t.PermissionWorkflowId, 
t.PermissionProductTypeMapId, 
t.PermissionWorkflowName AS TypeName, 
t.WorkflowId, 
t.ParentWorkflowID,
level + 1,
x + ROW_NUMBER()OVER(PARTITION BY t.ParentWorkflowID ORDER BY t.PermissionWorkflowName) / POWER(100.0, level+1),
t.PermissionRoleId, 
t.PermissionView, 
t.PermissionCreate, 
t.PermissionRemove, 
t.PermissionModify, 
t.PermissionDelete, 
t.PermissionPrint,
t.Active
FROM cte INNER JOIN sPermissionWorkflow t ON t.ParentWorkflowID = cte.WorkflowId
WHERE PermissionProductTypeId = @ProductTypeID AND GroupId = @GroupID
 )
 SELECT PermissionWorkflowId, TypeName, WorkflowId, ParentWorkflowID, 
 PermissionRoleID, PermissionView, PermissionCreate, PermissionModify, PermissionRemove, PermissionDelete, PermissionPrint 
 FROM cte 
 WHERE Active = 1
 ORDER BY x
   
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09225', GetDate())
GO
