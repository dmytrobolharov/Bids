/****** Object:  StoredProcedure [dbo].[spx_Workflow_Permissions_SELECT]    Script Date: 05/16/2014 18:40:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Permissions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Workflow_Permissions_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Workflow_Permissions_SELECT]    Script Date: 05/16/2014 18:40:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Workflow_Permissions_SELECT] 
 @GroupID uniqueidentifier,
 @ProductTypeID int  
AS
BEGIN

 -- SET NOCOUNT ON added to prevent extra result sets from
 -- interfering with SELECT statements.
 SET NOCOUNT ON;
 
 SELECT a.PermissionWorkflowName as  Workflow,a.WorkflowId as WorkflowID,a.PermissionProductTypeId as WorkflowTypeID, a.PermissionWorkflowId as AccessStyleWorkflowID,a.PermissionFolderId as AccessStyleId,  a.PermissionRoleId as AccessRoleId,a.PermissionView as AccessView, a.PermissionCreate as AccessCreate, a.PermissionModify as AccessModify,a.PermissionDelete as AccessDelete, a.PermissionPrint as  AccessPrint, a.PermissionRemove as AccessRemove, a.GroupID ,a.CUser,a.CDate ,a.MUser ,a.MDate  FROM sPermissionWorkflow as a LEFT JOIN sPermissionProductTypeMap as p ON a.PermissionProductTypeMapId = p.PermissionProductTypeMapId WHERE a.GroupID = @GroupID AND p.IntProductTypeId = @ProductTypeID ORDER BY a.WorkflowId
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07652', GetDate())
GO
