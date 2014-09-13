/****** Object:  StoredProcedure [dbo].[spx_FillTablesNewPermissions]    Script Date: 06/18/2014 16:39:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_FillTablesNewPermissions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_FillTablesNewPermissions]
GO

/****** Object:  StoredProcedure [dbo].[spx_FillTablesNewPermissions]    Script Date: 06/18/2014 16:39:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_FillTablesNewPermissions]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- Creating FolderType records for all existing folders in the system
	INSERT INTO sPermissionFolderType (PermissionFolderTypeId, PermissionFolderTypeName, Active) 
	SELECT df.DeskFolderId, df.DeskFolderName, 1
	FROM cDesktopFolder AS df
	WHERE NOT EXISTS (SELECT * FROM sPermissionFolderType AS ft WHERE ft.PermissionFolderTypeId = df.DeskFolderId)

	-- Updating locked/unlocked folders, in case there are any folders in the system already
	UPDATE sPermissionFolder
	SET PermissionFolderNotLocked = ISNULL(
	(
		SELECT dgfa.DeskAccessId FROM cDeskGroupFolderAccess dgfa 
		WHERE dgfa.GroupID = sPermissionFolder.GroupID AND dgfa.DeskFolderId = sPermissionFolder.PermissionFolderTypeId
	), 0)

	-- Generating PermissionFolders for each group and each folder type in the system
	INSERT INTO sPermissionFolder (PermissionFolderTypeId, GroupID, CDate,CUser,MDate,MUser, PermissionFolderNotLocked) 
	SELECT folderType.PermissionFolderTypeId, gr.GroupID, ISNULL(dgfa.CDate, CURRENT_TIMESTAMP), ISNULL(dgfa.CUser, 'Administrator'), 
	ISNULL(dgfa.MDate, CURRENT_TIMESTAMP), ISNULL(dgfa.MUser, 'Administrator'), ISNULL(dgfa.DeskAccessId, 0)
	FROM sPermissionFolderType AS folderType
	CROSS JOIN uGroup AS gr
	LEFT JOIN cDeskGroupFolderAccess AS dgfa ON gr.GroupID = dgfa.GroupID AND dgfa.DeskFolderId = folderType.PermissionFolderTypeId
	WHERE NOT EXISTS (SELECT * FROM sPermissionFolder AS f WHERE f.GroupId = gr.GroupID AND f.PermissionFolderTypeId = folderType.PermissionFolderTypeId)

	-- Creating roles, if none exists
	IF NOT EXISTS(SELECT * FROM sPermissionRole)
	BEGIN
		INSERT INTO sPermissionRole(PermissionRoleId,PermissionRoleCode,PermissionRoleName) VALUES(3,NULL,NULL)
		INSERT INTO sPermissionRole(PermissionRoleId,PermissionRoleCode,PermissionRoleName) VALUES(2,NULL,NULL)
		INSERT INTO sPermissionRole(PermissionRoleId,PermissionRoleCode,PermissionRoleName) VALUES(1,NULL,NULL)
		INSERT INTO sPermissionRole(PermissionRoleId,PermissionRoleCode,PermissionRoleName) VALUES(0,NULL,NULL)
	END

END




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08039', GetDate())
GO
