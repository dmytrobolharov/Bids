/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetStringProductType_WorkflowPermissions]    Script Date: 06/17/2014 18:12:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetStringProductType_WorkflowPermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_Permissions_GetStringProductType_WorkflowPermissions]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetStringProductType_WorkflowPermissions]    Script Date: 06/17/2014 18:12:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fnx_Permissions_GetStringProductType_WorkflowPermissions]
(	
	@TeamID UNIQUEIDENTIFIER,
	@FolderTypeID INT,
	@ProductTypeID NVARCHAR(200)
)
RETURNS 
	@Workflows TABLE 
	(
		ProductTypeID NVARCHAR(200),
		WorkflowId UNIQUEIDENTIFIER,
		WorkflowName NVARCHAR(200),
		PermissionRoleId INT,
		PermissionView INT,
		PermissionCreate INT,
		PermissionModify INT,
		PermissionRemove INT,
		PermissionDelete INT,
		PermissionPrint INT
	)
AS
BEGIN
	IF @ProductTypeID IS NOT NULL
	BEGIN
		INSERT INTO @Workflows (ProductTypeID, WorkflowId, WorkflowName, PermissionRoleId, PermissionView, PermissionCreate, 
								PermissionModify, PermissionRemove, PermissionDelete, PermissionPrint)
		SELECT @ProductTypeID, workflow.WorkflowId, workflow.PermissionWorkflowName, 
				MAX(workflow.PermissionRoleId), MAX(workflow.PermissionView), MAX(workflow.PermissionCreate), 
				MAX(workflow.PermissionModify), MAX(workflow.PermissionRemove), MAX(workflow.PermissionDelete),
				MAX(workflow.PermissionPrint) 
		FROM sPermissionWorkflow AS workflow
		INNER JOIN sPermissionFolder AS folders ON workflow.PermissionFolderId = folders.PermissionFolderId
		INNER JOIN sPermissionProductTypeMap as ptm ON ptm.PermissionFolderTypeId = folders.PermissionFolderTypeId
		INNER JOIN sPermissionProductType AS pt ON pt.PermissionProductTypeId = workflow.PermissionProductTypeId AND ptm.PermissionProductTypeMapId = pt.PermissionProductTypeMapId
		INNER JOIN uUserGroup AS ugr ON ugr.TeamID = @TeamID
		INNER JOIN uGroup as gr ON gr.GroupID = ugr.GroupID
		WHERE workflow.GroupID = gr.GroupID AND folders.PermissionFolderTypeId = @FolderTypeID
		AND ptm.StrProductTypeId = @ProductTypeID AND pt.PermissionProductTypeNotLocked = 1 
		AND folders.PermissionFolderNotLocked = 1
		GROUP BY workflow.WorkflowId, workflow.PermissionWorkflowName
	END
	ELSE
	BEGIN
		INSERT INTO @Workflows (ProductTypeID, WorkflowId, WorkflowName, PermissionRoleId, PermissionView, PermissionCreate, 
								PermissionModify, PermissionRemove, PermissionDelete, PermissionPrint)
		SELECT ptm.StrProductTypeId, workflow.WorkflowId, workflow.PermissionWorkflowName, 
				MAX(workflow.PermissionRoleId), MAX(workflow.PermissionView), MAX(workflow.PermissionCreate), 
				MAX(workflow.PermissionModify), MAX(workflow.PermissionRemove), MAX(workflow.PermissionDelete),
				MAX(workflow.PermissionPrint) 
		FROM sPermissionWorkflow AS workflow
		INNER JOIN sPermissionFolder AS folders ON workflow.PermissionFolderId = folders.PermissionFolderId
		INNER JOIN sPermissionProductTypeMap as ptm ON ptm.PermissionFolderTypeId = folders.PermissionFolderTypeId
		INNER JOIN sPermissionProductType AS pt ON pt.PermissionProductTypeId = workflow.PermissionProductTypeId AND ptm.PermissionProductTypeMapId = pt.PermissionProductTypeMapId
		INNER JOIN uUserGroup AS ugr ON ugr.TeamID = @TeamID
		INNER JOIN uGroup as gr ON gr.GroupID = ugr.GroupID
		WHERE workflow.GroupID = gr.GroupID AND folders.PermissionFolderTypeId = @FolderTypeID
		AND pt.PermissionProductTypeNotLocked = 1 AND folders.PermissionFolderNotLocked = 1
		GROUP BY ptm.StrProductTypeId, workflow.WorkflowId, workflow.PermissionWorkflowName
	END
	
	RETURN
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08017', GetDate())
GO