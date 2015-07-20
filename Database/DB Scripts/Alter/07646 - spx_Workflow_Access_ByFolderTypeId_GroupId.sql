/****** Object:  StoredProcedure [dbo].[spx_Workflow_Access_ByFolderTypeId_GroupId]    Script Date: 05/16/2014 18:23:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Access_ByFolderTypeId_GroupId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Workflow_Access_ByFolderTypeId_GroupId]
GO

/****** Object:  StoredProcedure [dbo].[spx_Workflow_Access_ByFolderTypeId_GroupId]    Script Date: 05/16/2014 18:23:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_Workflow_Access_ByFolderTypeId_GroupId]
	@GroupId uniqueidentifier,
	@FolderID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT MAX(workflow.PermissionRoleId) as PermissionRoleId, MAX(workflow.PermissionCreate) as PermissionCreate,MAX(workflow.PermissionDelete) as PermissionDelete, MAX(workflow.PermissionModify) as PermissionModify,MAX(workflow.PermissionPrint) as PermissionPrint,MAX(workflow.PermissionRemove) as PermissionRemove,MAX(workflow.PermissionView) as PermissionView FROM sPermissionWorkflow AS workflow
INNER JOIN sPermissionFolder AS folders ON workflow.PermissionFolderId = folders.PermissionFolderId
WHERE workflow.GroupID = @GroupId AND folders.PermissionFolderTypeId = @FolderID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07646', GetDate())
GO
