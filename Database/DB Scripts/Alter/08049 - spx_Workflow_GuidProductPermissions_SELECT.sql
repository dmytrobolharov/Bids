/****** Object:  StoredProcedure [dbo].[spx_Workflow_GuidProductPermissions_SELECT]    Script Date: 06/20/2014 20:27:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_GuidProductPermissions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Workflow_GuidProductPermissions_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Workflow_GuidProductPermissions_SELECT]    Script Date: 06/20/2014 20:27:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_Workflow_GuidProductPermissions_SELECT]
	@GroupID uniqueidentifier,
	@ProductTypeID uniqueidentifier  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;
SELECT a.PermissionWorkflowName AS TypeName, a.CDate,a.CUser,a.GroupID,a.MDate,a.MUser,a.PermissionCreate,a.PermissionDelete,a.PermissionFolderId,a.PermissionModify,a.PermissionPrint,a.PermissionProductTypeId,a.PermissionProductTypeMapId,a.PermissionRemove,a.PermissionRoleId,a.PermissionView,a.PermissionWorkflowId,a.WorkflowId,a.ParentWorkflowID  FROM sPermissionWorkflow as a WHERE	a.GroupID = @GroupID AND a.PermissionProductTypeId = @ProductTypeID 

   
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08049', GetDate())
GO
