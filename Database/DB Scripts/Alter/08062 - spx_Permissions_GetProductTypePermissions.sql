/****** Object:  StoredProcedure [dbo].[spx_Permissions_GetProductTypePermissions]    Script Date: 06/24/2014 10:53:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Permissions_GetProductTypePermissions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Permissions_GetProductTypePermissions]
GO

/****** Object:  StoredProcedure [dbo].[spx_Permissions_GetProductTypePermissions]    Script Date: 06/24/2014 10:53:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_Permissions_GetProductTypePermissions] 
	@GroupId UNIQUEIDENTIFIER,
	@FolderId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT product.PermissionProductTypeName AS TypeName, product.PermissionProductTypeId AS PermissionWorkflowId,
			MAX(workflow.PermissionRoleId) AS PermissionRoleId, MAX(workflow.PermissionView) AS PermissionView,MAX(workflow.PermissionCreate) AS PermissionCreate, MAX(workflow.PermissionModify) AS PermissionModify,
			MAX(workflow.PermissionRemove) AS PermissionRemove, MAX(workflow.PermissionDelete) AS PermissionDelete, MAX(workflow.PermissionPrint) AS PermissionPrint
			FROM sPermissionWorkflow AS workFlow 
			INNER JOIN sPermissionProductType as product on workFlow.PermissionProductTypeId = product.PermissionProductTypeId  
			WHERE workFlow.GroupID = @GroupID AND product.PermissionFolderId = @FolderID
			GROUP BY product.PermissionProductTypeId, product.PermissionProductTypeName
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08062', GetDate())
GO