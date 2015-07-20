/****** Object:  StoredProcedure [dbo].[spx_IsMigratePossible]    Script Date: 07/30/2014 14:44:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_IsMigratePossible]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_IsMigratePossible]
GO

/****** Object:  StoredProcedure [dbo].[spx_IsMigratePossible]    Script Date: 07/30/2014 14:44:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_IsMigratePossible]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[sPermissionFolder]') AND type in (N'U'))
AND  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[sPermissionFolderType]') AND type in (N'U'))
AND  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[sPermissionProductType]') AND type in (N'U'))
AND  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[sPermissionProductTypeMap]') AND type in (N'U'))
AND  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[sPermissionRole]') AND type in (N'U'))
AND  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[sPermissionWorkflow]')  AND type in (N'U'))

AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_FillTablesNewPermissions]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Permissions_WorkflowsGrouping_UPDATE]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionProductType_UPDATE]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionProductType_INSERT]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionWorkflow_UPDATE]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionWorkflow_INSERT]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionProductTypeMap_INSERT]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionProductTypeMap_UPDATE]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Access_ByIntProductTypeId_TeamId_FolderTypeId_WorkflowId]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Access_ByGuidProductTypeId_TeamId_FolderTypeId_WorkflowId]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Access_ByIntProductTypeId_TeamId_FolderTypeId]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Access_ByGuidProductTypeId_TeamId_FolderTypeId]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Access_ByFolderId_TeamId]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Access_ByFolderTypeId_TeamId]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Access_ByFolderId_GroupId]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Access_ByFolderTypeId_GroupId]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_FolderPermissions_SELECT]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_ProductPermissionsOnFolder_SELECT]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_OverFlowPermissionsOnProduct_SELECT]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_GuidProductPermissions_SELECT]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Permissions_GetProductTypePermissions]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Folder_Permissions_SELECT]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_OverFlowPermissionsOnProductOnID_SELECT]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionProductTypeWorkflow_UPDATE]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_GetGuidGroupOnName]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionWorkflowOnly_UPDATE]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionRole_INSERT]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionRole_UPDATE]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionProductType_INSERT]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionFolderType_INSERT]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionFolderType_UPDATE]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionFolder_UPDATE]') AND type in (N'P', N'PC'))
AND EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CopyPermissions_BetweenGroups]') AND type in (N'P', N'PC'))

AND  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetIntProductTypePermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
AND  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetGuidProductTypePermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
AND  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetStringProductTypePermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
AND  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetFolderPermissionsProductType]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))

AND  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Group_Join_Users_SELECT]'))

SELECT 1
ELSE SELECT 0
   
END

GO





INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08472', GetDate())
GO
