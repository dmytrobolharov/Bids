/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetGuidProductType_WorkflowPermissions]    Script Date: 05/16/2014 18:02:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetGuidProductType_WorkflowPermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_Permissions_GetGuidProductType_WorkflowPermissions]
GO
/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetGuidProductTypePermissions]    Script Date: 05/16/2014 18:02:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetGuidProductTypePermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_Permissions_GetGuidProductTypePermissions]
GO
/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetIntProductType_WorkflowPermissions]    Script Date: 05/16/2014 18:02:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetIntProductType_WorkflowPermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_Permissions_GetIntProductType_WorkflowPermissions]
GO
/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetIntProductTypePermissions]    Script Date: 05/16/2014 18:02:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetIntProductTypePermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_Permissions_GetIntProductTypePermissions]
GO
/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetStringProductType_WorkflowPermissions]    Script Date: 05/16/2014 18:02:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetStringProductType_WorkflowPermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_Permissions_GetStringProductType_WorkflowPermissions]
GO
/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetStringProductTypePermissions]    Script Date: 05/16/2014 18:02:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetStringProductTypePermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_Permissions_GetStringProductTypePermissions]
GO
/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetStringProductTypePermissions]    Script Date: 05/16/2014 18:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetStringProductTypePermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[fnx_Permissions_GetStringProductTypePermissions]
(
	@TeamID UNIQUEIDENTIFIER,
	@FolderTypeID INT
)
RETURNS 
	@ProductTypes TABLE
	(
		ProductTypeId NVARCHAR(200),
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

	INSERT INTO @ProductTypes (ProductTypeID, PermissionRoleId, PermissionView, PermissionCreate, PermissionModify, 
								PermissionRemove, PermissionDelete, PermissionPrint)
	SELECT ptm.StrProductTypeId, 
			MAX(workflow.PermissionRoleId), MAX(workflow.PermissionView),MAX(workflow.PermissionCreate), MAX(workflow.PermissionModify),
			MAX(workflow.PermissionRemove), MAX(workflow.PermissionDelete), MAX(workflow.PermissionPrint)
	FROM sPermissionWorkflow AS workflow
	INNER JOIN sPermissionFolder AS folders ON workflow.PermissionFolderId = folders.PermissionFolderId
	INNER JOIN sPermissionProductTypeMap as ptm ON ptm.PermissionFolderTypeId = folders.PermissionFolderTypeId
	INNER JOIN sPermissionProductType AS pt ON pt.PermissionProductTypeId = workflow.PermissionProductTypeId AND ptm.PermissionProductTypeMapId = pt.PermissionProductTypeMapId
	INNER JOIN uUserGroup AS ugr ON ugr.TeamID = @TeamID
	INNER JOIN uGroup as gr ON gr.GroupID = ugr.GroupID
	WHERE workflow.GroupID = gr.GroupID AND folders.PermissionFolderTypeId = @FolderTypeID 
	AND pt.PermissionProductTypeNotLocked = 1 AND folders.PermissionFolderNotLocked = 1 
	GROUP BY ptm.StrProductTypeId
	
	RETURN 
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetStringProductType_WorkflowPermissions]    Script Date: 05/16/2014 18:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetStringProductType_WorkflowPermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[fnx_Permissions_GetStringProductType_WorkflowPermissions]
(	
	@TeamID UNIQUEIDENTIFIER,
	@FolderTypeID INT,
	@ProductTypeID NVARCHAR(200)
)
RETURNS 
	@Workflows TABLE 
	(
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
	INSERT INTO @Workflows (WorkflowId, WorkflowName, PermissionRoleId, PermissionView, PermissionCreate, 
							PermissionModify, PermissionRemove, PermissionDelete, PermissionPrint)
	SELECT workflow.WorkflowId, workflow.PermissionWorkflowName, 
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
	
	RETURN
END' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetIntProductTypePermissions]    Script Date: 05/16/2014 18:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetIntProductTypePermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[fnx_Permissions_GetIntProductTypePermissions]
(
	@TeamID UNIQUEIDENTIFIER,
	@FolderTypeID INT
)
RETURNS 
	@ProductTypes TABLE
	(
		ProductTypeId INT,
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

	INSERT INTO @ProductTypes (ProductTypeID, PermissionRoleId, PermissionView, PermissionCreate, PermissionModify, 
								PermissionRemove, PermissionDelete, PermissionPrint)
	SELECT ptm.IntProductTypeId, 
			MAX(workflow.PermissionRoleId), MAX(workflow.PermissionView),MAX(workflow.PermissionCreate), MAX(workflow.PermissionModify),
			MAX(workflow.PermissionRemove), MAX(workflow.PermissionDelete), MAX(workflow.PermissionPrint)
	FROM sPermissionWorkflow AS workflow
	INNER JOIN sPermissionFolder AS folders ON workflow.PermissionFolderId = folders.PermissionFolderId
	INNER JOIN sPermissionProductTypeMap as ptm ON ptm.PermissionFolderTypeId = folders.PermissionFolderTypeId
	INNER JOIN sPermissionProductType AS pt ON pt.PermissionProductTypeId = workflow.PermissionProductTypeId AND ptm.PermissionProductTypeMapId = pt.PermissionProductTypeMapId
	INNER JOIN uUserGroup AS ugr ON ugr.TeamID = @TeamID
	INNER JOIN uGroup as gr ON gr.GroupID = ugr.GroupID
	WHERE workflow.GroupID = gr.GroupID AND folders.PermissionFolderTypeId = @FolderTypeID 
	AND pt.PermissionProductTypeNotLocked = 1 AND folders.PermissionFolderNotLocked = 1 
	GROUP BY ptm.IntProductTypeId
	
	RETURN 
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetIntProductType_WorkflowPermissions]    Script Date: 05/16/2014 18:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetIntProductType_WorkflowPermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[fnx_Permissions_GetIntProductType_WorkflowPermissions]
(	
	@TeamID UNIQUEIDENTIFIER,
	@FolderTypeID INT,
	@ProductTypeID INT
)
RETURNS 
	@Workflows TABLE 
	(
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
	INSERT INTO @Workflows (WorkflowId, WorkflowName, PermissionRoleId, PermissionView, PermissionCreate, 
							PermissionModify, PermissionRemove, PermissionDelete, PermissionPrint)
	SELECT workflow.WorkflowId, workflow.PermissionWorkflowName, 
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
	AND ptm.IntProductTypeId = @ProductTypeID AND pt.PermissionProductTypeNotLocked = 1 
	AND folders.PermissionFolderNotLocked = 1
	GROUP BY workflow.WorkflowId, workflow.PermissionWorkflowName
	
	RETURN
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetGuidProductTypePermissions]    Script Date: 05/16/2014 18:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetGuidProductTypePermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[fnx_Permissions_GetGuidProductTypePermissions]
(
	@TeamID UNIQUEIDENTIFIER,
	@FolderTypeID INT
)
RETURNS 
	@ProductTypes TABLE
	(
		ProductTypeId UNIQUEIDENTIFIER,
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

	INSERT INTO @ProductTypes (ProductTypeId, PermissionRoleId, PermissionView, PermissionCreate, PermissionModify, 
								PermissionRemove, PermissionDelete, PermissionPrint)
	SELECT ptm.GuidProductTypeId, 
			MAX(workflow.PermissionRoleId), MAX(workflow.PermissionView),MAX(workflow.PermissionCreate), MAX(workflow.PermissionModify),
			MAX(workflow.PermissionRemove), MAX(workflow.PermissionDelete), MAX(workflow.PermissionPrint)
	FROM sPermissionWorkflow AS workflow
	INNER JOIN sPermissionFolder AS folders ON workflow.PermissionFolderId = folders.PermissionFolderId
	INNER JOIN sPermissionProductTypeMap as ptm ON ptm.PermissionFolderTypeId = folders.PermissionFolderTypeId
	INNER JOIN sPermissionProductType AS pt ON pt.PermissionProductTypeId = workflow.PermissionProductTypeId AND ptm.PermissionProductTypeMapId = pt.PermissionProductTypeMapId
	INNER JOIN uUserGroup AS ugr ON ugr.TeamID = @TeamID
	INNER JOIN uGroup as gr ON gr.GroupID = ugr.GroupID
	WHERE workflow.GroupID = gr.GroupID AND folders.PermissionFolderTypeId = @FolderTypeID 
	AND pt.PermissionProductTypeNotLocked = 1 AND folders.PermissionFolderNotLocked = 1 
	GROUP BY ptm.GuidProductTypeId
	
	RETURN 
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetGuidProductType_WorkflowPermissions]    Script Date: 05/16/2014 18:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetGuidProductType_WorkflowPermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[fnx_Permissions_GetGuidProductType_WorkflowPermissions]
(	
	@TeamID UNIQUEIDENTIFIER,
	@FolderTypeID INT,
	@ProductTypeID UNIQUEIDENTIFIER
)
RETURNS 
	@Workflows TABLE 
	(
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
	INSERT INTO @Workflows (WorkflowId, WorkflowName, PermissionRoleId, PermissionView, PermissionCreate, 
							PermissionModify, PermissionRemove, PermissionDelete, PermissionPrint)
	SELECT workflow.WorkflowId, workflow.PermissionWorkflowName, 
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
	AND ptm.GuidProductTypeId = @ProductTypeID AND pt.PermissionProductTypeNotLocked = 1 
	AND folders.PermissionFolderNotLocked = 1
	GROUP BY workflow.WorkflowId, workflow.PermissionWorkflowName
	
	RETURN
END' 
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07639', GetDate())
GO