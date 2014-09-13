/****** Object:  StoredProcedure [dbo].[spx_Group_FolderPermissions_SELECT]    Script Date: 05/16/2014 18:25:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_FolderPermissions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_FolderPermissions_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_FolderPermissions_SELECT]    Script Date: 05/16/2014 18:25:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_Group_FolderPermissions_SELECT] 
@GroupID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT folderType.PermissionFolderTypeName, folderType.PermissionFolderTypeId, folder.PermissionFolderId, folder.GroupID, folder.PermissionFolderNotLocked, folder.CDate, folder.CUser, folder.MDate, folder.MUser  FROM sPermissionFolderType AS folderType 
INNER JOIN sPermissionFolder AS folder  ON folderType.PermissionFolderTypeId = folder.PermissionFolderTypeId and folder.GroupID = @GroupID ORDER BY folderType.PermissionFolderTypeId
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07648', GetDate())
GO
